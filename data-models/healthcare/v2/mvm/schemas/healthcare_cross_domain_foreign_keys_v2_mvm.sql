-- Cross-Domain Foreign Keys for Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:13
-- Total cross-domain FK constraints: 771
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: billing, claim, clinical, consent, encounter, insurance, laboratory, order, patient, pharmacy, provider, reference, scheduling

-- ========= billing --> claim (5 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_remittance_line_id` FOREIGN KEY (`remittance_line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance_line`(`remittance_line_id`);

-- ========= billing --> clinical (4 constraint(s)) =========
-- Requires: billing schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);

-- ========= billing --> consent (5 constraint(s)) =========
-- Requires: billing schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);

-- ========= billing --> encounter (9 constraint(s)) =========
-- Requires: billing schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= billing --> insurance (12 constraint(s)) =========
-- Requires: billing schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= billing --> order (4 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `vibe_healthcare_v1`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= billing --> patient (15 constraint(s)) =========
-- Requires: billing schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= billing --> pharmacy (4 constraint(s)) =========
-- Requires: billing schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= billing --> provider (10 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= billing --> reference (19 constraint(s)) =========
-- Requires: billing schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= claim --> billing (5 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);

-- ========= claim --> clinical (7 constraint(s)) =========
-- Requires: claim schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);

-- ========= claim --> consent (5 constraint(s)) =========
-- Requires: claim schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_hipaa_authorization_id` FOREIGN KEY (`hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_hipaa_authorization_id` FOREIGN KEY (`hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);

-- ========= claim --> encounter (9 constraint(s)) =========
-- Requires: claim schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_visit_insurance_id` FOREIGN KEY (`visit_insurance_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_insurance`(`visit_insurance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= claim --> insurance (28 constraint(s)) =========
-- Requires: claim schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_dependent_id` FOREIGN KEY (`dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_dependent_id` FOREIGN KEY (`dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= claim --> order (2 constraint(s)) =========
-- Requires: claim schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `vibe_healthcare_v1`.`order`.`fulfillment`(`fulfillment_id`);

-- ========= claim --> patient (11 constraint(s)) =========
-- Requires: claim schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_eligibility_mpi_record_id` FOREIGN KEY (`eligibility_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= claim --> provider (9 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= claim --> reference (16 constraint(s)) =========
-- Requires: claim schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= clinical --> consent (2 constraint(s)) =========
-- Requires: clinical schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);

-- ========= clinical --> encounter (12 constraint(s)) =========
-- Requires: clinical schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= clinical --> insurance (6 constraint(s)) =========
-- Requires: clinical schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= clinical --> laboratory (2 constraint(s)) =========
-- Requires: clinical schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);

-- ========= clinical --> order (6 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= clinical --> patient (12 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= clinical --> pharmacy (7 constraint(s)) =========
-- Requires: clinical schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= clinical --> provider (24 constraint(s)) =========
-- Requires: clinical schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_tertiary_procedure_anesthesia_provider_clinician_id` FOREIGN KEY (`tertiary_procedure_anesthesia_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_tertiary_problem_last_updated_by_provider_clinician_id` FOREIGN KEY (`tertiary_problem_last_updated_by_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_tertiary_care_member_provider_clinician_id` FOREIGN KEY (`tertiary_care_member_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= clinical --> reference (25 constraint(s)) =========
-- Requires: clinical schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= clinical --> scheduling (1 constraint(s)) =========
-- Requires: clinical schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);

-- ========= consent --> claim (1 constraint(s)) =========
-- Requires: consent schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= consent --> encounter (7 constraint(s)) =========
-- Requires: consent schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_adt_event_id` FOREIGN KEY (`adt_event_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`adt_event`(`adt_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= consent --> patient (10 constraint(s)) =========
-- Requires: consent schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`portal_account`(`portal_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_registration_event_id` FOREIGN KEY (`registration_event_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`registration_event`(`registration_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= consent --> provider (10 constraint(s)) =========
-- Requires: consent schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_tertiary_treatment_performing_provider_clinician_id` FOREIGN KEY (`tertiary_treatment_performing_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= consent --> reference (6 constraint(s)) =========
-- Requires: consent schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= encounter --> clinical (3 constraint(s)) =========
-- Requires: encounter schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= encounter --> insurance (14 constraint(s)) =========
-- Requires: encounter schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= encounter --> order (1 constraint(s)) =========
-- Requires: encounter schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);

-- ========= encounter --> patient (14 constraint(s)) =========
-- Requires: encounter schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= encounter --> provider (23 constraint(s)) =========
-- Requires: encounter schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_tertiary_visit_supervising_provider_clinician_id` FOREIGN KEY (`tertiary_visit_supervising_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_tertiary_discharge_follow_up_provider_clinician_id` FOREIGN KEY (`tertiary_discharge_follow_up_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= encounter --> reference (20 constraint(s)) =========
-- Requires: encounter schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= encounter --> scheduling (3 constraint(s)) =========
-- Requires: encounter schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_waitlist_entry_id` FOREIGN KEY (`waitlist_entry_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`waitlist_entry`(`waitlist_entry_id`);

-- ========= insurance --> consent (4 constraint(s)) =========
-- Requires: insurance schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_npp_acknowledgment_id` FOREIGN KEY (`npp_acknowledgment_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`npp_acknowledgment`(`npp_acknowledgment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);

-- ========= insurance --> patient (4 constraint(s)) =========
-- Requires: insurance schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_dependent_mpi_record_id` FOREIGN KEY (`dependent_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= insurance --> provider (16 constraint(s)) =========
-- Requires: insurance schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);

-- ========= insurance --> reference (18 constraint(s)) =========
-- Requires: insurance schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);

-- ========= laboratory --> billing (1 constraint(s)) =========
-- Requires: laboratory schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= laboratory --> clinical (1 constraint(s)) =========
-- Requires: laboratory schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);

-- ========= laboratory --> consent (2 constraint(s)) =========
-- Requires: laboratory schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);

-- ========= laboratory --> encounter (8 constraint(s)) =========
-- Requires: laboratory schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= laboratory --> insurance (4 constraint(s)) =========
-- Requires: laboratory schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= laboratory --> order (1 constraint(s)) =========
-- Requires: laboratory schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);

-- ========= laboratory --> patient (9 constraint(s)) =========
-- Requires: laboratory schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= laboratory --> provider (12 constraint(s)) =========
-- Requires: laboratory schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_tertiary_lab_cancelled_by_provider_clinician_id` FOREIGN KEY (`tertiary_lab_cancelled_by_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_tertiary_test_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_test_ordering_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= laboratory --> reference (18 constraint(s)) =========
-- Requires: laboratory schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= laboratory --> scheduling (3 constraint(s)) =========
-- Requires: laboratory schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= order --> claim (1 constraint(s)) =========
-- Requires: order schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= order --> consent (5 constraint(s)) =========
-- Requires: order schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);

-- ========= order --> encounter (6 constraint(s)) =========
-- Requires: order schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_discharge_summary_id` FOREIGN KEY (`discharge_summary_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`discharge_summary`(`discharge_summary_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= order --> insurance (19 constraint(s)) =========
-- Requires: order schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_fee_schedule_line_id` FOREIGN KEY (`fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= order --> laboratory (2 constraint(s)) =========
-- Requires: order schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);

-- ========= order --> patient (6 constraint(s)) =========
-- Requires: order schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= order --> provider (18 constraint(s)) =========
-- Requires: order schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_tertiary_clinical_authorizing_provider_clinician_id` FOREIGN KEY (`tertiary_clinical_authorizing_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_receiving_provider_clinician_id` FOREIGN KEY (`receiving_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_reconciliation_performed_by_clinician_id` FOREIGN KEY (`reconciliation_performed_by_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= order --> reference (28 constraint(s)) =========
-- Requires: order schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= order --> scheduling (4 constraint(s)) =========
-- Requires: order schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);

-- ========= patient --> clinical (1 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);

-- ========= patient --> consent (2 constraint(s)) =========
-- Requires: patient schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_consent_domain_record_id` FOREIGN KEY (`consent_domain_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);

-- ========= patient --> encounter (3 constraint(s)) =========
-- Requires: patient schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= patient --> insurance (12 constraint(s)) =========
-- Requires: patient schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= patient --> provider (10 constraint(s)) =========
-- Requires: patient schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_tertiary_registration_pcp_provider_clinician_id` FOREIGN KEY (`tertiary_registration_pcp_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`portal_account` ADD CONSTRAINT `fk_patient_portal_account_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= patient --> reference (2 constraint(s)) =========
-- Requires: patient schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`demographics` ADD CONSTRAINT `fk_patient_demographics_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);

-- ========= pharmacy --> claim (1 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= pharmacy --> clinical (2 constraint(s)) =========
-- Requires: pharmacy schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);

-- ========= pharmacy --> consent (6 constraint(s)) =========
-- Requires: pharmacy schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_disclosure_log_id` FOREIGN KEY (`disclosure_log_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`disclosure_log`(`disclosure_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_disclosure_log_id` FOREIGN KEY (`disclosure_log_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`disclosure_log`(`disclosure_log_id`);

-- ========= pharmacy --> encounter (6 constraint(s)) =========
-- Requires: pharmacy schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= pharmacy --> insurance (10 constraint(s)) =========
-- Requires: pharmacy schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= pharmacy --> laboratory (7 constraint(s)) =========
-- Requires: pharmacy schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_pathology_report_id` FOREIGN KEY (`pathology_report_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`pathology_report`(`pathology_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= pharmacy --> order (6 constraint(s)) =========
-- Requires: pharmacy schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `vibe_healthcare_v1`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= pharmacy --> patient (9 constraint(s)) =========
-- Requires: pharmacy schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_eligibility_check_id` FOREIGN KEY (`eligibility_check_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`eligibility_check`(`eligibility_check_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_primary_prescription_mpi_record_id` FOREIGN KEY (`primary_prescription_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= pharmacy --> provider (15 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_dea_registration_id` FOREIGN KEY (`dea_registration_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`dea_registration`(`dea_registration_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_primary_prescription_clinician_id` FOREIGN KEY (`primary_prescription_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_dea_registration_id` FOREIGN KEY (`dea_registration_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`dea_registration`(`dea_registration_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_dea_registration_id` FOREIGN KEY (`dea_registration_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`dea_registration`(`dea_registration_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= pharmacy --> reference (16 constraint(s)) =========
-- Requires: pharmacy schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= pharmacy --> scheduling (1 constraint(s)) =========
-- Requires: pharmacy schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= provider --> insurance (3 constraint(s)) =========
-- Requires: provider schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= provider --> reference (8 constraint(s)) =========
-- Requires: provider schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= scheduling --> billing (1 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= scheduling --> claim (3 constraint(s)) =========
-- Requires: scheduling schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`eligibility`(`eligibility_id`);

-- ========= scheduling --> clinical (6 constraint(s)) =========
-- Requires: scheduling schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);

-- ========= scheduling --> consent (4 constraint(s)) =========
-- Requires: scheduling schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= scheduling --> encounter (6 constraint(s)) =========
-- Requires: scheduling schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= scheduling --> insurance (8 constraint(s)) =========
-- Requires: scheduling schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= scheduling --> laboratory (1 constraint(s)) =========
-- Requires: scheduling schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= scheduling --> order (5 constraint(s)) =========
-- Requires: scheduling schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);

-- ========= scheduling --> patient (6 constraint(s)) =========
-- Requires: scheduling schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= scheduling --> provider (21 constraint(s)) =========
-- Requires: scheduling schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credential`(`credential_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= scheduling --> reference (12 constraint(s)) =========
-- Requires: scheduling schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);

