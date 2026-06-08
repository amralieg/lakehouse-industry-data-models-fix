-- Cross-Domain Foreign Keys for Business: Healthcare | Version: v1_ecm
-- Generated on: 2026-05-04 15:51:59
-- Total cross-domain FK constraints: 2867
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, claim, clinical, compliance, consent, encounter, facility, finance, insurance, interoperability, laboratory, order, patient, pharmacy, provider, quality, radiology, reference, research, scheduling, supply, workforce

-- ========= billing --> claim (7 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `healthcare_ecm`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= billing --> consent (3 constraint(s)) =========
-- Requires: billing schema, consent schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `healthcare_ecm`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `healthcare_ecm`.`consent`.`restriction_request`(`restriction_request_id`);

-- ========= billing --> encounter (10 constraint(s)) =========
-- Requires: billing schema, encounter schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= billing --> facility (13 constraint(s)) =========
-- Requires: billing schema, facility schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_network_participation` ADD CONSTRAINT `fk_billing_billing_network_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= billing --> finance (10 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_era_transaction_ar_transaction_id` FOREIGN KEY (`payment_era_transaction_ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);

-- ========= billing --> insurance (13 constraint(s)) =========
-- Requires: billing schema, insurance schema
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_primary_payer_id` FOREIGN KEY (`primary_payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_network_participation` ADD CONSTRAINT `fk_billing_billing_network_participation_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);

-- ========= billing --> interoperability (11 constraint(s)) =========
-- Requires: billing schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_patient_identity_match_id` FOREIGN KEY (`patient_identity_match_id`) REFERENCES `healthcare_ecm`.`interoperability`.`patient_identity_match`(`patient_identity_match_id`);

-- ========= billing --> order (2 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `healthcare_ecm`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);

-- ========= billing --> patient (29 constraint(s)) =========
-- Requires: billing schema, patient schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_primary_patient_mpi_record_id` FOREIGN KEY (`primary_patient_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_member_mpi_record_id` FOREIGN KEY (`member_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_financial_assistance_id` FOREIGN KEY (`financial_assistance_id`) REFERENCES `healthcare_ecm`.`patient`.`financial_assistance`(`financial_assistance_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);

-- ========= billing --> pharmacy (4 constraint(s)) =========
-- Requires: billing schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= billing --> provider (9 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_charge_ordering_provider_clinician_id` FOREIGN KEY (`charge_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `healthcare_ecm`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sanction_id` FOREIGN KEY (`sanction_id`) REFERENCES `healthcare_ecm`.`provider`.`sanction`(`sanction_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= billing --> reference (17 constraint(s)) =========
-- Requires: billing schema, reference schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= billing --> research (1 constraint(s)) =========
-- Requires: billing schema, research schema
ALTER TABLE `healthcare_ecm`.`billing`.`study_service_coverage` ADD CONSTRAINT `fk_billing_study_service_coverage_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= billing --> supply (8 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `healthcare_ecm`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line_item` ADD CONSTRAINT `fk_billing_invoice_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= billing --> workforce (28 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_last_modified_by_user_employee_id` FOREIGN KEY (`payment_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_employee_id` FOREIGN KEY (`adjustment_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_last_modified_by_user_employee_id` FOREIGN KEY (`adjustment_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_statement_last_modified_by_user_employee_id` FOREIGN KEY (`statement_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_billing_last_modified_by_user_employee_id` FOREIGN KEY (`billing_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_tertiary_write_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_write_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_tertiary_payment_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_payment_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_tertiary_rac_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_rac_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_primary_charity_employee_id` FOREIGN KEY (`primary_charity_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_tertiary_charity_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_charity_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_refund_employee_id` FOREIGN KEY (`refund_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_refund_last_modified_by_user_employee_id` FOREIGN KEY (`refund_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_refund_voided_by_user_employee_id` FOREIGN KEY (`refund_voided_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= claim --> billing (6 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `healthcare_ecm`.`billing`.`patient_account`(`patient_account_id`);

-- ========= claim --> compliance (7 constraint(s)) =========
-- Requires: claim schema, compliance schema
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`audit_sample` ADD CONSTRAINT `fk_claim_audit_sample_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= claim --> consent (4 constraint(s)) =========
-- Requires: claim schema, consent schema
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_deficiency_id` FOREIGN KEY (`deficiency_id`) REFERENCES `healthcare_ecm`.`consent`.`deficiency`(`deficiency_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_behavioral_health_consent_id` FOREIGN KEY (`behavioral_health_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`behavioral_health_consent`(`behavioral_health_consent_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`substance_use_consent`(`substance_use_consent_id`);

-- ========= claim --> encounter (6 constraint(s)) =========
-- Requires: claim schema, encounter schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= claim --> facility (6 constraint(s)) =========
-- Requires: claim schema, facility schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= claim --> finance (14 constraint(s)) =========
-- Requires: claim schema, finance schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `healthcare_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `healthcare_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `healthcare_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `healthcare_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `healthcare_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= claim --> insurance (21 constraint(s)) =========
-- Requires: claim schema, insurance schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_primary_payer_id` FOREIGN KEY (`primary_payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= claim --> interoperability (12 constraint(s)) =========
-- Requires: claim schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= claim --> order (4 constraint(s)) =========
-- Requires: claim schema, order schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `healthcare_ecm`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_order_authorization_id` FOREIGN KEY (`order_authorization_id`) REFERENCES `healthcare_ecm`.`order`.`order_authorization`(`order_authorization_id`);

-- ========= claim --> patient (10 constraint(s)) =========
-- Requires: claim schema, patient schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_member_mpi_record_id` FOREIGN KEY (`member_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= claim --> provider (12 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= claim --> quality (3 constraint(s)) =========
-- Requires: claim schema, quality schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_peer_review`(`quality_peer_review_id`);

-- ========= claim --> reference (12 constraint(s)) =========
-- Requires: claim schema, reference schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= claim --> research (2 constraint(s)) =========
-- Requires: claim schema, research schema
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`study_attribution` ADD CONSTRAINT `fk_claim_study_attribution_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= claim --> supply (3 constraint(s)) =========
-- Requires: claim schema, supply schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= claim --> workforce (10 constraint(s)) =========
-- Requires: claim schema, workforce schema
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_appeal_employee_id` FOREIGN KEY (`appeal_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_appeal_last_modified_by_user_employee_id` FOREIGN KEY (`appeal_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= clinical --> billing (2 constraint(s)) =========
-- Requires: clinical schema, billing schema
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= clinical --> claim (7 constraint(s)) =========
-- Requires: clinical schema, claim schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_diagnosis_link_id` FOREIGN KEY (`diagnosis_link_id`) REFERENCES `healthcare_ecm`.`claim`.`diagnosis_link`(`diagnosis_link_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_attachment_id` FOREIGN KEY (`attachment_id`) REFERENCES `healthcare_ecm`.`claim`.`attachment`(`attachment_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_attachment_id` FOREIGN KEY (`attachment_id`) REFERENCES `healthcare_ecm`.`claim`.`attachment`(`attachment_id`);

-- ========= clinical --> compliance (7 constraint(s)) =========
-- Requires: clinical schema, compliance schema
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);

-- ========= clinical --> consent (13 constraint(s)) =========
-- Requires: clinical schema, consent schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);

-- ========= clinical --> encounter (19 constraint(s)) =========
-- Requires: clinical schema, encounter schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= clinical --> facility (23 constraint(s)) =========
-- Requires: clinical schema, facility schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical --> finance (2 constraint(s)) =========
-- Requires: clinical schema, finance schema
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= clinical --> insurance (7 constraint(s)) =========
-- Requires: clinical schema, insurance schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= clinical --> laboratory (10 constraint(s)) =========
-- Requires: clinical schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `healthcare_ecm`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_susceptibility_result_id` FOREIGN KEY (`susceptibility_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`susceptibility_result`(`susceptibility_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);

-- ========= clinical --> order (15 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_cpoe_alert_id` FOREIGN KEY (`cpoe_alert_id`) REFERENCES `healthcare_ecm`.`order`.`cpoe_alert`(`cpoe_alert_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_therapy_order_id` FOREIGN KEY (`therapy_order_id`) REFERENCES `healthcare_ecm`.`order`.`therapy_order`(`therapy_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_diet_order_id` FOREIGN KEY (`diet_order_id`) REFERENCES `healthcare_ecm`.`order`.`diet_order`(`diet_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= clinical --> patient (19 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= clinical --> pharmacy (11 constraint(s)) =========
-- Requires: clinical schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_medication_therapy_mgmt_id` FOREIGN KEY (`medication_therapy_mgmt_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt`(`medication_therapy_mgmt_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= clinical --> provider (35 constraint(s)) =========
-- Requires: clinical schema, provider schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_tertiary_procedure_anesthesia_provider_clinician_id` FOREIGN KEY (`tertiary_procedure_anesthesia_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_note_clinician_id` FOREIGN KEY (`note_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_note_cosigner_provider_clinician_id` FOREIGN KEY (`note_cosigner_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_problem_clinician_id` FOREIGN KEY (`problem_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_problem_last_updated_by_provider_clinician_id` FOREIGN KEY (`problem_last_updated_by_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_allergy_override_provider_clinician_id` FOREIGN KEY (`allergy_override_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_immunization_ordering_provider_clinician_id` FOREIGN KEY (`immunization_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_primary_care_physician_clinician_id` FOREIGN KEY (`primary_care_physician_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_quaternary_care_last_reviewed_by_clinician_id` FOREIGN KEY (`quaternary_care_last_reviewed_by_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_tertiary_care_pcp_clinician_id` FOREIGN KEY (`tertiary_care_pcp_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_primary_contact_provider_clinician_id` FOREIGN KEY (`primary_contact_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_tertiary_care_member_provider_clinician_id` FOREIGN KEY (`tertiary_care_member_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);

-- ========= clinical --> quality (20 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `healthcare_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);

-- ========= clinical --> radiology (7 constraint(s)) =========
-- Requires: clinical schema, radiology schema
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm`.`radiology`.`report`(`report_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= clinical --> reference (28 constraint(s)) =========
-- Requires: clinical schema, reference schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= clinical --> supply (9 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= clinical --> workforce (12 constraint(s)) =========
-- Requires: clinical schema, workforce schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> clinical (3 constraint(s)) =========
-- Requires: compliance schema, clinical schema
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);

-- ========= compliance --> encounter (2 constraint(s)) =========
-- Requires: compliance schema, encounter schema
ALTER TABLE `healthcare_ecm`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= compliance --> facility (13 constraint(s)) =========
-- Requires: compliance schema, facility schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= compliance --> finance (16 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `healthcare_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= compliance --> insurance (10 constraint(s)) =========
-- Requires: compliance schema, insurance schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`business_associate_agreement` ADD CONSTRAINT `fk_compliance_business_associate_agreement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_payer_applicability` ADD CONSTRAINT `fk_compliance_policy_payer_applicability_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= compliance --> interoperability (8 constraint(s)) =========
-- Requires: compliance schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);

-- ========= compliance --> patient (3 constraint(s)) =========
-- Requires: compliance schema, patient schema
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= compliance --> provider (1 constraint(s)) =========
-- Requires: compliance schema, provider schema
ALTER TABLE `healthcare_ecm`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= compliance --> reference (16 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_condition_code_id` FOREIGN KEY (`condition_code_id`) REFERENCES `healthcare_ecm`.`reference`.`condition_code`(`condition_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= compliance --> scheduling (6 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_provider_availability_id` FOREIGN KEY (`provider_availability_id`) REFERENCES `healthcare_ecm`.`scheduling`.`provider_availability`(`provider_availability_id`);

-- ========= compliance --> workforce (26 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_primary_policy_employee_id` FOREIGN KEY (`primary_policy_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_tertiary_hipaa_identified_by_employee_id` FOREIGN KEY (`tertiary_hipaa_identified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_tertiary_hotline_employee_id` FOREIGN KEY (`tertiary_hotline_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_investigator_employee_id` FOREIGN KEY (`investigator_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_tertiary_osha_employee_id` FOREIGN KEY (`tertiary_osha_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_regulatory_impact` ADD CONSTRAINT `fk_compliance_policy_regulatory_impact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= consent --> compliance (15 constraint(s)) =========
-- Requires: consent schema, compliance schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_notice_of_privacy_practices_id` FOREIGN KEY (`notice_of_privacy_practices_id`) REFERENCES `healthcare_ecm`.`compliance`.`notice_of_privacy_practices`(`notice_of_privacy_practices_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`verification` ADD CONSTRAINT `fk_consent_verification_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `healthcare_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);

-- ========= consent --> encounter (22 constraint(s)) =========
-- Requires: consent schema, encounter schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`exception` ADD CONSTRAINT `fk_consent_exception_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`verification` ADD CONSTRAINT `fk_consent_verification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= consent --> facility (16 constraint(s)) =========
-- Requires: consent schema, facility schema
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`exception` ADD CONSTRAINT `fk_consent_exception_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`verification` ADD CONSTRAINT `fk_consent_verification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= consent --> insurance (1 constraint(s)) =========
-- Requires: consent schema, insurance schema
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= consent --> interoperability (13 constraint(s)) =========
-- Requires: consent schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_hie_participation_id` FOREIGN KEY (`hie_participation_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_participation`(`hie_participation_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`verification` ADD CONSTRAINT `fk_consent_verification_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);

-- ========= consent --> patient (28 constraint(s)) =========
-- Requires: consent schema, patient schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_delegate_person_mpi_record_id` FOREIGN KEY (`delegate_person_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`exception` ADD CONSTRAINT `fk_consent_exception_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`verification` ADD CONSTRAINT `fk_consent_verification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= consent --> provider (15 constraint(s)) =========
-- Requires: consent schema, provider schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_record_clinician_id` FOREIGN KEY (`record_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_tertiary_treatment_performing_provider_clinician_id` FOREIGN KEY (`tertiary_treatment_performing_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`exception` ADD CONSTRAINT `fk_consent_exception_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= consent --> reference (1 constraint(s)) =========
-- Requires: consent schema, reference schema
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= consent --> research (5 constraint(s)) =========
-- Requires: consent schema, research schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= consent --> supply (1 constraint(s)) =========
-- Requires: consent schema, supply schema
ALTER TABLE `healthcare_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= consent --> workforce (37 constraint(s)) =========
-- Requires: consent schema, workforce schema
ALTER TABLE `healthcare_ecm`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_event_interpreter_user_employee_id` FOREIGN KEY (`event_interpreter_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`event` ADD CONSTRAINT `fk_consent_event_event_witness_user_employee_id` FOREIGN KEY (`event_witness_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_delegation_employee_id` FOREIGN KEY (`delegation_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_delegation_last_updated_by_user_employee_id` FOREIGN KEY (`delegation_last_updated_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_delegation_revoked_by_user_employee_id` FOREIGN KEY (`delegation_revoked_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_revocation_processed_by_user_employee_id` FOREIGN KEY (`revocation_processed_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`exception` ADD CONSTRAINT `fk_consent_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`verification` ADD CONSTRAINT `fk_consent_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_translation_quality_reviewer_employee_id` FOREIGN KEY (`translation_quality_reviewer_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_tertiary_consent_last_updated_by_user_employee_id` FOREIGN KEY (`tertiary_consent_last_updated_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`workflow` ADD CONSTRAINT `fk_consent_workflow_workflow_last_updated_by_user_employee_id` FOREIGN KEY (`workflow_last_updated_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_deficiency_employee_id` FOREIGN KEY (`deficiency_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_deficiency_escalated_to_user_employee_id` FOREIGN KEY (`deficiency_escalated_to_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_deficiency_last_updated_by_user_employee_id` FOREIGN KEY (`deficiency_last_updated_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_deficiency_remediated_by_user_employee_id` FOREIGN KEY (`deficiency_remediated_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_deficiency_waiver_approved_by_user_employee_id` FOREIGN KEY (`deficiency_waiver_approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= encounter --> clinical (1 constraint(s)) =========
-- Requires: encounter schema, clinical schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);

-- ========= encounter --> compliance (9 constraint(s)) =========
-- Requires: encounter schema, compliance schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);

-- ========= encounter --> consent (1 constraint(s)) =========
-- Requires: encounter schema, consent schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);

-- ========= encounter --> facility (15 constraint(s)) =========
-- Requires: encounter schema, facility schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_transfer_destination_facility_care_site_id` FOREIGN KEY (`transfer_destination_facility_care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_origin_bed_id` FOREIGN KEY (`origin_bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_primary_transfer_care_site_id` FOREIGN KEY (`primary_transfer_care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= encounter --> finance (8 constraint(s)) =========
-- Requires: encounter schema, finance schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `healthcare_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= encounter --> insurance (12 constraint(s)) =========
-- Requires: encounter schema, insurance schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_coverage` ADD CONSTRAINT `fk_encounter_visit_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= encounter --> interoperability (6 constraint(s)) =========
-- Requires: encounter schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);

-- ========= encounter --> order (1 constraint(s)) =========
-- Requires: encounter schema, order schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);

-- ========= encounter --> patient (17 constraint(s)) =========
-- Requires: encounter schema, patient schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_patient_mpi_record_id` FOREIGN KEY (`visit_patient_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_member_mpi_record_id` FOREIGN KEY (`member_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= encounter --> provider (21 constraint(s)) =========
-- Requires: encounter schema, provider schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_clinician_id` FOREIGN KEY (`visit_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_discharging_provider_clinician_id` FOREIGN KEY (`visit_discharging_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `healthcare_ecm`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `healthcare_ecm`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_tertiary_visit_supervising_provider_clinician_id` FOREIGN KEY (`tertiary_visit_supervising_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_tertiary_discharge_follow_up_provider_clinician_id` FOREIGN KEY (`tertiary_discharge_follow_up_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_recall_impact` ADD CONSTRAINT `fk_encounter_visit_recall_impact_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= encounter --> radiology (1 constraint(s)) =========
-- Requires: encounter schema, radiology schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_interventional_procedure_id` FOREIGN KEY (`interventional_procedure_id`) REFERENCES `healthcare_ecm`.`radiology`.`interventional_procedure`(`interventional_procedure_id`);

-- ========= encounter --> reference (15 constraint(s)) =========
-- Requires: encounter schema, reference schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);

-- ========= encounter --> research (5 constraint(s)) =========
-- Requires: encounter schema, research schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= encounter --> supply (6 constraint(s)) =========
-- Requires: encounter schema, supply schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `healthcare_ecm`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_recall_impact` ADD CONSTRAINT `fk_encounter_visit_recall_impact_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `healthcare_ecm`.`supply`.`recall_notice`(`recall_notice_id`);

-- ========= encounter --> workforce (11 constraint(s)) =========
-- Requires: encounter schema, workforce schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= facility --> compliance (3 constraint(s)) =========
-- Requires: facility schema, compliance schema
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);

-- ========= facility --> encounter (2 constraint(s)) =========
-- Requires: facility schema, encounter schema
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= facility --> finance (6 constraint(s)) =========
-- Requires: facility schema, finance schema
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= facility --> insurance (1 constraint(s)) =========
-- Requires: facility schema, insurance schema
ALTER TABLE `healthcare_ecm`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= facility --> patient (3 constraint(s)) =========
-- Requires: facility schema, patient schema
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= facility --> provider (2 constraint(s)) =========
-- Requires: facility schema, provider schema
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= facility --> quality (1 constraint(s)) =========
-- Requires: facility schema, quality schema
ALTER TABLE `healthcare_ecm`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_program`(`quality_program_id`);

-- ========= facility --> reference (2 constraint(s)) =========
-- Requires: facility schema, reference schema
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= facility --> supply (3 constraint(s)) =========
-- Requires: facility schema, supply schema
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= facility --> workforce (21 constraint(s)) =========
-- Requires: facility schema, workforce schema
ALTER TABLE `healthcare_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_tertiary_maintenance_approved_by_employee_id` FOREIGN KEY (`tertiary_maintenance_approved_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_primary_environmental_employee_id` FOREIGN KEY (`primary_environmental_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_tertiary_environmental_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_environmental_cancelled_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_competency_verifier_employee_id` FOREIGN KEY (`competency_verifier_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> facility (11 constraint(s)) =========
-- Requires: finance schema, facility schema
ALTER TABLE `healthcare_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= finance --> provider (1 constraint(s)) =========
-- Requires: finance schema, provider schema
ALTER TABLE `healthcare_ecm`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= finance --> radiology (1 constraint(s)) =========
-- Requires: finance schema, radiology schema
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `healthcare_ecm`.`radiology`.`modality`(`modality_id`);

-- ========= finance --> reference (1 constraint(s)) =========
-- Requires: finance schema, reference schema
ALTER TABLE `healthcare_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);

-- ========= finance --> research (1 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `healthcare_ecm`.`research`.`grant`(`grant_id`);

-- ========= finance --> supply (7 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `healthcare_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `healthcare_ecm`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> workforce (73 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `healthcare_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_tertiary_journal_approved_by_user_employee_id` FOREIGN KEY (`tertiary_journal_approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_last_modified_by_employee_id` FOREIGN KEY (`budget_last_modified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fte_budget_id` FOREIGN KEY (`fte_budget_id`) REFERENCES `healthcare_ecm`.`workforce`.`fte_budget`(`fte_budget_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `healthcare_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_primary_budget_requestor_employee_id` FOREIGN KEY (`primary_budget_requestor_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_tertiary_ap_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ap_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_quaternary_ar_assigned_collector_employee_id` FOREIGN KEY (`quaternary_ar_assigned_collector_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_tertiary_ar_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ar_last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_primary_capital_employee_id` FOREIGN KEY (`primary_capital_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_primary_capital_employee_id` FOREIGN KEY (`primary_capital_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_modified_by_employee_id` FOREIGN KEY (`tertiary_cost_modified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_primary_allocation_employee_id` FOREIGN KEY (`primary_allocation_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_bank_employee_id` FOREIGN KEY (`primary_bank_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_primary_financial_employee_id` FOREIGN KEY (`primary_financial_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_primary_financial_preparer_employee_id` FOREIGN KEY (`primary_financial_preparer_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`invoice_payment_application` ADD CONSTRAINT `fk_finance_invoice_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_posted_by_user_employee_id` FOREIGN KEY (`posted_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= insurance --> claim (3 constraint(s)) =========
-- Requires: insurance schema, claim schema
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `healthcare_ecm`.`claim`.`appeal`(`appeal_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= insurance --> clinical (2 constraint(s)) =========
-- Requires: insurance schema, clinical schema
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team`(`care_team_id`);

-- ========= insurance --> compliance (5 constraint(s)) =========
-- Requires: insurance schema, compliance schema
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= insurance --> consent (6 constraint(s)) =========
-- Requires: insurance schema, consent schema
ALTER TABLE `healthcare_ecm`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `healthcare_ecm`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `healthcare_ecm`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `healthcare_ecm`.`consent`.`form_template`(`form_template_id`);

-- ========= insurance --> encounter (5 constraint(s)) =========
-- Requires: insurance schema, encounter schema
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= insurance --> facility (3 constraint(s)) =========
-- Requires: insurance schema, facility schema
ALTER TABLE `healthcare_ecm`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= insurance --> finance (4 constraint(s)) =========
-- Requires: insurance schema, finance schema
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= insurance --> patient (11 constraint(s)) =========
-- Requires: insurance schema, patient schema
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_member_mpi_record_id` FOREIGN KEY (`member_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_member_mpi_record_id` FOREIGN KEY (`member_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= insurance --> pharmacy (2 constraint(s)) =========
-- Requires: insurance schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= insurance --> provider (26 constraint(s)) =========
-- Requires: insurance schema, provider schema
ALTER TABLE `healthcare_ecm`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `healthcare_ecm`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `healthcare_ecm`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `healthcare_ecm`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `healthcare_ecm`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `healthcare_ecm`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= insurance --> quality (4 constraint(s)) =========
-- Requires: insurance schema, quality schema
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_program`(`quality_program_id`);

-- ========= insurance --> reference (12 constraint(s)) =========
-- Requires: insurance schema, reference schema
ALTER TABLE `healthcare_ecm`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= insurance --> supply (1 constraint(s)) =========
-- Requires: insurance schema, supply schema
ALTER TABLE `healthcare_ecm`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= insurance --> workforce (2 constraint(s)) =========
-- Requires: insurance schema, workforce schema
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= interoperability --> clinical (4 constraint(s)) =========
-- Requires: interoperability schema, clinical schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_immunization_id` FOREIGN KEY (`immunization_id`) REFERENCES `healthcare_ecm`.`clinical`.`immunization`(`immunization_id`);

-- ========= interoperability --> compliance (1 constraint(s)) =========
-- Requires: interoperability schema, compliance schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);

-- ========= interoperability --> consent (1 constraint(s)) =========
-- Requires: interoperability schema, consent schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm`.`consent`.`consent_policy`(`consent_policy_id`);

-- ========= interoperability --> encounter (11 constraint(s)) =========
-- Requires: interoperability schema, encounter schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_validation_result` ADD CONSTRAINT `fk_interoperability_cda_validation_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= interoperability --> facility (12 constraint(s)) =========
-- Requires: interoperability schema, facility schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`interface_engine` ADD CONSTRAINT `fk_interoperability_interface_engine_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_receiving_facility_care_site_id` FOREIGN KEY (`receiving_facility_care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= interoperability --> finance (3 constraint(s)) =========
-- Requires: interoperability schema, finance schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);

-- ========= interoperability --> patient (14 constraint(s)) =========
-- Requires: interoperability schema, patient schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_matched_empi_mpi_record_id` FOREIGN KEY (`matched_empi_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= interoperability --> provider (12 constraint(s)) =========
-- Requires: interoperability schema, provider schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`trading_partner` ADD CONSTRAINT `fk_interoperability_trading_partner_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= interoperability --> quality (1 constraint(s)) =========
-- Requires: interoperability schema, quality schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);

-- ========= interoperability --> reference (9 constraint(s)) =========
-- Requires: interoperability schema, reference schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`mapping_rule` ADD CONSTRAINT `fk_interoperability_mapping_rule_crosswalk_id` FOREIGN KEY (`crosswalk_id`) REFERENCES `healthcare_ecm`.`reference`.`crosswalk`(`crosswalk_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= interoperability --> scheduling (3 constraint(s)) =========
-- Requires: interoperability schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= interoperability --> workforce (10 constraint(s)) =========
-- Requires: interoperability schema, workforce schema
ALTER TABLE `healthcare_ecm`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_tertiary_terminology_modified_by_user_employee_id` FOREIGN KEY (`tertiary_terminology_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> billing (3 constraint(s)) =========
-- Requires: laboratory schema, billing schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);

-- ========= laboratory --> claim (4 constraint(s)) =========
-- Requires: laboratory schema, claim schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= laboratory --> compliance (21 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `healthcare_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `healthcare_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= laboratory --> consent (8 constraint(s)) =========
-- Requires: laboratory schema, consent schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`substance_use_consent`(`substance_use_consent_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_genetic_testing_consent_id` FOREIGN KEY (`genetic_testing_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`genetic_testing_consent`(`genetic_testing_consent_id`);

-- ========= laboratory --> encounter (9 constraint(s)) =========
-- Requires: laboratory schema, encounter schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= laboratory --> facility (8 constraint(s)) =========
-- Requires: laboratory schema, facility schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);

-- ========= laboratory --> finance (15 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= laboratory --> insurance (12 constraint(s)) =========
-- Requires: laboratory schema, insurance schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);

-- ========= laboratory --> interoperability (9 constraint(s)) =========
-- Requires: laboratory schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);

-- ========= laboratory --> order (2 constraint(s)) =========
-- Requires: laboratory schema, order schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= laboratory --> patient (10 constraint(s)) =========
-- Requires: laboratory schema, patient schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= laboratory --> provider (8 constraint(s)) =========
-- Requires: laboratory schema, provider schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_tertiary_lab_cancelled_by_provider_clinician_id` FOREIGN KEY (`tertiary_lab_cancelled_by_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_tertiary_test_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_test_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= laboratory --> quality (13 constraint(s)) =========
-- Requires: laboratory schema, quality schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_mortality_review_id` FOREIGN KEY (`mortality_review_id`) REFERENCES `healthcare_ecm`.`quality`.`mortality_review`(`mortality_review_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `healthcare_ecm`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_program`(`accreditation_program_id`);

-- ========= laboratory --> reference (18 constraint(s)) =========
-- Requires: laboratory schema, reference schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= laboratory --> research (6 constraint(s)) =========
-- Requires: laboratory schema, research schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= laboratory --> scheduling (4 constraint(s)) =========
-- Requires: laboratory schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= laboratory --> supply (11 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `healthcare_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= laboratory --> workforce (10 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_tertiary_test_amending_user_employee_id` FOREIGN KEY (`tertiary_test_amending_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= order --> compliance (18 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_attestation_id` FOREIGN KEY (`attestation_id`) REFERENCES `healthcare_ecm`.`compliance`.`attestation`(`attestation_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_hipaa_security_risk_id` FOREIGN KEY (`hipaa_security_risk_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_security_risk`(`hipaa_security_risk_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= order --> consent (6 constraint(s)) =========
-- Requires: order schema, consent schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `healthcare_ecm`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `healthcare_ecm`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= order --> encounter (9 constraint(s)) =========
-- Requires: order schema, encounter schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= order --> facility (10 constraint(s)) =========
-- Requires: order schema, facility schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= order --> finance (5 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= order --> insurance (12 constraint(s)) =========
-- Requires: order schema, insurance schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= order --> interoperability (6 constraint(s)) =========
-- Requires: order schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_source_system_event_message_log_id` FOREIGN KEY (`source_system_event_message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);

-- ========= order --> laboratory (1 constraint(s)) =========
-- Requires: order schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);

-- ========= order --> patient (10 constraint(s)) =========
-- Requires: order schema, patient schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= order --> provider (20 constraint(s)) =========
-- Requires: order schema, provider schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_primary_clinical_clinician_id` FOREIGN KEY (`primary_clinical_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_tertiary_clinical_authorizing_provider_clinician_id` FOREIGN KEY (`tertiary_clinical_authorizing_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_receiving_provider_clinician_id` FOREIGN KEY (`receiving_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_set_clinician_id` FOREIGN KEY (`set_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_fulfillment_ordering_provider_clinician_id` FOREIGN KEY (`fulfillment_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_receiving_clinician_id` FOREIGN KEY (`receiving_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= order --> quality (6 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);

-- ========= order --> radiology (1 constraint(s)) =========
-- Requires: order schema, radiology schema
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm`.`radiology`.`protocol`(`protocol_id`);

-- ========= order --> reference (15 constraint(s)) =========
-- Requires: order schema, reference schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= order --> research (8 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= order --> scheduling (3 constraint(s)) =========
-- Requires: order schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= order --> supply (7 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= order --> workforce (20 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_previous_destination_department_org_unit_id` FOREIGN KEY (`previous_destination_department_org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_source_department_org_unit_id` FOREIGN KEY (`source_department_org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= patient --> clinical (4 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `healthcare_ecm`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `healthcare_ecm`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team`(`care_team_id`);

-- ========= patient --> compliance (1 constraint(s)) =========
-- Requires: patient schema, compliance schema
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= patient --> consent (1 constraint(s)) =========
-- Requires: patient schema, consent schema
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);

-- ========= patient --> encounter (6 constraint(s)) =========
-- Requires: patient schema, encounter schema
ALTER TABLE `healthcare_ecm`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= patient --> facility (16 constraint(s)) =========
-- Requires: patient schema, facility schema
ALTER TABLE `healthcare_ecm`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `healthcare_ecm`.`facility`.`contract`(`contract_id`);

-- ========= patient --> finance (4 constraint(s)) =========
-- Requires: patient schema, finance schema
ALTER TABLE `healthcare_ecm`.`patient`.`guarantor` ADD CONSTRAINT `fk_patient_guarantor_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `healthcare_ecm`.`finance`.`fund`(`fund_id`);

-- ========= patient --> insurance (13 constraint(s)) =========
-- Requires: patient schema, insurance schema
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_accountable_care_organization_id` FOREIGN KEY (`accountable_care_organization_id`) REFERENCES `healthcare_ecm`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= patient --> interoperability (1 constraint(s)) =========
-- Requires: patient schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_organization`(`hie_organization_id`);

-- ========= patient --> order (1 constraint(s)) =========
-- Requires: patient schema, order schema
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= patient --> pharmacy (2 constraint(s)) =========
-- Requires: patient schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_preference_preferred_pharmacy_pharmacy_location_id` FOREIGN KEY (`preference_preferred_pharmacy_pharmacy_location_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= patient --> provider (18 constraint(s)) =========
-- Requires: patient schema, provider schema
ALTER TABLE `healthcare_ecm`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_tertiary_registration_pcp_provider_clinician_id` FOREIGN KEY (`tertiary_registration_pcp_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_flag_resolved_by_provider_clinician_id` FOREIGN KEY (`flag_resolved_by_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_flag_reviewed_by_provider_clinician_id` FOREIGN KEY (`flag_reviewed_by_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= patient --> quality (2 constraint(s)) =========
-- Requires: patient schema, quality schema
ALTER TABLE `healthcare_ecm`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_program`(`quality_program_id`);

-- ========= patient --> radiology (1 constraint(s)) =========
-- Requires: patient schema, radiology schema
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= patient --> reference (6 constraint(s)) =========
-- Requires: patient schema, reference schema
ALTER TABLE `healthcare_ecm`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);

-- ========= patient --> workforce (11 constraint(s)) =========
-- Requires: patient schema, workforce schema
ALTER TABLE `healthcare_ecm`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= pharmacy --> claim (8 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= pharmacy --> clinical (7 constraint(s)) =========
-- Requires: pharmacy schema, clinical schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= pharmacy --> compliance (23 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `healthcare_ecm`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);

-- ========= pharmacy --> consent (5 constraint(s)) =========
-- Requires: pharmacy schema, consent schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`substance_use_consent`(`substance_use_consent_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= pharmacy --> encounter (8 constraint(s)) =========
-- Requires: pharmacy schema, encounter schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= pharmacy --> facility (6 constraint(s)) =========
-- Requires: pharmacy schema, facility schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `healthcare_ecm`.`facility`.`contract`(`contract_id`);

-- ========= pharmacy --> finance (6 constraint(s)) =========
-- Requires: pharmacy schema, finance schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= pharmacy --> insurance (7 constraint(s)) =========
-- Requires: pharmacy schema, insurance schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= pharmacy --> interoperability (28 constraint(s)) =========
-- Requires: pharmacy schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_terminology_mapping_id` FOREIGN KEY (`terminology_mapping_id`) REFERENCES `healthcare_ecm`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_terminology_mapping_id` FOREIGN KEY (`terminology_mapping_id`) REFERENCES `healthcare_ecm`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `healthcare_ecm`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `healthcare_ecm`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);

-- ========= pharmacy --> laboratory (7 constraint(s)) =========
-- Requires: pharmacy schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= pharmacy --> order (6 constraint(s)) =========
-- Requires: pharmacy schema, order schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= pharmacy --> patient (13 constraint(s)) =========
-- Requires: pharmacy schema, patient schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescription_patient_mpi_record_id` FOREIGN KEY (`prescription_patient_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= pharmacy --> provider (13 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescription_prescriber_clinician_id` FOREIGN KEY (`prescription_prescriber_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= pharmacy --> quality (8 constraint(s)) =========
-- Requires: pharmacy schema, quality schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `healthcare_ecm`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `healthcare_ecm`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `healthcare_ecm`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);

-- ========= pharmacy --> reference (15 constraint(s)) =========
-- Requires: pharmacy schema, reference schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= pharmacy --> research (11 constraint(s)) =========
-- Requires: pharmacy schema, research schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `healthcare_ecm`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `healthcare_ecm`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= pharmacy --> scheduling (1 constraint(s)) =========
-- Requires: pharmacy schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= pharmacy --> supply (8 constraint(s)) =========
-- Requires: pharmacy schema, supply schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);

-- ========= pharmacy --> workforce (12 constraint(s)) =========
-- Requires: pharmacy schema, workforce schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= provider --> compliance (18 constraint(s)) =========
-- Requires: provider schema, compliance schema
ALTER TABLE `healthcare_ecm`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`telehealth_authorization` ADD CONSTRAINT `fk_provider_telehealth_authorization_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);

-- ========= provider --> facility (14 constraint(s)) =========
-- Requires: provider schema, facility schema
ALTER TABLE `healthcare_ecm`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`telehealth_authorization` ADD CONSTRAINT `fk_provider_telehealth_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= provider --> finance (10 constraint(s)) =========
-- Requires: provider schema, finance schema
ALTER TABLE `healthcare_ecm`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= provider --> insurance (11 constraint(s)) =========
-- Requires: provider schema, insurance schema
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= provider --> quality (4 constraint(s)) =========
-- Requires: provider schema, quality schema
ALTER TABLE `healthcare_ecm`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`survey_participation` ADD CONSTRAINT `fk_provider_survey_participation_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm`.`quality`.`accreditation_survey`(`accreditation_survey_id`);

-- ========= provider --> reference (11 constraint(s)) =========
-- Requires: provider schema, reference schema
ALTER TABLE `healthcare_ecm`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= provider --> research (1 constraint(s)) =========
-- Requires: provider schema, research schema
ALTER TABLE `healthcare_ecm`.`provider`.`study_team_member` ADD CONSTRAINT `fk_provider_study_team_member_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= provider --> supply (4 constraint(s)) =========
-- Requires: provider schema, supply schema
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `healthcare_ecm`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`preference_card` ADD CONSTRAINT `fk_provider_preference_card_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= provider --> workforce (15 constraint(s)) =========
-- Requires: provider schema, workforce schema
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`education_training` ADD CONSTRAINT `fk_provider_education_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `healthcare_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`committee` ADD CONSTRAINT `fk_provider_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`committee` ADD CONSTRAINT `fk_provider_committee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= quality --> billing (10 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`billing_coverage`(`billing_coverage_id`);

-- ========= quality --> claim (3 constraint(s)) =========
-- Requires: quality schema, claim schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= quality --> clinical (1 constraint(s)) =========
-- Requires: quality schema, clinical schema
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_cdi_worksheet_id` FOREIGN KEY (`cdi_worksheet_id`) REFERENCES `healthcare_ecm`.`clinical`.`cdi_worksheet`(`cdi_worksheet_id`);

-- ========= quality --> compliance (20 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `healthcare_ecm`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);

-- ========= quality --> consent (6 constraint(s)) =========
-- Requires: quality schema, consent schema
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);

-- ========= quality --> encounter (16 constraint(s)) =========
-- Requires: quality schema, encounter schema
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_bed_assignment_id` FOREIGN KEY (`bed_assignment_id`) REFERENCES `healthcare_ecm`.`encounter`.`bed_assignment`(`bed_assignment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_triage_assessment_id` FOREIGN KEY (`triage_assessment_id`) REFERENCES `healthcare_ecm`.`encounter`.`triage_assessment`(`triage_assessment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `healthcare_ecm`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_readmission_id` FOREIGN KEY (`readmission_id`) REFERENCES `healthcare_ecm`.`encounter`.`readmission`(`readmission_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_visit_provider_id` FOREIGN KEY (`visit_provider_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_provider`(`visit_provider_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= quality --> facility (33 constraint(s)) =========
-- Requires: quality schema, facility schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_environmental_service_request_id` FOREIGN KEY (`environmental_service_request_id`) REFERENCES `healthcare_ecm`.`facility`.`environmental_service_request`(`environmental_service_request_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_hazardous_material_id` FOREIGN KEY (`hazardous_material_id`) REFERENCES `healthcare_ecm`.`facility`.`hazardous_material`(`hazardous_material_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `healthcare_ecm`.`facility`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `healthcare_ecm`.`facility`.`contract`(`contract_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`committee` ADD CONSTRAINT `fk_quality_committee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= quality --> finance (10 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `healthcare_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_capital_expenditure_id` FOREIGN KEY (`capital_expenditure_id`) REFERENCES `healthcare_ecm`.`finance`.`capital_expenditure`(`capital_expenditure_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `healthcare_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`committee` ADD CONSTRAINT `fk_quality_committee_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm`.`finance`.`financial_entity`(`financial_entity_id`);

-- ========= quality --> insurance (17 constraint(s)) =========
-- Requires: quality schema, insurance schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= quality --> interoperability (8 constraint(s)) =========
-- Requires: quality schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `healthcare_ecm`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_interface_downtime_id` FOREIGN KEY (`interface_downtime_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_downtime`(`interface_downtime_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_onboarding_project_id` FOREIGN KEY (`onboarding_project_id`) REFERENCES `healthcare_ecm`.`interoperability`.`onboarding_project`(`onboarding_project_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_interface_downtime_id` FOREIGN KEY (`interface_downtime_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_downtime`(`interface_downtime_id`);

-- ========= quality --> patient (12 constraint(s)) =========
-- Requires: quality schema, patient schema
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_care_program_enrollment_id` FOREIGN KEY (`care_program_enrollment_id`) REFERENCES `healthcare_ecm`.`patient`.`care_program_enrollment`(`care_program_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_pcp_attribution_id` FOREIGN KEY (`pcp_attribution_id`) REFERENCES `healthcare_ecm`.`patient`.`pcp_attribution`(`pcp_attribution_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);

-- ========= quality --> provider (15 constraint(s)) =========
-- Requires: quality schema, provider schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_reviewer_provider_clinician_id` FOREIGN KEY (`reviewer_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= quality --> radiology (12 constraint(s)) =========
-- Requires: quality schema, radiology schema
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_contrast_admin_id` FOREIGN KEY (`contrast_admin_id`) REFERENCES `healthcare_ecm`.`radiology`.`contrast_admin`(`contrast_admin_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_critical_result_id` FOREIGN KEY (`critical_result_id`) REFERENCES `healthcare_ecm`.`radiology`.`critical_result`(`critical_result_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_dose_record_id` FOREIGN KEY (`dose_record_id`) REFERENCES `healthcare_ecm`.`radiology`.`dose_record`(`dose_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `healthcare_ecm`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_critical_result_id` FOREIGN KEY (`critical_result_id`) REFERENCES `healthcare_ecm`.`radiology`.`critical_result`(`critical_result_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_radiology_appointment_id` FOREIGN KEY (`radiology_appointment_id`) REFERENCES `healthcare_ecm`.`radiology`.`radiology_appointment`(`radiology_appointment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm`.`radiology`.`report`(`report_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `healthcare_ecm`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_reader_assignment_id` FOREIGN KEY (`reader_assignment_id`) REFERENCES `healthcare_ecm`.`radiology`.`reader_assignment`(`reader_assignment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `healthcare_ecm`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_follow_up_id` FOREIGN KEY (`follow_up_id`) REFERENCES `healthcare_ecm`.`radiology`.`follow_up`(`follow_up_id`);

-- ========= quality --> reference (20 constraint(s)) =========
-- Requires: quality schema, reference schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= quality --> research (11 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `healthcare_ecm`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_study_research_study_id` FOREIGN KEY (`study_research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= quality --> supply (8 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `healthcare_ecm`.`supply`.`udi_record`(`udi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `healthcare_ecm`.`supply`.`udi_record`(`udi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `healthcare_ecm`.`supply`.`udi_record`(`udi_record_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `healthcare_ecm`.`supply`.`recall_notice`(`recall_notice_id`);

-- ========= quality --> workforce (14 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `healthcare_ecm`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_primary_improvement_employee_id` FOREIGN KEY (`primary_improvement_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_last_updated_by_employee_id` FOREIGN KEY (`last_updated_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`committee` ADD CONSTRAINT `fk_quality_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`quality`.`committee` ADD CONSTRAINT `fk_quality_committee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= radiology --> billing (2 constraint(s)) =========
-- Requires: radiology schema, billing schema
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);

-- ========= radiology --> claim (4 constraint(s)) =========
-- Requires: radiology schema, claim schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= radiology --> clinical (1 constraint(s)) =========
-- Requires: radiology schema, clinical schema
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cdi_query_id` FOREIGN KEY (`cdi_query_id`) REFERENCES `healthcare_ecm`.`clinical`.`cdi_query`(`cdi_query_id`);

-- ========= radiology --> compliance (18 constraint(s)) =========
-- Requires: radiology schema, compliance schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);

-- ========= radiology --> consent (4 constraint(s)) =========
-- Requires: radiology schema, consent schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= radiology --> encounter (15 constraint(s)) =========
-- Requires: radiology schema, encounter schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= radiology --> facility (18 constraint(s)) =========
-- Requires: radiology schema, facility schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `healthcare_ecm`.`facility`.`contract`(`contract_id`);

-- ========= radiology --> finance (5 constraint(s)) =========
-- Requires: radiology schema, finance schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= radiology --> insurance (7 constraint(s)) =========
-- Requires: radiology schema, insurance schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= radiology --> interoperability (17 constraint(s)) =========
-- Requires: radiology schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= radiology --> laboratory (4 constraint(s)) =========
-- Requires: radiology schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= radiology --> order (9 constraint(s)) =========
-- Requires: radiology schema, order schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= radiology --> patient (13 constraint(s)) =========
-- Requires: radiology schema, patient schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= radiology --> pharmacy (5 constraint(s)) =========
-- Requires: radiology schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= radiology --> provider (20 constraint(s)) =========
-- Requires: radiology schema, provider schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_report_clinician_id` FOREIGN KEY (`report_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_report_reading_radiologist_clinician_id` FOREIGN KEY (`report_reading_radiologist_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_tertiary_report_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_report_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_tertiary_radiology_referring_provider_clinician_id` FOREIGN KEY (`tertiary_radiology_referring_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_tertiary_critical_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_critical_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= radiology --> reference (24 constraint(s)) =========
-- Requires: radiology schema, reference schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= radiology --> research (9 constraint(s)) =========
-- Requires: radiology schema, research schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);

-- ========= radiology --> scheduling (3 constraint(s)) =========
-- Requires: radiology schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= radiology --> supply (5 constraint(s)) =========
-- Requires: radiology schema, supply schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= radiology --> workforce (19 constraint(s)) =========
-- Requires: radiology schema, workforce schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= research --> billing (7 constraint(s)) =========
-- Requires: research schema, billing schema
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `healthcare_ecm`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= research --> claim (2 constraint(s)) =========
-- Requires: research schema, claim schema
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_line_id` FOREIGN KEY (`line_id`) REFERENCES `healthcare_ecm`.`claim`.`line`(`line_id`);

-- ========= research --> clinical (6 constraint(s)) =========
-- Requires: research schema, clinical schema
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `healthcare_ecm`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_vital_sign_id` FOREIGN KEY (`vital_sign_id`) REFERENCES `healthcare_ecm`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= research --> compliance (46 constraint(s)) =========
-- Requires: research schema, compliance schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_notice_of_privacy_practices_id` FOREIGN KEY (`notice_of_privacy_practices_id`) REFERENCES `healthcare_ecm`.`compliance`.`notice_of_privacy_practices`(`notice_of_privacy_practices_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_attestation_id` FOREIGN KEY (`attestation_id`) REFERENCES `healthcare_ecm`.`compliance`.`attestation`(`attestation_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_notice_of_privacy_practices_id` FOREIGN KEY (`notice_of_privacy_practices_id`) REFERENCES `healthcare_ecm`.`compliance`.`notice_of_privacy_practices`(`notice_of_privacy_practices_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `healthcare_ecm`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_exclusion_screening_id` FOREIGN KEY (`exclusion_screening_id`) REFERENCES `healthcare_ecm`.`compliance`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `healthcare_ecm`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `healthcare_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_sponsor` ADD CONSTRAINT `fk_research_study_sponsor_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_sponsor` ADD CONSTRAINT `fk_research_study_sponsor_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `healthcare_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `healthcare_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);

-- ========= research --> consent (6 constraint(s)) =========
-- Requires: research schema, consent schema
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `healthcare_ecm`.`consent`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `healthcare_ecm`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_genetic_testing_consent_id` FOREIGN KEY (`genetic_testing_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`genetic_testing_consent`(`genetic_testing_consent_id`);
ALTER TABLE `healthcare_ecm`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_deficiency_id` FOREIGN KEY (`deficiency_id`) REFERENCES `healthcare_ecm`.`consent`.`deficiency`(`deficiency_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_deficiency_id` FOREIGN KEY (`deficiency_id`) REFERENCES `healthcare_ecm`.`consent`.`deficiency`(`deficiency_id`);

-- ========= research --> encounter (3 constraint(s)) =========
-- Requires: research schema, encounter schema
ALTER TABLE `healthcare_ecm`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= research --> facility (15 constraint(s)) =========
-- Requires: research schema, facility schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= research --> finance (9 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `healthcare_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `healthcare_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `healthcare_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);

-- ========= research --> insurance (7 constraint(s)) =========
-- Requires: research schema, insurance schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);

-- ========= research --> interoperability (13 constraint(s)) =========
-- Requires: research schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_patient_identity_match_id` FOREIGN KEY (`patient_identity_match_id`) REFERENCES `healthcare_ecm`.`interoperability`.`patient_identity_match`(`patient_identity_match_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `healthcare_ecm`.`research`.`dsmb_committee` ADD CONSTRAINT `fk_research_dsmb_committee_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `healthcare_ecm`.`interoperability`.`hie_organization`(`hie_organization_id`);

-- ========= research --> laboratory (5 constraint(s)) =========
-- Requires: research schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_lab_charge_id` FOREIGN KEY (`lab_charge_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_charge`(`lab_charge_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);

-- ========= research --> patient (6 constraint(s)) =========
-- Requires: research schema, patient schema
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= research --> provider (10 constraint(s)) =========
-- Requires: research schema, provider schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= research --> reference (11 constraint(s)) =========
-- Requires: research schema, reference schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);

-- ========= research --> supply (9 constraint(s)) =========
-- Requires: research schema, supply schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `healthcare_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= research --> workforce (26 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `healthcare_ecm`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_tertiary_irb_reviewed_by_user_employee_id` FOREIGN KEY (`tertiary_irb_reviewed_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_primary_informed_employee_id` FOREIGN KEY (`primary_informed_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_secretary_person_employee_id` FOREIGN KEY (`secretary_person_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_vice_chair_person_employee_id` FOREIGN KEY (`vice_chair_person_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= scheduling --> billing (3 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= scheduling --> claim (6 constraint(s)) =========
-- Requires: scheduling schema, claim schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= scheduling --> clinical (14 constraint(s)) =========
-- Requires: scheduling schema, clinical schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_immunization_id` FOREIGN KEY (`immunization_id`) REFERENCES `healthcare_ecm`.`clinical`.`immunization`(`immunization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= scheduling --> compliance (14 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);

-- ========= scheduling --> consent (6 constraint(s)) =========
-- Requires: scheduling schema, consent schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_telehealth_consent_id` FOREIGN KEY (`telehealth_consent_id`) REFERENCES `healthcare_ecm`.`consent`.`telehealth_consent`(`telehealth_consent_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_record_id` FOREIGN KEY (`record_id`) REFERENCES `healthcare_ecm`.`consent`.`record`(`record_id`);

-- ========= scheduling --> encounter (7 constraint(s)) =========
-- Requires: scheduling schema, encounter schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);

-- ========= scheduling --> facility (29 constraint(s)) =========
-- Requires: scheduling schema, facility schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `healthcare_ecm`.`facility`.`contract`(`contract_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= scheduling --> finance (8 constraint(s)) =========
-- Requires: scheduling schema, finance schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `healthcare_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= scheduling --> insurance (13 constraint(s)) =========
-- Requires: scheduling schema, insurance schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= scheduling --> interoperability (2 constraint(s)) =========
-- Requires: scheduling schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);

-- ========= scheduling --> laboratory (1 constraint(s)) =========
-- Requires: scheduling schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= scheduling --> order (4 constraint(s)) =========
-- Requires: scheduling schema, order schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= scheduling --> patient (10 constraint(s)) =========
-- Requires: scheduling schema, patient schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);

-- ========= scheduling --> provider (22 constraint(s)) =========
-- Requires: scheduling schema, provider schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_dea_registration_id` FOREIGN KEY (`dea_registration_id`) REFERENCES `healthcare_ecm`.`provider`.`dea_registration`(`dea_registration_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `healthcare_ecm`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `healthcare_ecm`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_board_certification_id` FOREIGN KEY (`board_certification_id`) REFERENCES `healthcare_ecm`.`provider`.`board_certification`(`board_certification_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_malpractice_coverage_id` FOREIGN KEY (`malpractice_coverage_id`) REFERENCES `healthcare_ecm`.`provider`.`malpractice_coverage`(`malpractice_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `healthcare_ecm`.`provider`.`credential`(`credential_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_telehealth_authorization_id` FOREIGN KEY (`telehealth_authorization_id`) REFERENCES `healthcare_ecm`.`provider`.`telehealth_authorization`(`telehealth_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);

-- ========= scheduling --> quality (3 constraint(s)) =========
-- Requires: scheduling schema, quality schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm`.`quality`.`population_health_gap`(`population_health_gap_id`);

-- ========= scheduling --> reference (11 constraint(s)) =========
-- Requires: scheduling schema, reference schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= scheduling --> research (7 constraint(s)) =========
-- Requires: scheduling schema, research schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `healthcare_ecm`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= scheduling --> supply (4 constraint(s)) =========
-- Requires: scheduling schema, supply schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `healthcare_ecm`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= scheduling --> workforce (35 constraint(s)) =========
-- Requires: scheduling schema, workforce schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_tertiary_schedule_approved_by_user_employee_id` FOREIGN KEY (`tertiary_schedule_approved_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_quaternary_resource_cancelled_by_user_employee_id` FOREIGN KEY (`quaternary_resource_cancelled_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_tertiary_resource_requested_by_user_employee_id` FOREIGN KEY (`tertiary_resource_requested_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_tertiary_patient_modified_by_user_employee_id` FOREIGN KEY (`tertiary_patient_modified_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_tertiary_provider_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_provider_cancelled_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_tertiary_surgical_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_surgical_cancelled_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_tertiary_equipment_requested_by_user_employee_id` FOREIGN KEY (`tertiary_equipment_requested_by_user_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= supply --> clinical (1 constraint(s)) =========
-- Requires: supply schema, clinical schema
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= supply --> compliance (11 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= supply --> consent (1 constraint(s)) =========
-- Requires: supply schema, consent schema
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_event_id` FOREIGN KEY (`event_id`) REFERENCES `healthcare_ecm`.`consent`.`event`(`event_id`);

-- ========= supply --> encounter (2 constraint(s)) =========
-- Requires: supply schema, encounter schema
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= supply --> facility (16 constraint(s)) =========
-- Requires: supply schema, facility schema
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= supply --> finance (13 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `healthcare_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= supply --> insurance (5 constraint(s)) =========
-- Requires: supply schema, insurance schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= supply --> interoperability (5 constraint(s)) =========
-- Requires: supply schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_terminology_mapping_id` FOREIGN KEY (`terminology_mapping_id`) REFERENCES `healthcare_ecm`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm`.`interoperability`.`public_health_report`(`public_health_report_id`);

-- ========= supply --> order (8 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= supply --> patient (1 constraint(s)) =========
-- Requires: supply schema, patient schema
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= supply --> provider (3 constraint(s)) =========
-- Requires: supply schema, provider schema
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_preference_card_id` FOREIGN KEY (`preference_card_id`) REFERENCES `healthcare_ecm`.`provider`.`preference_card`(`preference_card_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= supply --> reference (7 constraint(s)) =========
-- Requires: supply schema, reference schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= supply --> scheduling (3 constraint(s)) =========
-- Requires: supply schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= supply --> workforce (16 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_tertiary_surgical_supply_chain_owner_employee_id` FOREIGN KEY (`tertiary_surgical_supply_chain_owner_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_tertiary_case_delivered_by_employee_id` FOREIGN KEY (`tertiary_case_delivered_by_employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> facility (14 constraint(s)) =========
-- Requires: workforce schema, facility schema
ALTER TABLE `healthcare_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`education_program` ADD CONSTRAINT `fk_workforce_education_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= workforce --> finance (5 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `healthcare_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= workforce --> insurance (2 constraint(s)) =========
-- Requires: workforce schema, insurance schema
ALTER TABLE `healthcare_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= workforce --> interoperability (1 constraint(s)) =========
-- Requires: workforce schema, interoperability schema
ALTER TABLE `healthcare_ecm`.`workforce`.`channel_support_assignment` ADD CONSTRAINT `fk_workforce_channel_support_assignment_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm`.`interoperability`.`interface_channel`(`interface_channel_id`);

-- ========= workforce --> provider (4 constraint(s)) =========
-- Requires: workforce schema, provider schema
ALTER TABLE `healthcare_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= workforce --> quality (1 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `healthcare_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm`.`quality`.`improvement_initiative`(`improvement_initiative_id`);

-- ========= workforce --> reference (12 constraint(s)) =========
-- Requires: workforce schema, reference schema
ALTER TABLE `healthcare_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);

