-- Cross-Domain Foreign Keys for Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:34
-- Total cross-domain FK constraints: 1517
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, claim, clinical, compliance, encounter, facility, insurance, laboratory, order, patient, pharmacy, provider, radiology, reference, scheduling, supply

-- ========= billing --> claim (8 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `healthcare_ecm`.`claim`.`line`(`line_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `healthcare_ecm`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `healthcare_ecm`.`claim`.`denial`(`denial_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_remittance_line_id` FOREIGN KEY (`remittance_line_id`) REFERENCES `healthcare_ecm`.`claim`.`remittance_line`(`remittance_line_id`);

-- ========= billing --> clinical (4 constraint(s)) =========
-- Requires: billing schema, clinical schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= billing --> encounter (13 constraint(s)) =========
-- Requires: billing schema, encounter schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `healthcare_ecm`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_discharge_summary_id` FOREIGN KEY (`discharge_summary_id`) REFERENCES `healthcare_ecm`.`encounter`.`discharge_summary`(`discharge_summary_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `healthcare_ecm`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= billing --> facility (16 constraint(s)) =========
-- Requires: billing schema, facility schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= billing --> insurance (41 constraint(s)) =========
-- Requires: billing schema, insurance schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_accumulator_id` FOREIGN KEY (`accumulator_id`) REFERENCES `healthcare_ecm`.`insurance`.`accumulator`(`accumulator_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_capitation_contract_id` FOREIGN KEY (`capitation_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_primary_payer_id` FOREIGN KEY (`primary_payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `healthcare_ecm`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_capitation_payment_id` FOREIGN KEY (`capitation_payment_id`) REFERENCES `healthcare_ecm`.`insurance`.`capitation_payment`(`capitation_payment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_employer_group_id` FOREIGN KEY (`employer_group_id`) REFERENCES `healthcare_ecm`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_employer_group_id` FOREIGN KEY (`employer_group_id`) REFERENCES `healthcare_ecm`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);

-- ========= billing --> order (5 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= billing --> patient (22 constraint(s)) =========
-- Requires: billing schema, patient schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `healthcare_ecm`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `healthcare_ecm`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_coverage_mpi_record_id` FOREIGN KEY (`coverage_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= billing --> pharmacy (6 constraint(s)) =========
-- Requires: billing schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= billing --> provider (13 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_charge_ordering_provider_clinician_id` FOREIGN KEY (`charge_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_location_id` FOREIGN KEY (`location_id`) REFERENCES `healthcare_ecm`.`provider`.`location`(`location_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coverage` ADD CONSTRAINT `fk_billing_coverage_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= billing --> radiology (3 constraint(s)) =========
-- Requires: billing schema, radiology schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm`.`radiology`.`report`(`report_id`);

-- ========= billing --> reference (20 constraint(s)) =========
-- Requires: billing schema, reference schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= billing --> scheduling (2 constraint(s)) =========
-- Requires: billing schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= billing --> supply (5 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `healthcare_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);

-- ========= claim --> billing (6 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_coverage_id` FOREIGN KEY (`coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`coverage`(`coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `healthcare_ecm`.`billing`.`patient_account`(`patient_account_id`);

-- ========= claim --> compliance (7 constraint(s)) =========
-- Requires: claim schema, compliance schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim_status_history` ADD CONSTRAINT `fk_claim_claim_status_history_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);

-- ========= claim --> encounter (6 constraint(s)) =========
-- Requires: claim schema, encounter schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= claim --> facility (9 constraint(s)) =========
-- Requires: claim schema, facility schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);

-- ========= claim --> insurance (23 constraint(s)) =========
-- Requires: claim schema, insurance schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_coordination_of_benefits_id` FOREIGN KEY (`coordination_of_benefits_id`) REFERENCES `healthcare_ecm`.`insurance`.`coordination_of_benefits`(`coordination_of_benefits_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `healthcare_ecm`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);

-- ========= claim --> order (3 constraint(s)) =========
-- Requires: claim schema, order schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `healthcare_ecm`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= claim --> patient (13 constraint(s)) =========
-- Requires: claim schema, patient schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_eligibility_mpi_record_id` FOREIGN KEY (`eligibility_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);

-- ========= claim --> pharmacy (2 constraint(s)) =========
-- Requires: claim schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= claim --> provider (15 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_location_id` FOREIGN KEY (`location_id`) REFERENCES `healthcare_ecm`.`provider`.`location`(`location_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= claim --> reference (18 constraint(s)) =========
-- Requires: claim schema, reference schema
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= claim --> supply (2 constraint(s)) =========
-- Requires: claim schema, supply schema
ALTER TABLE `healthcare_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= clinical --> claim (5 constraint(s)) =========
-- Requires: clinical schema, claim schema
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= clinical --> compliance (1 constraint(s)) =========
-- Requires: clinical schema, compliance schema
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= clinical --> encounter (13 constraint(s)) =========
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
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= clinical --> facility (19 constraint(s)) =========
-- Requires: clinical schema, facility schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical --> insurance (19 constraint(s)) =========
-- Requires: clinical schema, insurance schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);

-- ========= clinical --> laboratory (4 constraint(s)) =========
-- Requires: clinical schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);

-- ========= clinical --> order (13 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= clinical --> patient (15 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `healthcare_ecm`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= clinical --> pharmacy (9 constraint(s)) =========
-- Requires: clinical schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_adverse_drug_event_id` FOREIGN KEY (`adverse_drug_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`adverse_drug_event`(`adverse_drug_event_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= clinical --> provider (28 constraint(s)) =========
-- Requires: clinical schema, provider schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_tertiary_procedure_anesthesia_provider_clinician_id` FOREIGN KEY (`tertiary_procedure_anesthesia_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_note_clinician_id` FOREIGN KEY (`note_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_note_cosigner_provider_clinician_id` FOREIGN KEY (`note_cosigner_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
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
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_tertiary_care_pcp_clinician_id` FOREIGN KEY (`tertiary_care_pcp_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_tertiary_care_member_provider_clinician_id` FOREIGN KEY (`tertiary_care_member_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= clinical --> radiology (4 constraint(s)) =========
-- Requires: clinical schema, radiology schema
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm`.`radiology`.`report`(`report_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm`.`radiology`.`report`(`report_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= clinical --> reference (28 constraint(s)) =========
-- Requires: clinical schema, reference schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= clinical --> supply (8 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `healthcare_ecm`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `healthcare_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_inventory_transaction_id` FOREIGN KEY (`inventory_transaction_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= compliance --> clinical (8 constraint(s)) =========
-- Requires: compliance schema, clinical schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_care_team_member_id` FOREIGN KEY (`care_team_member_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team_member`(`care_team_member_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_care_team_member_id` FOREIGN KEY (`care_team_member_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team_member`(`care_team_member_id`);

-- ========= compliance --> facility (14 constraint(s)) =========
-- Requires: compliance schema, facility schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= compliance --> insurance (13 constraint(s)) =========
-- Requires: compliance schema, insurance schema
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= compliance --> patient (7 constraint(s)) =========
-- Requires: compliance schema, patient schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_program_enrollment_id` FOREIGN KEY (`care_program_enrollment_id`) REFERENCES `healthcare_ecm`.`patient`.`care_program_enrollment`(`care_program_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `healthcare_ecm`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `healthcare_ecm`.`patient`.`portal_account`(`portal_account_id`);

-- ========= compliance --> provider (11 constraint(s)) =========
-- Requires: compliance schema, provider schema
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= compliance --> reference (21 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= compliance --> scheduling (5 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `healthcare_ecm`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);

-- ========= compliance --> supply (9 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `healthcare_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `healthcare_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= encounter --> claim (5 constraint(s)) =========
-- Requires: encounter schema, claim schema
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= encounter --> clinical (10 constraint(s)) =========
-- Requires: encounter schema, clinical schema
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_vital_sign_id` FOREIGN KEY (`vital_sign_id`) REFERENCES `healthcare_ecm`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_advance_directive_id` FOREIGN KEY (`advance_directive_id`) REFERENCES `healthcare_ecm`.`clinical`.`advance_directive`(`advance_directive_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm`.`clinical`.`note`(`note_id`);

-- ========= encounter --> compliance (4 constraint(s)) =========
-- Requires: encounter schema, compliance schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_exclusion_screening_id` FOREIGN KEY (`exclusion_screening_id`) REFERENCES `healthcare_ecm`.`compliance`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= encounter --> facility (27 constraint(s)) =========
-- Requires: encounter schema, facility schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);

-- ========= encounter --> insurance (16 constraint(s)) =========
-- Requires: encounter schema, insurance schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_accumulator_id` FOREIGN KEY (`accumulator_id`) REFERENCES `healthcare_ecm`.`insurance`.`accumulator`(`accumulator_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_coordination_of_benefits_id` FOREIGN KEY (`coordination_of_benefits_id`) REFERENCES `healthcare_ecm`.`insurance`.`coordination_of_benefits`(`coordination_of_benefits_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= encounter --> laboratory (2 constraint(s)) =========
-- Requires: encounter schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `healthcare_ecm`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);

-- ========= encounter --> order (5 constraint(s)) =========
-- Requires: encounter schema, order schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);

-- ========= encounter --> patient (17 constraint(s)) =========
-- Requires: encounter schema, patient schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_patient_mpi_record_id` FOREIGN KEY (`visit_patient_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `healthcare_ecm`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= encounter --> pharmacy (1 constraint(s)) =========
-- Requires: encounter schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= encounter --> provider (20 constraint(s)) =========
-- Requires: encounter schema, provider schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_clinician_id` FOREIGN KEY (`visit_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_discharging_provider_clinician_id` FOREIGN KEY (`visit_discharging_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_location_id` FOREIGN KEY (`location_id`) REFERENCES `healthcare_ecm`.`provider`.`location`(`location_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `healthcare_ecm`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_tertiary_visit_supervising_provider_clinician_id` FOREIGN KEY (`tertiary_visit_supervising_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_tertiary_discharge_follow_up_provider_clinician_id` FOREIGN KEY (`tertiary_discharge_follow_up_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= encounter --> radiology (1 constraint(s)) =========
-- Requires: encounter schema, radiology schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= encounter --> reference (20 constraint(s)) =========
-- Requires: encounter schema, reference schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= encounter --> scheduling (2 constraint(s)) =========
-- Requires: encounter schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);

-- ========= encounter --> supply (3 constraint(s)) =========
-- Requires: encounter schema, supply schema
ALTER TABLE `healthcare_ecm`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= facility --> compliance (11 constraint(s)) =========
-- Requires: facility schema, compliance schema
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= facility --> encounter (3 constraint(s)) =========
-- Requires: facility schema, encounter schema
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_adt_event_id` FOREIGN KEY (`adt_event_id`) REFERENCES `healthcare_ecm`.`encounter`.`adt_event`(`adt_event_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= facility --> patient (2 constraint(s)) =========
-- Requires: facility schema, patient schema
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= facility --> provider (6 constraint(s)) =========
-- Requires: facility schema, provider schema
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);

-- ========= facility --> reference (3 constraint(s)) =========
-- Requires: facility schema, reference schema
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= facility --> supply (7 constraint(s)) =========
-- Requires: facility schema, supply schema
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `healthcare_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);

-- ========= insurance --> claim (1 constraint(s)) =========
-- Requires: insurance schema, claim schema
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);

-- ========= insurance --> clinical (1 constraint(s)) =========
-- Requires: insurance schema, clinical schema
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= insurance --> compliance (2 constraint(s)) =========
-- Requires: insurance schema, compliance schema
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= insurance --> encounter (2 constraint(s)) =========
-- Requires: insurance schema, encounter schema
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= insurance --> facility (7 constraint(s)) =========
-- Requires: insurance schema, facility schema
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= insurance --> order (2 constraint(s)) =========
-- Requires: insurance schema, order schema
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);

-- ========= insurance --> patient (13 constraint(s)) =========
-- Requires: insurance schema, patient schema
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_dependent_mpi_record_id` FOREIGN KEY (`dependent_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);

-- ========= insurance --> provider (22 constraint(s)) =========
-- Requires: insurance schema, provider schema
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_location_id` FOREIGN KEY (`location_id`) REFERENCES `healthcare_ecm`.`provider`.`location`(`location_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_malpractice_coverage_id` FOREIGN KEY (`malpractice_coverage_id`) REFERENCES `healthcare_ecm`.`provider`.`malpractice_coverage`(`malpractice_coverage_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= insurance --> reference (21 constraint(s)) =========
-- Requires: insurance schema, reference schema
ALTER TABLE `healthcare_ecm`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= laboratory --> billing (2 constraint(s)) =========
-- Requires: laboratory schema, billing schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `healthcare_ecm`.`billing`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm`.`billing`.`charge`(`charge_id`);

-- ========= laboratory --> claim (5 constraint(s)) =========
-- Requires: laboratory schema, claim schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= laboratory --> clinical (6 constraint(s)) =========
-- Requires: laboratory schema, clinical schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= laboratory --> compliance (13 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= laboratory --> encounter (8 constraint(s)) =========
-- Requires: laboratory schema, encounter schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_triage_assessment_id` FOREIGN KEY (`triage_assessment_id`) REFERENCES `healthcare_ecm`.`encounter`.`triage_assessment`(`triage_assessment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= laboratory --> facility (12 constraint(s)) =========
-- Requires: laboratory schema, facility schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= laboratory --> insurance (9 constraint(s)) =========
-- Requires: laboratory schema, insurance schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= laboratory --> order (3 constraint(s)) =========
-- Requires: laboratory schema, order schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= laboratory --> patient (10 constraint(s)) =========
-- Requires: laboratory schema, patient schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= laboratory --> provider (13 constraint(s)) =========
-- Requires: laboratory schema, provider schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_tertiary_lab_cancelled_by_provider_clinician_id` FOREIGN KEY (`tertiary_lab_cancelled_by_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_tertiary_test_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_test_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= laboratory --> reference (22 constraint(s)) =========
-- Requires: laboratory schema, reference schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= laboratory --> scheduling (8 constraint(s)) =========
-- Requires: laboratory schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= laboratory --> supply (10 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `healthcare_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= order --> billing (1 constraint(s)) =========
-- Requires: order schema, billing schema
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= order --> clinical (2 constraint(s)) =========
-- Requires: order schema, clinical schema
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= order --> compliance (13 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);

-- ========= order --> encounter (5 constraint(s)) =========
-- Requires: order schema, encounter schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);

-- ========= order --> facility (14 constraint(s)) =========
-- Requires: order schema, facility schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= order --> insurance (15 constraint(s)) =========
-- Requires: order schema, insurance schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= order --> laboratory (5 constraint(s)) =========
-- Requires: order schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);

-- ========= order --> patient (8 constraint(s)) =========
-- Requires: order schema, patient schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= order --> pharmacy (5 constraint(s)) =========
-- Requires: order schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= order --> provider (19 constraint(s)) =========
-- Requires: order schema, provider schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_tertiary_clinical_authorizing_provider_clinician_id` FOREIGN KEY (`tertiary_clinical_authorizing_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_receiving_provider_clinician_id` FOREIGN KEY (`receiving_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `healthcare_ecm`.`provider`.`location`(`location_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_set_clinician_id` FOREIGN KEY (`set_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_fulfillment_ordering_provider_clinician_id` FOREIGN KEY (`fulfillment_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);

-- ========= order --> radiology (3 constraint(s)) =========
-- Requires: order schema, radiology schema
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_study_id` FOREIGN KEY (`study_id`) REFERENCES `healthcare_ecm`.`radiology`.`study`(`study_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm`.`radiology`.`protocol`(`protocol_id`);

-- ========= order --> reference (31 constraint(s)) =========
-- Requires: order schema, reference schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= order --> scheduling (3 constraint(s)) =========
-- Requires: order schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`order`.`set` ADD CONSTRAINT `fk_order_set_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);

-- ========= order --> supply (7 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= patient --> clinical (5 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_advance_directive_id` FOREIGN KEY (`advance_directive_id`) REFERENCES `healthcare_ecm`.`clinical`.`advance_directive`(`advance_directive_id`);

-- ========= patient --> compliance (2 constraint(s)) =========
-- Requires: patient schema, compliance schema
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= patient --> encounter (4 constraint(s)) =========
-- Requires: patient schema, encounter schema
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= patient --> facility (10 constraint(s)) =========
-- Requires: patient schema, facility schema
ALTER TABLE `healthcare_ecm`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= patient --> insurance (18 constraint(s)) =========
-- Requires: patient schema, insurance schema
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_capitation_contract_id` FOREIGN KEY (`capitation_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= patient --> order (1 constraint(s)) =========
-- Requires: patient schema, order schema
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= patient --> pharmacy (1 constraint(s)) =========
-- Requires: patient schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= patient --> provider (19 constraint(s)) =========
-- Requires: patient schema, provider schema
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_tertiary_registration_pcp_provider_clinician_id` FOREIGN KEY (`tertiary_registration_pcp_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= patient --> reference (4 constraint(s)) =========
-- Requires: patient schema, reference schema
ALTER TABLE `healthcare_ecm`.`patient`.`demographics` ADD CONSTRAINT `fk_patient_demographics_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);

-- ========= pharmacy --> claim (5 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);

-- ========= pharmacy --> clinical (4 constraint(s)) =========
-- Requires: pharmacy schema, clinical schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= pharmacy --> compliance (8 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= pharmacy --> encounter (7 constraint(s)) =========
-- Requires: pharmacy schema, encounter schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= pharmacy --> facility (8 constraint(s)) =========
-- Requires: pharmacy schema, facility schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);

-- ========= pharmacy --> insurance (5 constraint(s)) =========
-- Requires: pharmacy schema, insurance schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `healthcare_ecm`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= pharmacy --> laboratory (5 constraint(s)) =========
-- Requires: pharmacy schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_susceptibility_result_id` FOREIGN KEY (`susceptibility_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`susceptibility_result`(`susceptibility_result_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= pharmacy --> order (7 constraint(s)) =========
-- Requires: pharmacy schema, order schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= pharmacy --> patient (9 constraint(s)) =========
-- Requires: pharmacy schema, patient schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescription_patient_mpi_record_id` FOREIGN KEY (`prescription_patient_mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= pharmacy --> provider (7 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescription_prescriber_clinician_id` FOREIGN KEY (`prescription_prescriber_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= pharmacy --> radiology (4 constraint(s)) =========
-- Requires: pharmacy schema, radiology schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_contrast_admin_id` FOREIGN KEY (`contrast_admin_id`) REFERENCES `healthcare_ecm`.`radiology`.`contrast_admin`(`contrast_admin_id`);

-- ========= pharmacy --> reference (18 constraint(s)) =========
-- Requires: pharmacy schema, reference schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= pharmacy --> scheduling (4 constraint(s)) =========
-- Requires: pharmacy schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= pharmacy --> supply (7 constraint(s)) =========
-- Requires: pharmacy schema, supply schema
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= provider --> compliance (4 constraint(s)) =========
-- Requires: provider schema, compliance schema
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= provider --> facility (9 constraint(s)) =========
-- Requires: provider schema, facility schema
ALTER TABLE `healthcare_ecm`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`location` ADD CONSTRAINT `fk_provider_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);

-- ========= provider --> insurance (5 constraint(s)) =========
-- Requires: provider schema, insurance schema
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `healthcare_ecm`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= provider --> radiology (1 constraint(s)) =========
-- Requires: provider schema, radiology schema
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `healthcare_ecm`.`radiology`.`modality`(`modality_id`);

-- ========= provider --> reference (12 constraint(s)) =========
-- Requires: provider schema, reference schema
ALTER TABLE `healthcare_ecm`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`provider`.`location` ADD CONSTRAINT `fk_provider_location_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= provider --> supply (1 constraint(s)) =========
-- Requires: provider schema, supply schema
ALTER TABLE `healthcare_ecm`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= radiology --> claim (6 constraint(s)) =========
-- Requires: radiology schema, claim schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `healthcare_ecm`.`claim`.`line`(`line_id`);

-- ========= radiology --> clinical (5 constraint(s)) =========
-- Requires: radiology schema, clinical schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_allergy_id` FOREIGN KEY (`allergy_id`) REFERENCES `healthcare_ecm`.`clinical`.`allergy`(`allergy_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= radiology --> compliance (6 constraint(s)) =========
-- Requires: radiology schema, compliance schema
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= radiology --> encounter (8 constraint(s)) =========
-- Requires: radiology schema, encounter schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_triage_assessment_id` FOREIGN KEY (`triage_assessment_id`) REFERENCES `healthcare_ecm`.`encounter`.`triage_assessment`(`triage_assessment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= radiology --> facility (16 constraint(s)) =========
-- Requires: radiology schema, facility schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);

-- ========= radiology --> insurance (7 constraint(s)) =========
-- Requires: radiology schema, insurance schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);

-- ========= radiology --> laboratory (1 constraint(s)) =========
-- Requires: radiology schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_result`(`test_result_id`);

-- ========= radiology --> order (6 constraint(s)) =========
-- Requires: radiology schema, order schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= radiology --> patient (6 constraint(s)) =========
-- Requires: radiology schema, patient schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);

-- ========= radiology --> pharmacy (6 constraint(s)) =========
-- Requires: radiology schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= radiology --> provider (13 constraint(s)) =========
-- Requires: radiology schema, provider schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_report_clinician_id` FOREIGN KEY (`report_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_report_reading_radiologist_clinician_id` FOREIGN KEY (`report_reading_radiologist_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_tertiary_critical_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_critical_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= radiology --> reference (16 constraint(s)) =========
-- Requires: radiology schema, reference schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= radiology --> scheduling (3 constraint(s)) =========
-- Requires: radiology schema, scheduling schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);

-- ========= radiology --> supply (7 constraint(s)) =========
-- Requires: radiology schema, supply schema
ALTER TABLE `healthcare_ecm`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`study` ADD CONSTRAINT `fk_radiology_study_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `healthcare_ecm`.`supply`.`udi_record`(`udi_record_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `healthcare_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `healthcare_ecm`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_inventory_transaction_id` FOREIGN KEY (`inventory_transaction_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_transaction`(`inventory_transaction_id`);

-- ========= scheduling --> billing (3 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_coverage_id` FOREIGN KEY (`coverage_id`) REFERENCES `healthcare_ecm`.`billing`.`coverage`(`coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= scheduling --> claim (5 constraint(s)) =========
-- Requires: scheduling schema, claim schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= scheduling --> clinical (7 constraint(s)) =========
-- Requires: scheduling schema, clinical schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm`.`clinical`.`problem`(`problem_id`);

-- ========= scheduling --> compliance (8 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_exclusion_screening_id` FOREIGN KEY (`exclusion_screening_id`) REFERENCES `healthcare_ecm`.`compliance`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);

-- ========= scheduling --> encounter (7 constraint(s)) =========
-- Requires: scheduling schema, encounter schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `healthcare_ecm`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);

-- ========= scheduling --> facility (27 constraint(s)) =========
-- Requires: scheduling schema, facility schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);

-- ========= scheduling --> insurance (19 constraint(s)) =========
-- Requires: scheduling schema, insurance schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `healthcare_ecm`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `healthcare_ecm`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= scheduling --> laboratory (1 constraint(s)) =========
-- Requires: scheduling schema, laboratory schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= scheduling --> order (5 constraint(s)) =========
-- Requires: scheduling schema, order schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm`.`order`.`referral_order`(`referral_order_id`);

-- ========= scheduling --> patient (9 constraint(s)) =========
-- Requires: scheduling schema, patient schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_eligibility_check_id` FOREIGN KEY (`eligibility_check_id`) REFERENCES `healthcare_ecm`.`patient`.`eligibility_check`(`eligibility_check_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= scheduling --> provider (26 constraint(s)) =========
-- Requires: scheduling schema, provider schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `healthcare_ecm`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_malpractice_coverage_id` FOREIGN KEY (`malpractice_coverage_id`) REFERENCES `healthcare_ecm`.`provider`.`malpractice_coverage`(`malpractice_coverage_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `healthcare_ecm`.`provider`.`credential`(`credential_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);

-- ========= scheduling --> radiology (2 constraint(s)) =========
-- Requires: scheduling schema, radiology schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= scheduling --> reference (12 constraint(s)) =========
-- Requires: scheduling schema, reference schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm`.`reference`.`icd_code`(`icd_code_id`);

-- ========= scheduling --> supply (4 constraint(s)) =========
-- Requires: scheduling schema, supply schema
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm`.`supply`.`vendor_contract`(`vendor_contract_id`);

-- ========= supply --> clinical (1 constraint(s)) =========
-- Requires: supply schema, clinical schema
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= supply --> compliance (7 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= supply --> encounter (5 constraint(s)) =========
-- Requires: supply schema, encounter schema
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm`.`encounter`.`visit_procedure`(`visit_procedure_id`);

-- ========= supply --> facility (22 constraint(s)) =========
-- Requires: supply schema, facility schema
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_service_id` FOREIGN KEY (`service_id`) REFERENCES `healthcare_ecm`.`facility`.`service`(`service_id`);

-- ========= supply --> insurance (4 constraint(s)) =========
-- Requires: supply schema, insurance schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `healthcare_ecm`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm`.`insurance`.`payer`(`payer_id`);

-- ========= supply --> order (5 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= supply --> patient (3 constraint(s)) =========
-- Requires: supply schema, patient schema
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm`.`patient`.`insurance_coverage`(`insurance_coverage_id`);

-- ========= supply --> pharmacy (6 constraint(s)) =========
-- Requires: supply schema, pharmacy schema
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_inventory_id` FOREIGN KEY (`inventory_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`inventory`(`inventory_id`);

-- ========= supply --> provider (5 constraint(s)) =========
-- Requires: supply schema, provider schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm`.`provider`.`org_provider`(`org_provider_id`);

-- ========= supply --> reference (13 constraint(s)) =========
-- Requires: supply schema, reference schema
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm`.`reference`.`ndc_drug`(`ndc_drug_id`);

