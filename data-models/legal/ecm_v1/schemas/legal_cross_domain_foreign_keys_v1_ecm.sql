-- Cross-Domain Foreign Keys for Business: Legal | Version: v1_ecm
-- Generated on: 2026-05-07 11:59:03
-- Total cross-domain FK constraints: 1410
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, client, compliance, conflict, contract, court, document, intake, ip, knowledge, matter, risk, service, trust, workforce

-- ========= billing --> client (22 constraint(s)) =========
-- Requires: billing schema, client schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= billing --> compliance (10 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);

-- ========= billing --> contract (5 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= billing --> document (7 constraint(s)) =========
-- Requires: billing schema, document schema
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= billing --> intake (3 constraint(s)) =========
-- Requires: billing schema, intake schema
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= billing --> ip (2 constraint(s)) =========
-- Requires: billing schema, ip schema
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= billing --> matter (39 constraint(s)) =========
-- Requires: billing schema, matter schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `legal_ecm`.`matter`.`filing`(`filing_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_prebill_matter_id` FOREIGN KEY (`prebill_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_retainer_matter_id` FOREIGN KEY (`retainer_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_primary_ledes_matter_id` FOREIGN KEY (`primary_ledes_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= billing --> risk (3 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= billing --> service (13 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= billing --> trust (4 constraint(s)) =========
-- Requires: billing schema, trust schema
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= billing --> workforce (36 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_primary_wip_timekeeper_id` FOREIGN KEY (`primary_wip_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_tertiary_wip_approved_by_timekeeper_id` FOREIGN KEY (`tertiary_wip_approved_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_prebill_approved_by_attorney_timekeeper_id` FOREIGN KEY (`prebill_approved_by_attorney_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_prebill_timekeeper_id` FOREIGN KEY (`prebill_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_fee_arrangement` ADD CONSTRAINT `fk_billing_billing_fee_arrangement_billing_timekeeper_id` FOREIGN KEY (`billing_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_primary_ar_timekeeper_id` FOREIGN KEY (`primary_ar_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_primary_write_timekeeper_id` FOREIGN KEY (`primary_write_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_quaternary_collection_write_off_approver_timekeeper_id` FOREIGN KEY (`quaternary_collection_write_off_approver_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_tertiary_collection_responsible_partner_timekeeper_id` FOREIGN KEY (`tertiary_collection_responsible_partner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_quaternary_invoice_write_off_approver_timekeeper_id` FOREIGN KEY (`quaternary_invoice_write_off_approver_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_tertiary_invoice_responsible_partner_timekeeper_id` FOREIGN KEY (`tertiary_invoice_responsible_partner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`ledes_submission` ADD CONSTRAINT `fk_billing_ledes_submission_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_office` ADD CONSTRAINT `fk_billing_billing_office_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_period` ADD CONSTRAINT `fk_billing_billing_period_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_period` ADD CONSTRAINT `fk_billing_billing_period_locked_by_user_id` FOREIGN KEY (`locked_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);

-- ========= client --> compliance (7 constraint(s)) =========
-- Requires: client schema, compliance schema
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);

-- ========= client --> document (3 constraint(s)) =========
-- Requires: client schema, document schema
ALTER TABLE `legal_ecm`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`client`.`document_access` ADD CONSTRAINT `fk_client_document_access_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_document_verification` ADD CONSTRAINT `fk_client_kyc_document_verification_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= client --> ip (2 constraint(s)) =========
-- Requires: client schema, ip schema
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_ownership_id` FOREIGN KEY (`ownership_id`) REFERENCES `legal_ecm`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm`.`client`.`ip_beneficial_ownership` ADD CONSTRAINT `fk_client_ip_beneficial_ownership_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= client --> matter (2 constraint(s)) =========
-- Requires: client schema, matter schema
ALTER TABLE `legal_ecm`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= client --> service (4 constraint(s)) =========
-- Requires: client schema, service schema
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`client`.`service_engagement` ADD CONSTRAINT `fk_client_service_engagement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`client`.`subscription` ADD CONSTRAINT `fk_client_subscription_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);

-- ========= client --> workforce (16 constraint(s)) =========
-- Requires: client schema, workforce schema
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_profile_timekeeper_id` FOREIGN KEY (`profile_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_document` ADD CONSTRAINT `fk_client_kyc_document_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`segment` ADD CONSTRAINT `fk_client_segment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ADD CONSTRAINT `fk_client_relationship_team_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`client_engagement_scope` ADD CONSTRAINT `fk_client_client_engagement_scope_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`client`.`client_status_history` ADD CONSTRAINT `fk_client_client_status_history_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`client`.`credit_standing` ADD CONSTRAINT `fk_client_credit_standing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`service_engagement` ADD CONSTRAINT `fk_client_service_engagement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`subscription` ADD CONSTRAINT `fk_client_subscription_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`document_access` ADD CONSTRAINT `fk_client_document_access_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`document_access` ADD CONSTRAINT `fk_client_document_access_shared_by_timekeeper_id` FOREIGN KEY (`shared_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_document_verification` ADD CONSTRAINT `fk_client_kyc_document_verification_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= compliance --> client (8 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`policy_acknowledgement` ADD CONSTRAINT `fk_compliance_policy_acknowledgement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= compliance --> document (7 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= compliance --> ip (4 constraint(s)) =========
-- Requires: compliance schema, ip schema
ALTER TABLE `legal_ecm`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_ownership_id` FOREIGN KEY (`ownership_id`) REFERENCES `legal_ecm`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= compliance --> knowledge (1 constraint(s)) =========
-- Requires: compliance schema, knowledge schema
ALTER TABLE `legal_ecm`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);

-- ========= compliance --> matter (6 constraint(s)) =========
-- Requires: compliance schema, matter schema
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= compliance --> risk (7 constraint(s)) =========
-- Requires: compliance schema, risk schema
ALTER TABLE `legal_ecm`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= compliance --> service (14 constraint(s)) =========
-- Requires: compliance schema, service schema
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ADD CONSTRAINT `fk_compliance_control_framework_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ADD CONSTRAINT `fk_compliance_aml_kyc_program_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`aml_risk_assessment` ADD CONSTRAINT `fk_compliance_aml_risk_assessment_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= compliance --> workforce (31 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ADD CONSTRAINT `fk_compliance_control_framework_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_last_modified_by_user_id` FOREIGN KEY (`last_modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`compliance`.`privacy_breach` ADD CONSTRAINT `fk_compliance_privacy_breach_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_return` ADD CONSTRAINT `fk_compliance_regulatory_return_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control_test` ADD CONSTRAINT `fk_compliance_compliance_control_test_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_breach` ADD CONSTRAINT `fk_compliance_regulatory_breach_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`training_programme` ADD CONSTRAINT `fk_compliance_training_programme_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_implementation_owner_timekeeper_id` FOREIGN KEY (`implementation_owner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_lead_auditor_timekeeper_id` FOREIGN KEY (`lead_auditor_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_responsible_officer_employee_timekeeper_id` FOREIGN KEY (`responsible_officer_employee_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_action_owner_timekeeper_id` FOREIGN KEY (`action_owner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_auditor_employee_timekeeper_id` FOREIGN KEY (`auditor_employee_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_department_id` FOREIGN KEY (`department_id`) REFERENCES `legal_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_lead_auditor_employee_id` FOREIGN KEY (`lead_auditor_employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= conflict --> billing (2 constraint(s)) =========
-- Requires: conflict schema, billing schema
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_billing_fee_arrangement_id` FOREIGN KEY (`billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`billing_fee_arrangement`(`billing_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);

-- ========= conflict --> client (7 constraint(s)) =========
-- Requires: conflict schema, client schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= conflict --> compliance (33 constraint(s)) =========
-- Requires: conflict schema, compliance schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_training_programme_id` FOREIGN KEY (`training_programme_id`) REFERENCES `legal_ecm`.`compliance`.`training_programme`(`training_programme_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_aml_risk_assessment_id` FOREIGN KEY (`aml_risk_assessment_id`) REFERENCES `legal_ecm`.`compliance`.`aml_risk_assessment`(`aml_risk_assessment_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `legal_ecm`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `legal_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `legal_ecm`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_training_programme_id` FOREIGN KEY (`training_programme_id`) REFERENCES `legal_ecm`.`compliance`.`training_programme`(`training_programme_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);

-- ========= conflict --> contract (1 constraint(s)) =========
-- Requires: conflict schema, contract schema
ALTER TABLE `legal_ecm`.`conflict`.`wall_enforcement` ADD CONSTRAINT `fk_conflict_wall_enforcement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= conflict --> document (2 constraint(s)) =========
-- Requires: conflict schema, document schema
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= conflict --> intake (3 constraint(s)) =========
-- Requires: conflict schema, intake schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);

-- ========= conflict --> ip (8 constraint(s)) =========
-- Requires: conflict schema, ip schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_ownership_id` FOREIGN KEY (`ownership_id`) REFERENCES `legal_ecm`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= conflict --> knowledge (7 constraint(s)) =========
-- Requires: conflict schema, knowledge schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);

-- ========= conflict --> matter (15 constraint(s)) =========
-- Requires: conflict schema, matter schema
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`conflict`.`relationship_map` ADD CONSTRAINT `fk_conflict_relationship_map_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`party_judge_appearance` ADD CONSTRAINT `fk_conflict_party_judge_appearance_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= conflict --> risk (11 constraint(s)) =========
-- Requires: conflict schema, risk schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_reputational_risk_id` FOREIGN KEY (`reputational_risk_id`) REFERENCES `legal_ecm`.`risk`.`reputational_risk`(`reputational_risk_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= conflict --> service (9 constraint(s)) =========
-- Requires: conflict schema, service schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_exception` ADD CONSTRAINT `fk_conflict_conflict_exception_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`party_practice_conflict` ADD CONSTRAINT `fk_conflict_party_practice_conflict_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= conflict --> trust (1 constraint(s)) =========
-- Requires: conflict schema, trust schema
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= conflict --> workforce (36 constraint(s)) =========
-- Requires: conflict schema, workforce schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_check_supervising_partner_timekeeper_id` FOREIGN KEY (`check_supervising_partner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_check_timekeeper_id` FOREIGN KEY (`check_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_primary_reviewer_timekeeper_id` FOREIGN KEY (`primary_reviewer_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_last_modified_by_user_timekeeper_id` FOREIGN KEY (`clearance_last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_responsible_party_timekeeper_id` FOREIGN KEY (`clearance_responsible_party_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_reviewing_counsel_timekeeper_id` FOREIGN KEY (`clearance_reviewing_counsel_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_clearance_timekeeper_id` FOREIGN KEY (`clearance_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_approving_partner_timekeeper_id` FOREIGN KEY (`waiver_approving_partner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_conflicts_counsel_timekeeper_id` FOREIGN KEY (`waiver_conflicts_counsel_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_waiver_timekeeper_id` FOREIGN KEY (`waiver_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_primary_wall_timekeeper_id` FOREIGN KEY (`primary_wall_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_tertiary_wall_reviewed_by_partner_timekeeper_id` FOREIGN KEY (`tertiary_wall_reviewed_by_partner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_lateral_candidate_id` FOREIGN KEY (`lateral_candidate_id`) REFERENCES `legal_ecm`.`workforce`.`lateral_candidate`(`lateral_candidate_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`lateral_screening` ADD CONSTRAINT `fk_conflict_lateral_screening_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`party_alias` ADD CONSTRAINT `fk_conflict_party_alias_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_actor_timekeeper_id` FOREIGN KEY (`actor_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_log` ADD CONSTRAINT `fk_conflict_audit_log_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`conflict`.`matter_party_role` ADD CONSTRAINT `fk_conflict_matter_party_role_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_escalated_to_user_id` FOREIGN KEY (`escalated_to_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_initiated_by_user_id` FOREIGN KEY (`initiated_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_last_modified_by_user_id` FOREIGN KEY (`last_modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`conflict`.`audit_session` ADD CONSTRAINT `fk_conflict_audit_session_reviewer_user_id` FOREIGN KEY (`reviewer_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);

-- ========= contract --> client (10 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= contract --> compliance (10 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `legal_ecm`.`compliance`.`dpia`(`dpia_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);

-- ========= contract --> conflict (6 constraint(s)) =========
-- Requires: contract schema, conflict schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= contract --> document (8 constraint(s)) =========
-- Requires: contract schema, document schema
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_amendment_legal_document_id` FOREIGN KEY (`amendment_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= contract --> intake (7 constraint(s)) =========
-- Requires: contract schema, intake schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_intake_fee_arrangement_id` FOREIGN KEY (`intake_fee_arrangement_id`) REFERENCES `legal_ecm`.`intake`.`intake_fee_arrangement`(`intake_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= contract --> ip (1 constraint(s)) =========
-- Requires: contract schema, ip schema
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= contract --> knowledge (13 constraint(s)) =========
-- Requires: contract schema, knowledge schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);

-- ========= contract --> matter (15 constraint(s)) =========
-- Requires: contract schema, matter schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= contract --> risk (4 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= contract --> service (8 constraint(s)) =========
-- Requires: contract schema, service schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);

-- ========= contract --> workforce (29 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_agreement` ADD CONSTRAINT `fk_contract_contract_agreement_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_actor_timekeeper_id` FOREIGN KEY (`actor_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_amendment_prepared_by_timekeeper_id` FOREIGN KEY (`amendment_prepared_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`negotiation_round` ADD CONSTRAINT `fk_contract_negotiation_round_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_deviation` ADD CONSTRAINT `fk_contract_clause_deviation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_primary_afa_attorney_profile_id` FOREIGN KEY (`primary_afa_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`afa_arrangement` ADD CONSTRAINT `fk_contract_afa_arrangement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement_type_clause_policy` ADD CONSTRAINT `fk_contract_agreement_type_clause_policy_last_modified_by_attorney_profile_id` FOREIGN KEY (`last_modified_by_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);

-- ========= court --> client (3 constraint(s)) =========
-- Requires: court schema, client schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= court --> compliance (7 constraint(s)) =========
-- Requires: court schema, compliance schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);

-- ========= court --> document (2 constraint(s)) =========
-- Requires: court schema, document schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= court --> knowledge (3 constraint(s)) =========
-- Requires: court schema, knowledge schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);

-- ========= court --> matter (3 constraint(s)) =========
-- Requires: court schema, matter schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= court --> risk (2 constraint(s)) =========
-- Requires: court schema, risk schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);

-- ========= court --> trust (3 constraint(s)) =========
-- Requires: court schema, trust schema
ALTER TABLE `legal_ecm`.`court`.`service_of_process` ADD CONSTRAINT `fk_court_service_of_process_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm`.`court`.`adr_proceeding` ADD CONSTRAINT `fk_court_adr_proceeding_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= document --> billing (1 constraint(s)) =========
-- Requires: document schema, billing schema
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_billing_disbursement_id` FOREIGN KEY (`billing_disbursement_id`) REFERENCES `legal_ecm`.`billing`.`billing_disbursement`(`billing_disbursement_id`);

-- ========= document --> client (6 constraint(s)) =========
-- Requires: document schema, client schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= document --> compliance (12 constraint(s)) =========
-- Requires: document schema, compliance schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= document --> contract (11 constraint(s)) =========
-- Requires: document schema, contract schema
ALTER TABLE `legal_ecm`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= document --> ip (15 constraint(s)) =========
-- Requires: document schema, ip schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_trade_secret_id` FOREIGN KEY (`trade_secret_id`) REFERENCES `legal_ecm`.`ip`.`trade_secret`(`trade_secret_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `legal_ecm`.`ip`.`trademark`(`trademark_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_inventor_id` FOREIGN KEY (`inventor_id`) REFERENCES `legal_ecm`.`ip`.`inventor`(`inventor_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= document --> knowledge (4 constraint(s)) =========
-- Requires: document schema, knowledge schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`document`.`template_clause_usage` ADD CONSTRAINT `fk_document_template_clause_usage_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);

-- ========= document --> matter (29 constraint(s)) =========
-- Requires: document schema, matter schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_ediscovery_case_matter_id` FOREIGN KEY (`ediscovery_case_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`family_group` ADD CONSTRAINT `fk_document_family_group_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_team_id` FOREIGN KEY (`team_id`) REFERENCES `legal_ecm`.`matter`.`team`(`team_id`);
ALTER TABLE `legal_ecm`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_case_matter_id` FOREIGN KEY (`case_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`production_batch` ADD CONSTRAINT `fk_document_production_batch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= document --> risk (10 constraint(s)) =========
-- Requires: document schema, risk schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);

-- ========= document --> service (10 constraint(s)) =========
-- Requires: document schema, service schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);

-- ========= document --> trust (7 constraint(s)) =========
-- Requires: document schema, trust schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_escrow_release_id` FOREIGN KEY (`escrow_release_id`) REFERENCES `legal_ecm`.`trust`.`escrow_release`(`escrow_release_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);

-- ========= document --> workforce (37 constraint(s)) =========
-- Requires: document schema, workforce schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_annotation` ADD CONSTRAINT `fk_document_doc_annotation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_access_event` ADD CONSTRAINT `fk_document_doc_access_event_user_timekeeper_id` FOREIGN KEY (`user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_relationship` ADD CONSTRAINT `fk_document_doc_relationship_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`template_clause_usage` ADD CONSTRAINT `fk_document_template_clause_usage_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm`.`document`.`review_set` ADD CONSTRAINT `fk_document_review_set_modified_by_user_id` FOREIGN KEY (`modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm`.`document`.`review_session` ADD CONSTRAINT `fk_document_review_session_modified_by_user_id` FOREIGN KEY (`modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_modified_by_user_id` FOREIGN KEY (`modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`execution_workflow` ADD CONSTRAINT `fk_document_execution_workflow_owner_user_id` FOREIGN KEY (`owner_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_modified_by_user_id` FOREIGN KEY (`modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_office_id` FOREIGN KEY (`office_id`) REFERENCES `legal_ecm`.`workforce`.`office`(`office_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_originating_attorney_attorney_profile_id` FOREIGN KEY (`originating_attorney_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`document`.`workspace` ADD CONSTRAINT `fk_document_workspace_owner_user_id` FOREIGN KEY (`owner_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm`.`document`.`review_batch` ADD CONSTRAINT `fk_document_review_batch_last_modified_by_user_id` FOREIGN KEY (`last_modified_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);

-- ========= intake --> billing (4 constraint(s)) =========
-- Requires: intake schema, billing schema
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_billing_fee_arrangement_id` FOREIGN KEY (`billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`billing_fee_arrangement`(`billing_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_billing_fee_arrangement_id` FOREIGN KEY (`billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`billing_fee_arrangement`(`billing_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_billing_fee_arrangement_id` FOREIGN KEY (`billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`billing_fee_arrangement`(`billing_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `legal_ecm`.`billing`.`guideline`(`guideline_id`);

-- ========= intake --> client (14 constraint(s)) =========
-- Requires: intake schema, client schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_client_engagement_scope_id` FOREIGN KEY (`client_engagement_scope_id`) REFERENCES `legal_ecm`.`client`.`client_engagement_scope`(`client_engagement_scope_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= intake --> compliance (14 constraint(s)) =========
-- Requires: intake schema, compliance schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= intake --> conflict (3 constraint(s)) =========
-- Requires: intake schema, conflict schema
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= intake --> document (10 constraint(s)) =========
-- Requires: intake schema, document schema
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_pitch_proposal_legal_document_id` FOREIGN KEY (`pitch_proposal_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= intake --> knowledge (7 constraint(s)) =========
-- Requires: intake schema, knowledge schema
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);

-- ========= intake --> matter (9 constraint(s)) =========
-- Requires: intake schema, matter schema
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_task_id` FOREIGN KEY (`task_id`) REFERENCES `legal_ecm`.`matter`.`task`(`task_id`);

-- ========= intake --> risk (11 constraint(s)) =========
-- Requires: intake schema, risk schema
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_reputational_risk_id` FOREIGN KEY (`reputational_risk_id`) REFERENCES `legal_ecm`.`risk`.`reputational_risk`(`reputational_risk_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ADD CONSTRAINT `fk_intake_risk_action_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);

-- ========= intake --> service (6 constraint(s)) =========
-- Requires: intake schema, service schema
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);

-- ========= intake --> workforce (53 constraint(s)) =========
-- Requires: intake schema, workforce schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_prospect_attorney_profile_id` FOREIGN KEY (`prospect_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_primary_engagement_attorney_profile_id` FOREIGN KEY (`primary_engagement_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_request_approved_by_partner_attorney_profile_id` FOREIGN KEY (`request_approved_by_partner_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_request_attorney_profile_id` FOREIGN KEY (`request_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_requesting_timekeeper_id` FOREIGN KEY (`requesting_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_tertiary_conflict_escalated_to_attorney_profile_id` FOREIGN KEY (`tertiary_conflict_escalated_to_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_primary_letter_attorney_profile_id` FOREIGN KEY (`primary_letter_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_originating_attorney_attorney_profile_id` FOREIGN KEY (`originating_attorney_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_primary_matter_attorney_profile_id` FOREIGN KEY (`primary_matter_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_tertiary_matter_approved_by_attorney_attorney_profile_id` FOREIGN KEY (`tertiary_matter_approved_by_attorney_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_primary_origination_credited_timekeeper_id` FOREIGN KEY (`primary_origination_credited_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_completed_by_user_timekeeper_id` FOREIGN KEY (`completed_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_escalated_to_user_timekeeper_id` FOREIGN KEY (`escalated_to_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_waived_by_user_timekeeper_id` FOREIGN KEY (`waived_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_primary_referral_attorney_profile_id` FOREIGN KEY (`primary_referral_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ADD CONSTRAINT `fk_intake_risk_action_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);

-- ========= ip --> billing (1 constraint(s)) =========
-- Requires: ip schema, billing schema
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= ip --> client (16 constraint(s)) =========
-- Requires: ip schema, client schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ADD CONSTRAINT `fk_ip_asset_contact_assignment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_licensor_organisation_id` FOREIGN KEY (`licensor_organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);

-- ========= ip --> compliance (15 constraint(s)) =========
-- Requires: ip schema, compliance schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);

-- ========= ip --> document (2 constraint(s)) =========
-- Requires: ip schema, document schema
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= ip --> intake (7 constraint(s)) =========
-- Requires: ip schema, intake schema
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_pitch_id` FOREIGN KEY (`pitch_id`) REFERENCES `legal_ecm`.`intake`.`pitch`(`pitch_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_intake_engagement_scope_id` FOREIGN KEY (`intake_engagement_scope_id`) REFERENCES `legal_ecm`.`intake`.`intake_engagement_scope`(`intake_engagement_scope_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_panel_appointment_id` FOREIGN KEY (`panel_appointment_id`) REFERENCES `legal_ecm`.`intake`.`panel_appointment`(`panel_appointment_id`);

-- ========= ip --> knowledge (9 constraint(s)) =========
-- Requires: ip schema, knowledge schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ADD CONSTRAINT `fk_ip_asset_precedent_usage_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);

-- ========= ip --> matter (22 constraint(s)) =========
-- Requires: ip schema, matter schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= ip --> risk (15 constraint(s)) =========
-- Requires: ip schema, risk schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_third_party_risk_id` FOREIGN KEY (`third_party_risk_id`) REFERENCES `legal_ecm`.`risk`.`third_party_risk`(`third_party_risk_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_reputational_risk_id` FOREIGN KEY (`reputational_risk_id`) REFERENCES `legal_ecm`.`risk`.`reputational_risk`(`reputational_risk_id`);

-- ========= ip --> service (10 constraint(s)) =========
-- Requires: ip schema, service schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);

-- ========= ip --> trust (7 constraint(s)) =========
-- Requires: ip schema, trust schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `legal_ecm`.`trust`.`receipt`(`receipt_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= ip --> workforce (36 constraint(s)) =========
-- Requires: ip schema, workforce schema
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ADD CONSTRAINT `fk_ip_ip_asset_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ADD CONSTRAINT `fk_ip_ip_agreement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ADD CONSTRAINT `fk_ip_patent_prosecution_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= knowledge --> client (3 constraint(s)) =========
-- Requires: knowledge schema, client schema
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= knowledge --> compliance (11 constraint(s)) =========
-- Requires: knowledge schema, compliance schema
ALTER TABLE `legal_ecm`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= knowledge --> document (5 constraint(s)) =========
-- Requires: knowledge schema, document schema
ALTER TABLE `legal_ecm`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= knowledge --> matter (4 constraint(s)) =========
-- Requires: knowledge schema, matter schema
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= knowledge --> risk (10 constraint(s)) =========
-- Requires: knowledge schema, risk schema
ALTER TABLE `legal_ecm`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`control_mapping` ADD CONSTRAINT `fk_knowledge_control_mapping_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_risk_mitigation` ADD CONSTRAINT `fk_knowledge_precedent_risk_mitigation_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_risk_mitigation` ADD CONSTRAINT `fk_knowledge_precedent_risk_mitigation_risk_category_id` FOREIGN KEY (`risk_category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);

-- ========= knowledge --> service (8 constraint(s)) =========
-- Requires: knowledge schema, service schema
ALTER TABLE `legal_ecm`.`knowledge`.`precedent` ADD CONSTRAINT `fk_knowledge_precedent_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`practice_note` ADD CONSTRAINT `fk_knowledge_practice_note_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`form_template` ADD CONSTRAINT `fk_knowledge_form_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`checklist` ADD CONSTRAINT `fk_knowledge_checklist_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= knowledge --> workforce (15 constraint(s)) =========
-- Requires: knowledge schema, workforce schema
ALTER TABLE `legal_ecm`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`clause` ADD CONSTRAINT `fk_knowledge_clause_clause_author_timekeeper_id` FOREIGN KEY (`clause_author_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_memo` ADD CONSTRAINT `fk_knowledge_research_memo_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`expertise_directory` ADD CONSTRAINT `fk_knowledge_expertise_directory_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`expertise_directory` ADD CONSTRAINT `fk_knowledge_expertise_directory_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`knowledge_asset` ADD CONSTRAINT `fk_knowledge_knowledge_asset_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`asset_usage` ADD CONSTRAINT `fk_knowledge_asset_usage_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`precedent_update` ADD CONSTRAINT `fk_knowledge_precedent_update_primary_precedent_timekeeper_id` FOREIGN KEY (`primary_precedent_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`contribution` ADD CONSTRAINT `fk_knowledge_contribution_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`research_request` ADD CONSTRAINT `fk_knowledge_research_request_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`legal_update` ADD CONSTRAINT `fk_knowledge_legal_update_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`knowledge`.`control_mapping` ADD CONSTRAINT `fk_knowledge_control_mapping_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= matter --> billing (3 constraint(s)) =========
-- Requires: matter schema, billing schema
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `legal_ecm`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_billing_fee_arrangement_id` FOREIGN KEY (`billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`billing_fee_arrangement`(`billing_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= matter --> client (19 constraint(s)) =========
-- Requires: matter schema, client schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_client_engagement_scope_id` FOREIGN KEY (`client_engagement_scope_id`) REFERENCES `legal_ecm`.`client`.`client_engagement_scope`(`client_engagement_scope_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`counsel` ADD CONSTRAINT `fk_matter_counsel_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ADD CONSTRAINT `fk_matter_matter_contact_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);

-- ========= matter --> compliance (23 constraint(s)) =========
-- Requires: matter schema, compliance schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_privacy_breach_id` FOREIGN KEY (`privacy_breach_id`) REFERENCES `legal_ecm`.`compliance`.`privacy_breach`(`privacy_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);

-- ========= matter --> conflict (2 constraint(s)) =========
-- Requires: matter schema, conflict schema
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ADD CONSTRAINT `fk_matter_lateral_conflict_lateral_screening_id` FOREIGN KEY (`lateral_screening_id`) REFERENCES `legal_ecm`.`conflict`.`lateral_screening`(`lateral_screening_id`);

-- ========= matter --> document (4 constraint(s)) =========
-- Requires: matter schema, document schema
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= matter --> intake (1 constraint(s)) =========
-- Requires: matter schema, intake schema
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);

-- ========= matter --> ip (1 constraint(s)) =========
-- Requires: matter schema, ip schema
ALTER TABLE `legal_ecm`.`matter`.`assertion` ADD CONSTRAINT `fk_matter_assertion_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);

-- ========= matter --> knowledge (16 constraint(s)) =========
-- Requires: matter schema, knowledge schema
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ADD CONSTRAINT `fk_matter_jurisdiction_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `legal_ecm`.`knowledge`.`clause`(`clause_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_research_memo_id` FOREIGN KEY (`research_memo_id`) REFERENCES `legal_ecm`.`knowledge`.`research_memo`(`research_memo_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_practice_note_id` FOREIGN KEY (`practice_note_id`) REFERENCES `legal_ecm`.`knowledge`.`practice_note`(`practice_note_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `legal_ecm`.`knowledge`.`form_template`(`form_template_id`);

-- ========= matter --> risk (12 constraint(s)) =========
-- Requires: matter schema, risk schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `legal_ecm`.`risk`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ADD CONSTRAINT `fk_matter_risk_assessment_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);

-- ========= matter --> service (8 constraint(s)) =========
-- Requires: matter schema, service schema
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ADD CONSTRAINT `fk_matter_tribunal_jurisdiction_coverage_id` FOREIGN KEY (`jurisdiction_coverage_id`) REFERENCES `legal_ecm`.`service`.`jurisdiction_coverage`(`jurisdiction_coverage_id`);
ALTER TABLE `legal_ecm`.`matter`.`judge` ADD CONSTRAINT `fk_matter_judge_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`matter`.`rate` ADD CONSTRAINT `fk_matter_rate_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ADD CONSTRAINT `fk_matter_jurisdiction_practice_coverage_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= matter --> trust (3 constraint(s)) =========
-- Requires: matter schema, trust schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= matter --> workforce (63 constraint(s)) =========
-- Requires: matter schema, workforce schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_docket_lead_attorney_attorney_profile_id` FOREIGN KEY (`docket_lead_attorney_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_responsible_timekeeper_id` FOREIGN KEY (`responsible_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_updated_by_user_timekeeper_id` FOREIGN KEY (`updated_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_matter_attorney_profile_id` FOREIGN KEY (`matter_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_matter_supervising_partner_attorney_profile_id` FOREIGN KEY (`matter_supervising_partner_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_originating_attorney_attorney_profile_id` FOREIGN KEY (`originating_attorney_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_responsible_timekeeper_id` FOREIGN KEY (`responsible_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_approved_by_timekeeper_id` FOREIGN KEY (`task_approved_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_assigned_timekeeper_id` FOREIGN KEY (`task_assigned_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_task_timekeeper_id` FOREIGN KEY (`task_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_approved_by_user_timekeeper_id` FOREIGN KEY (`approved_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_budget_approved_by_timekeeper_id` FOREIGN KEY (`budget_approved_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_budget_timekeeper_id` FOREIGN KEY (`budget_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_responsible_timekeeper_id` FOREIGN KEY (`responsible_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`rate` ADD CONSTRAINT `fk_matter_rate_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_owner_timekeeper_id` FOREIGN KEY (`owner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_filed_by_timekeeper_id` FOREIGN KEY (`filed_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_responsible_timekeeper_id` FOREIGN KEY (`responsible_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ADD CONSTRAINT `fk_matter_risk_assessment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ADD CONSTRAINT `fk_matter_lateral_conflict_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);

-- ========= risk --> billing (2 constraint(s)) =========
-- Requires: risk schema, billing schema
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= risk --> client (12 constraint(s)) =========
-- Requires: risk schema, client schema
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `legal_ecm`.`client`.`vendor`(`vendor_id`);
ALTER TABLE `legal_ecm`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= risk --> conflict (1 constraint(s)) =========
-- Requires: risk schema, conflict schema
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= risk --> contract (2 constraint(s)) =========
-- Requires: risk schema, contract schema
ALTER TABLE `legal_ecm`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= risk --> matter (11 constraint(s)) =========
-- Requires: risk schema, matter schema
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= risk --> service (1 constraint(s)) =========
-- Requires: risk schema, service schema
ALTER TABLE `legal_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_office_id` FOREIGN KEY (`office_id`) REFERENCES `legal_ecm`.`service`.`office`(`office_id`);

-- ========= risk --> trust (7 constraint(s)) =========
-- Requires: risk schema, trust schema
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `legal_ecm`.`trust`.`receipt`(`receipt_id`);
ALTER TABLE `legal_ecm`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= risk --> workforce (31 constraint(s)) =========
-- Requires: risk schema, workforce schema
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_register_risk_owner_attorney_profile_id` FOREIGN KEY (`register_risk_owner_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_assessment_treatment_owner_attorney_profile_id` FOREIGN KEY (`assessment_treatment_owner_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_reviewer_attorney_profile_id` FOREIGN KEY (`reviewer_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_quaternary_risk_approved_by_attorney_profile_id` FOREIGN KEY (`quaternary_risk_approved_by_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_tertiary_risk_remediation_owner_attorney_profile_id` FOREIGN KEY (`tertiary_risk_remediation_owner_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_assigned_to_user_timekeeper_id` FOREIGN KEY (`assigned_to_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_escalated_to_user_timekeeper_id` FOREIGN KEY (`escalated_to_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`cyber_risk_event` ADD CONSTRAINT `fk_risk_cyber_risk_event_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`sanctions_screening` ADD CONSTRAINT `fk_risk_sanctions_screening_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`reputational_risk` ADD CONSTRAINT `fk_risk_reputational_risk_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_appetite_reviewed_by_attorney_profile_id` FOREIGN KEY (`appetite_reviewed_by_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_last_updated_by_timekeeper_id` FOREIGN KEY (`last_updated_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_reviewer_attorney_profile_id` FOREIGN KEY (`reviewer_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`third_party_risk` ADD CONSTRAINT `fk_risk_third_party_risk_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_last_updated_by_timekeeper_id` FOREIGN KEY (`last_updated_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`risk`.`escalation` ADD CONSTRAINT `fk_risk_escalation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);

-- ========= service --> billing (2 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `legal_ecm`.`billing`.`guideline`(`guideline_id`);
ALTER TABLE `legal_ecm`.`service`.`office` ADD CONSTRAINT `fk_service_office_billing_office_id` FOREIGN KEY (`billing_office_id`) REFERENCES `legal_ecm`.`billing`.`billing_office`(`billing_office_id`);

-- ========= service --> client (5 constraint(s)) =========
-- Requires: service schema, client schema
ALTER TABLE `legal_ecm`.`service`.`tier` ADD CONSTRAINT `fk_service_tier_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_client_engagement_scope_id` FOREIGN KEY (`client_engagement_scope_id`) REFERENCES `legal_ecm`.`client`.`client_engagement_scope`(`client_engagement_scope_id`);
ALTER TABLE `legal_ecm`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `legal_ecm`.`client`.`client_contact`(`client_contact_id`);

-- ========= service --> conflict (1 constraint(s)) =========
-- Requires: service schema, conflict schema
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);

-- ========= service --> intake (1 constraint(s)) =========
-- Requires: service schema, intake schema
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= service --> knowledge (1 constraint(s)) =========
-- Requires: service schema, knowledge schema
ALTER TABLE `legal_ecm`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);

-- ========= service --> matter (3 constraint(s)) =========
-- Requires: service schema, matter schema
ALTER TABLE `legal_ecm`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= service --> risk (6 constraint(s)) =========
-- Requires: service schema, risk schema
ALTER TABLE `legal_ecm`.`service`.`practice_area` ADD CONSTRAINT `fk_service_practice_area_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`service`.`tier` ADD CONSTRAINT `fk_service_tier_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `legal_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `legal_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `legal_ecm`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);

-- ========= service --> workforce (27 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `legal_ecm`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_package_approved_by_partner_timekeeper_id` FOREIGN KEY (`package_approved_by_partner_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_package_timekeeper_id` FOREIGN KEY (`package_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_primary_matter_approved_by_timekeeper_id` FOREIGN KEY (`primary_matter_approved_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_tertiary_matter_lead_associate_timekeeper_id` FOREIGN KEY (`tertiary_matter_lead_associate_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_last_modified_by_timekeeper_id` FOREIGN KEY (`last_modified_by_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_primary_eligibility_timekeeper_id` FOREIGN KEY (`primary_eligibility_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`service`.`line` ADD CONSTRAINT `fk_service_line_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`service`.`office` ADD CONSTRAINT `fk_service_office_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= trust --> billing (10 constraint(s)) =========
-- Requires: trust schema, billing schema
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_billing_payment_id` FOREIGN KEY (`billing_payment_id`) REFERENCES `legal_ecm`.`billing`.`billing_payment`(`billing_payment_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_billing_fee_arrangement_id` FOREIGN KEY (`billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`billing_fee_arrangement`(`billing_fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= trust --> client (14 constraint(s)) =========
-- Requires: trust schema, client schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= trust --> compliance (30 constraint(s)) =========
-- Requires: trust schema, compliance schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `legal_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_aml_risk_assessment_id` FOREIGN KEY (`aml_risk_assessment_id`) REFERENCES `legal_ecm`.`compliance`.`aml_risk_assessment`(`aml_risk_assessment_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_regulatory_return_id` FOREIGN KEY (`regulatory_return_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_return`(`regulatory_return_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `legal_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `legal_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_regulatory_breach_id` FOREIGN KEY (`regulatory_breach_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_breach`(`regulatory_breach_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `legal_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_control_test` ADD CONSTRAINT `fk_trust_trust_control_test_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_control_test` ADD CONSTRAINT `fk_trust_trust_control_test_compliance_control_test_id` FOREIGN KEY (`compliance_control_test_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control_test`(`compliance_control_test_id`);

-- ========= trust --> conflict (1 constraint(s)) =========
-- Requires: trust schema, conflict schema
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `legal_ecm`.`conflict`.`rule`(`rule_id`);

-- ========= trust --> contract (7 constraint(s)) =========
-- Requires: trust schema, contract schema
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `legal_ecm`.`contract`.`contract_agreement`(`contract_agreement_id`);

-- ========= trust --> document (1 constraint(s)) =========
-- Requires: trust schema, document schema
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= trust --> knowledge (5 constraint(s)) =========
-- Requires: trust schema, knowledge schema
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `legal_ecm`.`knowledge`.`checklist`(`checklist_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_precedent_id` FOREIGN KEY (`precedent_id`) REFERENCES `legal_ecm`.`knowledge`.`precedent`(`precedent_id`);

-- ========= trust --> matter (14 constraint(s)) =========
-- Requires: trust schema, matter schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= trust --> risk (6 constraint(s)) =========
-- Requires: trust schema, risk schema
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= trust --> service (5 constraint(s)) =========
-- Requires: trust schema, service schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= trust --> workforce (43 constraint(s)) =========
-- Requires: trust schema, workforce schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_account_backup_attorney_attorney_profile_id` FOREIGN KEY (`account_backup_attorney_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_approved_by_user_timekeeper_id` FOREIGN KEY (`approved_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_tertiary_disbursement_rejecting_approver_attorney_profile_id` FOREIGN KEY (`tertiary_disbursement_rejecting_approver_attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_primary_three_timekeeper_id` FOREIGN KEY (`primary_three_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`reconciliation_item` ADD CONSTRAINT `fk_trust_reconciliation_item_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_reconciled_by_user_timekeeper_id` FOREIGN KEY (`reconciled_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement_line` ADD CONSTRAINT `fk_trust_bank_statement_line_voided_by_user_timekeeper_id` FOREIGN KEY (`voided_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`iolta_interest_remittance` ADD CONSTRAINT `fk_trust_iolta_interest_remittance_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_created_by_user_timekeeper_id` FOREIGN KEY (`created_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_modified_by_user_timekeeper_id` FOREIGN KEY (`modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_reconciled_by_user_timekeeper_id` FOREIGN KEY (`reconciled_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_last_modified_by_user_timekeeper_id` FOREIGN KEY (`last_modified_by_user_timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_replenishment` ADD CONSTRAINT `fk_trust_retainer_replenishment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_release` ADD CONSTRAINT `fk_trust_escrow_release_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`account_audit` ADD CONSTRAINT `fk_trust_account_audit_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_exception` ADD CONSTRAINT `fk_trust_trust_exception_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`unclaimed_funds_record` ADD CONSTRAINT `fk_trust_unclaimed_funds_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm`.`trust`.`reconciliation_period` ADD CONSTRAINT `fk_trust_reconciliation_period_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm`.`trust`.`reconciliation_period` ADD CONSTRAINT `fk_trust_reconciliation_period_prepared_by_user_id` FOREIGN KEY (`prepared_by_user_id`) REFERENCES `legal_ecm`.`workforce`.`user`(`user_id`);

-- ========= workforce --> client (1 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `legal_ecm`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= workforce --> intake (1 constraint(s)) =========
-- Requires: workforce schema, intake schema
ALTER TABLE `legal_ecm`.`workforce`.`rfp_team_assignment` ADD CONSTRAINT `fk_workforce_rfp_team_assignment_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);

-- ========= workforce --> knowledge (2 constraint(s)) =========
-- Requires: workforce schema, knowledge schema
ALTER TABLE `legal_ecm`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_knowledge_asset_id` FOREIGN KEY (`knowledge_asset_id`) REFERENCES `legal_ecm`.`knowledge`.`knowledge_asset`(`knowledge_asset_id`);
ALTER TABLE `legal_ecm`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `legal_ecm`.`knowledge`.`taxonomy`(`taxonomy_id`);

-- ========= workforce --> matter (6 constraint(s)) =========
-- Requires: workforce schema, matter schema
ALTER TABLE `legal_ecm`.`workforce`.`bar_admission` ADD CONSTRAINT `fk_workforce_bar_admission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `legal_ecm`.`matter`.`budget`(`budget_id`);
ALTER TABLE `legal_ecm`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= workforce --> service (2 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `legal_ecm`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

