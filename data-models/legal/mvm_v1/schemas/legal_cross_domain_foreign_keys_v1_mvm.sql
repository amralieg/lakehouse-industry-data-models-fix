-- Cross-Domain Foreign Keys for Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:21
-- Total cross-domain FK constraints: 971
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, client, compliance, conflict, contract, document, intake, ip, matter, risk, service, trust

-- ========= billing --> client (20 constraint(s)) =========
-- Requires: billing schema, client schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= billing --> compliance (8 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);

-- ========= billing --> conflict (1 constraint(s)) =========
-- Requires: billing schema, conflict schema
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= billing --> contract (9 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `legal_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);

-- ========= billing --> document (9 constraint(s)) =========
-- Requires: billing schema, document schema
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_doc_review_assignment_id` FOREIGN KEY (`doc_review_assignment_id`) REFERENCES `legal_ecm`.`document`.`doc_review_assignment`(`doc_review_assignment_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_production_set_id` FOREIGN KEY (`production_set_id`) REFERENCES `legal_ecm`.`document`.`production_set`(`production_set_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_doc_execution_id` FOREIGN KEY (`doc_execution_id`) REFERENCES `legal_ecm`.`document`.`doc_execution`(`doc_execution_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= billing --> intake (8 constraint(s)) =========
-- Requires: billing schema, intake schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_matter_opening_request_id` FOREIGN KEY (`matter_opening_request_id`) REFERENCES `legal_ecm`.`intake`.`matter_opening_request`(`matter_opening_request_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= billing --> ip (9 constraint(s)) =========
-- Requires: billing schema, ip schema
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_prosecution_event_id` FOREIGN KEY (`prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_docket_deadline_id` FOREIGN KEY (`docket_deadline_id`) REFERENCES `legal_ecm`.`ip`.`docket_deadline`(`docket_deadline_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_prosecution_event_id` FOREIGN KEY (`prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);

-- ========= billing --> matter (33 constraint(s)) =========
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
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
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
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= billing --> risk (9 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_matter_risk_profile_id` FOREIGN KEY (`matter_risk_profile_id`) REFERENCES `legal_ecm`.`risk`.`matter_risk_profile`(`matter_risk_profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_matter_risk_profile_id` FOREIGN KEY (`matter_risk_profile_id`) REFERENCES `legal_ecm`.`risk`.`matter_risk_profile`(`matter_risk_profile_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_indemnity_exposure_id` FOREIGN KEY (`indemnity_exposure_id`) REFERENCES `legal_ecm`.`risk`.`indemnity_exposure`(`indemnity_exposure_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);

-- ========= billing --> service (28 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= billing --> trust (8 constraint(s)) =========
-- Requires: billing schema, trust schema
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_billing_bank_account_id` FOREIGN KEY (`billing_bank_account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= client --> compliance (17 constraint(s)) =========
-- Requires: client schema, compliance schema
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`individual` ADD CONSTRAINT `fk_client_individual_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`corporate_hierarchy` ADD CONSTRAINT `fk_client_corporate_hierarchy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`segment` ADD CONSTRAINT `fk_client_segment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= client --> document (3 constraint(s)) =========
-- Requires: client schema, document schema
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`client`.`beneficial_owner` ADD CONSTRAINT `fk_client_beneficial_owner_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= client --> service (16 constraint(s)) =========
-- Requires: client schema, service schema
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`client`.`profile` ADD CONSTRAINT `fk_client_profile_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`client`.`kyc_record` ADD CONSTRAINT `fk_client_kyc_record_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`client`.`relationship_team` ADD CONSTRAINT `fk_client_relationship_team_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`client`.`engagement_scope` ADD CONSTRAINT `fk_client_engagement_scope_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`client`.`outside_counsel_guideline` ADD CONSTRAINT `fk_client_outside_counsel_guideline_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);

-- ========= compliance --> client (3 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= compliance --> document (5 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ADD CONSTRAINT `fk_compliance_control_test_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= compliance --> matter (2 constraint(s)) =========
-- Requires: compliance schema, matter schema
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= compliance --> risk (4 constraint(s)) =========
-- Requires: compliance schema, risk schema
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`compliance`.`control_test` ADD CONSTRAINT `fk_compliance_control_test_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);

-- ========= compliance --> service (12 constraint(s)) =========
-- Requires: compliance schema, service schema
ALTER TABLE `legal_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`control_framework` ADD CONSTRAINT `fk_compliance_control_framework_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`compliance_control` ADD CONSTRAINT `fk_compliance_compliance_control_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`aml_kyc_program` ADD CONSTRAINT `fk_compliance_aml_kyc_program_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`compliance`.`data_privacy_register` ADD CONSTRAINT `fk_compliance_data_privacy_register_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_policy` ADD CONSTRAINT `fk_compliance_indemnity_policy_line_id` FOREIGN KEY (`line_id`) REFERENCES `legal_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`compliance`.`indemnity_claim` ADD CONSTRAINT `fk_compliance_indemnity_claim_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= conflict --> client (11 constraint(s)) =========
-- Requires: conflict schema, client schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_engagement_scope_id` FOREIGN KEY (`engagement_scope_id`) REFERENCES `legal_ecm`.`client`.`engagement_scope`(`engagement_scope_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= conflict --> compliance (16 constraint(s)) =========
-- Requires: conflict schema, compliance schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= conflict --> contract (2 constraint(s)) =========
-- Requires: conflict schema, contract schema
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `legal_ecm`.`contract`.`contract_party`(`contract_party_id`);

-- ========= conflict --> document (3 constraint(s)) =========
-- Requires: conflict schema, document schema
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`conflict`.`wall_membership` ADD CONSTRAINT `fk_conflict_wall_membership_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= conflict --> intake (9 constraint(s)) =========
-- Requires: conflict schema, intake schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_conflict_search_id` FOREIGN KEY (`conflict_search_id`) REFERENCES `legal_ecm`.`intake`.`conflict_search`(`conflict_search_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_execution` ADD CONSTRAINT `fk_conflict_search_execution_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);

-- ========= conflict --> ip (6 constraint(s)) =========
-- Requires: conflict schema, ip schema
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);

-- ========= conflict --> matter (7 constraint(s)) =========
-- Requires: conflict schema, matter schema
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= conflict --> risk (20 constraint(s)) =========
-- Requires: conflict schema, risk schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_matter_risk_profile_id` FOREIGN KEY (`matter_risk_profile_id`) REFERENCES `legal_ecm`.`risk`.`matter_risk_profile`(`matter_risk_profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`conflict_party` ADD CONSTRAINT `fk_conflict_conflict_party_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_matter_risk_profile_id` FOREIGN KEY (`matter_risk_profile_id`) REFERENCES `legal_ecm`.`risk`.`matter_risk_profile`(`matter_risk_profile_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_risk_control_id` FOREIGN KEY (`risk_control_id`) REFERENCES `legal_ecm`.`risk`.`risk_control`(`risk_control_id`);

-- ========= conflict --> service (12 constraint(s)) =========
-- Requires: conflict schema, service schema
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`check` ADD CONSTRAINT `fk_conflict_check_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`conflict`.`search_hit` ADD CONSTRAINT `fk_conflict_search_hit_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`conflict`.`rule` ADD CONSTRAINT `fk_conflict_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= conflict --> trust (6 constraint(s)) =========
-- Requires: conflict schema, trust schema
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`clearance` ADD CONSTRAINT `fk_conflict_clearance_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`waiver` ADD CONSTRAINT `fk_conflict_waiver_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`conflict`.`ethical_wall` ADD CONSTRAINT `fk_conflict_ethical_wall_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);

-- ========= contract --> client (14 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);

-- ========= contract --> compliance (17 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= contract --> conflict (4 constraint(s)) =========
-- Requires: contract schema, conflict schema
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= contract --> document (10 constraint(s)) =========
-- Requires: contract schema, document schema
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_amendment_legal_document_id` FOREIGN KEY (`amendment_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= contract --> intake (11 constraint(s)) =========
-- Requires: contract schema, intake schema
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_kyc_screening_id` FOREIGN KEY (`kyc_screening_id`) REFERENCES `legal_ecm`.`intake`.`kyc_screening`(`kyc_screening_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= contract --> ip (1 constraint(s)) =========
-- Requires: contract schema, ip schema
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);

-- ========= contract --> matter (14 constraint(s)) =========
-- Requires: contract schema, matter schema
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_deadline_id` FOREIGN KEY (`deadline_id`) REFERENCES `legal_ecm`.`matter`.`deadline`(`deadline_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`execution_record` ADD CONSTRAINT `fk_contract_execution_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);

-- ========= contract --> risk (7 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation_event` ADD CONSTRAINT `fk_contract_obligation_event_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= contract --> service (25 constraint(s)) =========
-- Requires: contract schema, service schema
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`contract`.`template` ADD CONSTRAINT `fk_contract_template_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`contract`.`obligation` ADD CONSTRAINT `fk_contract_obligation_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`contract`.`milestone` ADD CONSTRAINT `fk_contract_milestone_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`contract`.`clause_library` ADD CONSTRAINT `fk_contract_clause_library_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= document --> billing (2 constraint(s)) =========
-- Requires: document schema, billing schema
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_billing_disbursement_id` FOREIGN KEY (`billing_disbursement_id`) REFERENCES `legal_ecm`.`billing`.`billing_disbursement`(`billing_disbursement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= document --> client (12 constraint(s)) =========
-- Requires: document schema, client schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= document --> compliance (18 constraint(s)) =========
-- Requires: document schema, compliance schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= document --> conflict (3 constraint(s)) =========
-- Requires: document schema, conflict schema
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);

-- ========= document --> contract (9 constraint(s)) =========
-- Requires: document schema, contract schema
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= document --> intake (4 constraint(s)) =========
-- Requires: document schema, intake schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);

-- ========= document --> ip (19 constraint(s)) =========
-- Requires: document schema, ip schema
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `legal_ecm`.`ip`.`trademark`(`trademark_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_prosecution_event_id` FOREIGN KEY (`prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_inventor_id` FOREIGN KEY (`inventor_id`) REFERENCES `legal_ecm`.`ip`.`inventor`(`inventor_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_ownership_id` FOREIGN KEY (`ownership_id`) REFERENCES `legal_ecm`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);

-- ========= document --> matter (22 constraint(s)) =========
-- Requires: document schema, matter schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `legal_ecm`.`matter`.`hold`(`hold_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `legal_ecm`.`matter`.`hold`(`hold_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= document --> risk (12 constraint(s)) =========
-- Requires: document schema, risk schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);

-- ========= document --> service (24 constraint(s)) =========
-- Requires: document schema, service schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_version` ADD CONSTRAINT `fk_document_doc_version_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_type` ADD CONSTRAINT `fk_document_doc_type_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_folder` ADD CONSTRAINT `fk_document_doc_folder_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_review_assignment` ADD CONSTRAINT `fk_document_doc_review_assignment_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`document`.`privilege_log` ADD CONSTRAINT `fk_document_privilege_log_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_custodian` ADD CONSTRAINT `fk_document_esi_custodian_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_production` ADD CONSTRAINT `fk_document_doc_production_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_template` ADD CONSTRAINT `fk_document_doc_template_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`document`.`production_set` ADD CONSTRAINT `fk_document_production_set_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);

-- ========= document --> trust (6 constraint(s)) =========
-- Requires: document schema, trust schema
ALTER TABLE `legal_ecm`.`document`.`legal_document` ADD CONSTRAINT `fk_document_legal_document_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`document`.`esi_collection` ADD CONSTRAINT `fk_document_esi_collection_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_disbursement_authorization_id` FOREIGN KEY (`disbursement_authorization_id`) REFERENCES `legal_ecm`.`trust`.`disbursement_authorization`(`disbursement_authorization_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`document`.`doc_execution` ADD CONSTRAINT `fk_document_doc_execution_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);

-- ========= intake --> billing (2 constraint(s)) =========
-- Requires: intake schema, billing schema
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);

-- ========= intake --> client (18 constraint(s)) =========
-- Requires: intake schema, client schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= intake --> compliance (30 constraint(s)) =========
-- Requires: intake schema, compliance schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_control_framework_id` FOREIGN KEY (`control_framework_id`) REFERENCES `legal_ecm`.`compliance`.`control_framework`(`control_framework_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= intake --> conflict (2 constraint(s)) =========
-- Requires: intake schema, conflict schema
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= intake --> contract (3 constraint(s)) =========
-- Requires: intake schema, contract schema
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `legal_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_template_id` FOREIGN KEY (`template_id`) REFERENCES `legal_ecm`.`contract`.`template`(`template_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_template_id` FOREIGN KEY (`template_id`) REFERENCES `legal_ecm`.`contract`.`template`(`template_id`);

-- ========= intake --> document (8 constraint(s)) =========
-- Requires: intake schema, document schema
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_pitch_proposal_legal_document_id` FOREIGN KEY (`pitch_proposal_legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= intake --> matter (6 constraint(s)) =========
-- Requires: intake schema, matter schema
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= intake --> risk (10 constraint(s)) =========
-- Requires: intake schema, risk schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_matter_risk_profile_id` FOREIGN KEY (`matter_risk_profile_id`) REFERENCES `legal_ecm`.`risk`.`matter_risk_profile`(`matter_risk_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_matter_risk_profile_id` FOREIGN KEY (`matter_risk_profile_id`) REFERENCES `legal_ecm`.`risk`.`matter_risk_profile`(`matter_risk_profile_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= intake --> service (33 constraint(s)) =========
-- Requires: intake schema, service schema
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`prospect` ADD CONSTRAINT `fk_intake_prospect_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `legal_ecm`.`service`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_lpm_template_id` FOREIGN KEY (`lpm_template_id`) REFERENCES `legal_ecm`.`service`.`lpm_template`(`lpm_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= intake --> trust (4 constraint(s)) =========
-- Requires: intake schema, trust schema
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);

-- ========= ip --> billing (3 constraint(s)) =========
-- Requires: ip schema, billing schema
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_billing_disbursement_id` FOREIGN KEY (`billing_disbursement_id`) REFERENCES `legal_ecm`.`billing`.`billing_disbursement`(`billing_disbursement_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= ip --> client (15 constraint(s)) =========
-- Requires: ip schema, client schema
ALTER TABLE `legal_ecm`.`ip`.`asset` ADD CONSTRAINT `fk_ip_asset_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`asset` ADD CONSTRAINT `fk_ip_asset_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= ip --> compliance (10 constraint(s)) =========
-- Requires: ip schema, compliance schema
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= ip --> contract (4 constraint(s)) =========
-- Requires: ip schema, contract schema
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= ip --> document (1 constraint(s)) =========
-- Requires: ip schema, document schema
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= ip --> intake (5 constraint(s)) =========
-- Requires: ip schema, intake schema
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);

-- ========= ip --> matter (23 constraint(s)) =========
-- Requires: ip schema, matter schema
ALTER TABLE `legal_ecm`.`ip`.`asset` ADD CONSTRAINT `fk_ip_asset_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= ip --> risk (5 constraint(s)) =========
-- Requires: ip schema, risk schema
ALTER TABLE `legal_ecm`.`ip`.`asset` ADD CONSTRAINT `fk_ip_asset_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= ip --> service (14 constraint(s)) =========
-- Requires: ip schema, service schema
ALTER TABLE `legal_ecm`.`ip`.`asset` ADD CONSTRAINT `fk_ip_asset_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ADD CONSTRAINT `fk_ip_patent_family_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

-- ========= ip --> trust (11 constraint(s)) =========
-- Requires: ip schema, trust schema
ALTER TABLE `legal_ecm`.`ip`.`asset` ADD CONSTRAINT `fk_ip_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_disbursement_authorization_id` FOREIGN KEY (`disbursement_authorization_id`) REFERENCES `legal_ecm`.`trust`.`disbursement_authorization`(`disbursement_authorization_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_ledger_entry_id` FOREIGN KEY (`ledger_entry_id`) REFERENCES `legal_ecm`.`trust`.`ledger_entry`(`ledger_entry_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `legal_ecm`.`trust`.`receipt`(`receipt_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);

-- ========= matter --> billing (4 constraint(s)) =========
-- Requires: matter schema, billing schema
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `legal_ecm`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_timekeeper_rate_id` FOREIGN KEY (`timekeeper_rate_id`) REFERENCES `legal_ecm`.`billing`.`timekeeper_rate`(`timekeeper_rate_id`);

-- ========= matter --> client (17 constraint(s)) =========
-- Requires: matter schema, client schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`deadline` ADD CONSTRAINT `fk_matter_deadline_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`deadline` ADD CONSTRAINT `fk_matter_deadline_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_engagement_scope_id` FOREIGN KEY (`engagement_scope_id`) REFERENCES `legal_ecm`.`client`.`engagement_scope`(`engagement_scope_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `legal_ecm`.`client`.`individual`(`individual_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_organisation_id` FOREIGN KEY (`organisation_id`) REFERENCES `legal_ecm`.`client`.`organisation`(`organisation_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);

-- ========= matter --> compliance (16 constraint(s)) =========
-- Requires: matter schema, compliance schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`deadline` ADD CONSTRAINT `fk_matter_deadline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_indemnity_claim_id` FOREIGN KEY (`indemnity_claim_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_claim`(`indemnity_claim_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= matter --> conflict (4 constraint(s)) =========
-- Requires: matter schema, conflict schema
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_ethical_wall_id` FOREIGN KEY (`ethical_wall_id`) REFERENCES `legal_ecm`.`conflict`.`ethical_wall`(`ethical_wall_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_conflict_party_id` FOREIGN KEY (`conflict_party_id`) REFERENCES `legal_ecm`.`conflict`.`conflict_party`(`conflict_party_id`);
ALTER TABLE `legal_ecm`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_clearance_id` FOREIGN KEY (`clearance_id`) REFERENCES `legal_ecm`.`conflict`.`clearance`(`clearance_id`);

-- ========= matter --> contract (3 constraint(s)) =========
-- Requires: matter schema, contract schema
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`matter`.`deadline` ADD CONSTRAINT `fk_matter_deadline_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);

-- ========= matter --> document (8 constraint(s)) =========
-- Requires: matter schema, document schema
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_doc_version_id` FOREIGN KEY (`doc_version_id`) REFERENCES `legal_ecm`.`document`.`doc_version`(`doc_version_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`deadline` ADD CONSTRAINT `fk_matter_deadline_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_legal_document_id` FOREIGN KEY (`legal_document_id`) REFERENCES `legal_ecm`.`document`.`legal_document`(`legal_document_id`);

-- ========= matter --> intake (4 constraint(s)) =========
-- Requires: matter schema, intake schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_referral_source_id` FOREIGN KEY (`referral_source_id`) REFERENCES `legal_ecm`.`intake`.`referral_source`(`referral_source_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_kyc_screening_id` FOREIGN KEY (`kyc_screening_id`) REFERENCES `legal_ecm`.`intake`.`kyc_screening`(`kyc_screening_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);

-- ========= matter --> risk (10 constraint(s)) =========
-- Requires: matter schema, risk schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`deadline` ADD CONSTRAINT `fk_matter_deadline_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_mitigation_action_id` FOREIGN KEY (`mitigation_action_id`) REFERENCES `legal_ecm`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `legal_ecm`.`risk`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_pi_claim_id` FOREIGN KEY (`pi_claim_id`) REFERENCES `legal_ecm`.`risk`.`pi_claim`(`pi_claim_id`);

-- ========= matter --> service (10 constraint(s)) =========
-- Requires: matter schema, service schema
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ADD CONSTRAINT `fk_matter_tribunal_jurisdiction_coverage_id` FOREIGN KEY (`jurisdiction_coverage_id`) REFERENCES `legal_ecm`.`service`.`jurisdiction_coverage`(`jurisdiction_coverage_id`);
ALTER TABLE `legal_ecm`.`matter`.`judge` ADD CONSTRAINT `fk_matter_judge_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter` ADD CONSTRAINT `fk_matter_matter_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_lpm_template_id` FOREIGN KEY (`lpm_template_id`) REFERENCES `legal_ecm`.`service`.`lpm_template`(`lpm_template_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `legal_ecm`.`service`.`rate_card`(`rate_card_id`);

-- ========= matter --> trust (8 constraint(s)) =========
-- Requires: matter schema, trust schema
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_retainer_agreement_id` FOREIGN KEY (`retainer_agreement_id`) REFERENCES `legal_ecm`.`trust`.`retainer_agreement`(`retainer_agreement_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_escrow_arrangement_id` FOREIGN KEY (`escrow_arrangement_id`) REFERENCES `legal_ecm`.`trust`.`escrow_arrangement`(`escrow_arrangement_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_trust_disbursement_id` FOREIGN KEY (`trust_disbursement_id`) REFERENCES `legal_ecm`.`trust`.`trust_disbursement`(`trust_disbursement_id`);

-- ========= risk --> billing (1 constraint(s)) =========
-- Requires: risk schema, billing schema
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= risk --> client (11 constraint(s)) =========
-- Requires: risk schema, client schema
ALTER TABLE `legal_ecm`.`risk`.`register` ADD CONSTRAINT `fk_risk_register_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_beneficial_owner_id` FOREIGN KEY (`beneficial_owner_id`) REFERENCES `legal_ecm`.`client`.`beneficial_owner`(`beneficial_owner_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `legal_ecm`.`client`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= risk --> compliance (2 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_indemnity_policy_id` FOREIGN KEY (`indemnity_policy_id`) REFERENCES `legal_ecm`.`compliance`.`indemnity_policy`(`indemnity_policy_id`);

-- ========= risk --> conflict (1 constraint(s)) =========
-- Requires: risk schema, conflict schema
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_check_id` FOREIGN KEY (`check_id`) REFERENCES `legal_ecm`.`conflict`.`check`(`check_id`);

-- ========= risk --> contract (4 constraint(s)) =========
-- Requires: risk schema, contract schema
ALTER TABLE `legal_ecm`.`risk`.`risk_control` ADD CONSTRAINT `fk_risk_risk_control_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `legal_ecm`.`contract`.`termination`(`termination_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);

-- ========= risk --> ip (4 constraint(s)) =========
-- Requires: risk schema, ip schema
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);

-- ========= risk --> matter (9 constraint(s)) =========
-- Requires: risk schema, matter schema
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`matter_risk_profile` ADD CONSTRAINT `fk_risk_matter_risk_profile_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `legal_ecm`.`matter`.`phase`(`phase_id`);

-- ========= risk --> trust (5 constraint(s)) =========
-- Requires: risk schema, trust schema
ALTER TABLE `legal_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`indemnity_exposure` ADD CONSTRAINT `fk_risk_indemnity_exposure_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`pi_claim` ADD CONSTRAINT `fk_risk_pi_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`data_breach_incident` ADD CONSTRAINT `fk_risk_data_breach_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);
ALTER TABLE `legal_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `legal_ecm`.`trust`.`account`(`account_id`);

-- ========= service --> client (7 constraint(s)) =========
-- Requires: service schema, client schema
ALTER TABLE `legal_ecm`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`tier` ADD CONSTRAINT `fk_service_tier_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`service`.`sla_template` ADD CONSTRAINT `fk_service_sla_template_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);
ALTER TABLE `legal_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `legal_ecm`.`client`.`segment`(`segment_id`);

-- ========= service --> document (1 constraint(s)) =========
-- Requires: service schema, document schema
ALTER TABLE `legal_ecm`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_doc_template_id` FOREIGN KEY (`doc_template_id`) REFERENCES `legal_ecm`.`document`.`doc_template`(`doc_template_id`);

-- ========= service --> risk (9 constraint(s)) =========
-- Requires: service schema, risk schema
ALTER TABLE `legal_ecm`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`service`.`sla_template` ADD CONSTRAINT `fk_service_sla_template_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`service`.`package` ADD CONSTRAINT `fk_service_package_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`service`.`jurisdiction_coverage` ADD CONSTRAINT `fk_service_jurisdiction_coverage_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`service`.`delivery_model` ADD CONSTRAINT `fk_service_delivery_model_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);
ALTER TABLE `legal_ecm`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `legal_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `legal_ecm`.`service`.`line` ADD CONSTRAINT `fk_service_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `legal_ecm`.`risk`.`category`(`category_id`);

-- ========= trust --> billing (8 constraint(s)) =========
-- Requires: trust schema, billing schema
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_billing_payment_id` FOREIGN KEY (`billing_payment_id`) REFERENCES `legal_ecm`.`billing`.`billing_payment`(`billing_payment_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);

-- ========= trust --> client (13 constraint(s)) =========
-- Requires: trust schema, client schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `legal_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_outside_counsel_guideline_id` FOREIGN KEY (`outside_counsel_guideline_id`) REFERENCES `legal_ecm`.`client`.`outside_counsel_guideline`(`outside_counsel_guideline_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `legal_ecm`.`client`.`profile`(`profile_id`);

-- ========= trust --> compliance (25 constraint(s)) =========
-- Requires: trust schema, compliance schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `legal_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `legal_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`three_way_reconciliation` ADD CONSTRAINT `fk_trust_three_way_reconciliation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`bank_statement` ADD CONSTRAINT `fk_trust_bank_statement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_data_privacy_register_id` FOREIGN KEY (`data_privacy_register_id`) REFERENCES `legal_ecm`.`compliance`.`data_privacy_register`(`data_privacy_register_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_aml_kyc_program_id` FOREIGN KEY (`aml_kyc_program_id`) REFERENCES `legal_ecm`.`compliance`.`aml_kyc_program`(`aml_kyc_program_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_compliance_control_id` FOREIGN KEY (`compliance_control_id`) REFERENCES `legal_ecm`.`compliance`.`compliance_control`(`compliance_control_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `legal_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= trust --> contract (8 constraint(s)) =========
-- Requires: trust schema, contract schema
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `legal_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `legal_ecm`.`contract`.`obligation`(`obligation_id`);

-- ========= trust --> intake (14 constraint(s)) =========
-- Requires: trust schema, intake schema
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_kyc_screening_id` FOREIGN KEY (`kyc_screening_id`) REFERENCES `legal_ecm`.`intake`.`kyc_screening`(`kyc_screening_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_kyc_screening_id` FOREIGN KEY (`kyc_screening_id`) REFERENCES `legal_ecm`.`intake`.`kyc_screening`(`kyc_screening_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_kyc_screening_id` FOREIGN KEY (`kyc_screening_id`) REFERENCES `legal_ecm`.`intake`.`kyc_screening`(`kyc_screening_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_kyc_screening_id` FOREIGN KEY (`kyc_screening_id`) REFERENCES `legal_ecm`.`intake`.`kyc_screening`(`kyc_screening_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);

-- ========= trust --> matter (9 constraint(s)) =========
-- Requires: trust schema, matter schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`disbursement_authorization` ADD CONSTRAINT `fk_trust_disbursement_authorization_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);

-- ========= trust --> risk (5 constraint(s)) =========
-- Requires: trust schema, risk schema
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);
ALTER TABLE `legal_ecm`.`trust`.`regulatory_report` ADD CONSTRAINT `fk_trust_regulatory_report_register_id` FOREIGN KEY (`register_id`) REFERENCES `legal_ecm`.`risk`.`register`(`register_id`);

-- ========= trust --> service (14 constraint(s)) =========
-- Requires: trust schema, service schema
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`account` ADD CONSTRAINT `fk_trust_account_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`ledger_entry` ADD CONSTRAINT `fk_trust_ledger_entry_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`trust`.`client_trust_balance` ADD CONSTRAINT `fk_trust_client_trust_balance_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`receipt` ADD CONSTRAINT `fk_trust_receipt_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`trust_disbursement` ADD CONSTRAINT `fk_trust_trust_disbursement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`transfer` ADD CONSTRAINT `fk_trust_transfer_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm`.`trust`.`retainer_agreement` ADD CONSTRAINT `fk_trust_retainer_agreement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm`.`trust`.`escrow_arrangement` ADD CONSTRAINT `fk_trust_escrow_arrangement_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm`.`service`.`practice_area`(`practice_area_id`);

