-- Cross-Domain Foreign Keys for Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-23 01:34:45
-- Total cross-domain FK constraints: 324
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: appeal, billing, care, claim, contract, enrollment, member, pharmacy, plan, provider, risk, utilization

-- ========= appeal --> billing (3 constraint(s)) =========
-- Requires: appeal schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`premium_payment`(`premium_payment_id`);

-- ========= appeal --> care (2 constraint(s)) =========
-- Requires: appeal schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);

-- ========= appeal --> claim (13 constraint(s)) =========
-- Requires: appeal schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`denial`(`denial_id`);

-- ========= appeal --> contract (5 constraint(s)) =========
-- Requires: appeal schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_term_id` FOREIGN KEY (`term_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`term`(`term_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= appeal --> enrollment (5 constraint(s)) =========
-- Requires: appeal schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);

-- ========= appeal --> member (9 constraint(s)) =========
-- Requires: appeal schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`document` ADD CONSTRAINT `fk_appeal_document_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= appeal --> pharmacy (2 constraint(s)) =========
-- Requires: appeal schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= appeal --> plan (10 constraint(s)) =========
-- Requires: appeal schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);

-- ========= appeal --> provider (10 constraint(s)) =========
-- Requires: appeal schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= appeal --> risk (1 constraint(s)) =========
-- Requires: appeal schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);

-- ========= appeal --> utilization (9 constraint(s)) =========
-- Requires: appeal schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);

-- ========= billing --> appeal (1 constraint(s)) =========
-- Requires: billing schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_outcome_id` FOREIGN KEY (`outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);

-- ========= billing --> care (1 constraint(s)) =========
-- Requires: billing schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= billing --> contract (2 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);

-- ========= billing --> enrollment (3 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);

-- ========= billing --> member (13 constraint(s)) =========
-- Requires: billing schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= billing --> plan (4 constraint(s)) =========
-- Requires: billing schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= billing --> risk (2 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_radv_audit_id` FOREIGN KEY (`radv_audit_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`radv_audit`(`radv_audit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`billing`.`cms_remittance` ADD CONSTRAINT `fk_billing_cms_remittance_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);

-- ========= care --> claim (4 constraint(s)) =========
-- Requires: care schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`line`(`line_id`);

-- ========= care --> contract (4 constraint(s)) =========
-- Requires: care schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`program` ADD CONSTRAINT `fk_care_program_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);

-- ========= care --> enrollment (1 constraint(s)) =========
-- Requires: care schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);

-- ========= care --> member (6 constraint(s)) =========
-- Requires: care schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= care --> plan (2 constraint(s)) =========
-- Requires: care schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= care --> provider (7 constraint(s)) =========
-- Requires: care schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= care --> risk (4 constraint(s)) =========
-- Requires: care schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= claim --> appeal (2 constraint(s)) =========
-- Requires: claim schema, appeal schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`case`(`case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_outcome_id` FOREIGN KEY (`outcome_id`) REFERENCES `vibe_health_insurance_v1`.`appeal`.`outcome`(`outcome_id`);

-- ========= claim --> billing (2 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= claim --> care (1 constraint(s)) =========
-- Requires: claim schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_enrollment`(`care_enrollment_id`);

-- ========= claim --> contract (8 constraint(s)) =========
-- Requires: claim schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_contract_network_participation_id` FOREIGN KEY (`contract_network_participation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_network_participation`(`contract_network_participation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_fee_schedule_rate_id` FOREIGN KEY (`fee_schedule_rate_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`(`fee_schedule_rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_fee_schedule_rate_id` FOREIGN KEY (`fee_schedule_rate_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`(`fee_schedule_rate_id`);

-- ========= claim --> enrollment (3 constraint(s)) =========
-- Requires: claim schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_medicaid_eligibility_id` FOREIGN KEY (`medicaid_eligibility_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`(`medicaid_eligibility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_medicare_entitlement_id` FOREIGN KEY (`medicare_entitlement_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement`(`medicare_entitlement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);

-- ========= claim --> member (12 constraint(s)) =========
-- Requires: claim schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_cob_record_id` FOREIGN KEY (`cob_record_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`cob_record`(`cob_record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= claim --> pharmacy (3 constraint(s)) =========
-- Requires: claim schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= claim --> plan (10 constraint(s)) =========
-- Requires: claim schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_sbc_document_id` FOREIGN KEY (`sbc_document_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`sbc_document`(`sbc_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= claim --> provider (19 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_procedure_surgeon_provider_provider_provider_practice_location_id` FOREIGN KEY (`procedure_surgeon_provider_provider_provider_practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_participation_status_id` FOREIGN KEY (`participation_status_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`participation_status`(`participation_status_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_network_participation_id` FOREIGN KEY (`provider_network_participation_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider_network_participation`(`provider_network_participation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);

-- ========= claim --> risk (3 constraint(s)) =========
-- Requires: claim schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_radv_audit_id` FOREIGN KEY (`radv_audit_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`radv_audit`(`radv_audit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_radv_audit_id` FOREIGN KEY (`radv_audit_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`radv_audit`(`radv_audit_id`);

-- ========= claim --> utilization (14 constraint(s)) =========
-- Requires: claim schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_episode_of_care_id` FOREIGN KEY (`episode_of_care_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`episode_of_care`(`episode_of_care_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`claim`.`drg` ADD CONSTRAINT `fk_claim_drg_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);

-- ========= contract --> enrollment (1 constraint(s)) =========
-- Requires: contract schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);

-- ========= contract --> plan (3 constraint(s)) =========
-- Requires: contract schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);

-- ========= contract --> risk (3 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_radv_audit_id` FOREIGN KEY (`radv_audit_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`radv_audit`(`radv_audit_id`);

-- ========= enrollment --> care (3 constraint(s)) =========
-- Requires: enrollment schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ADD CONSTRAINT `fk_enrollment_eligibility_span_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= enrollment --> contract (4 constraint(s)) =========
-- Requires: enrollment schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`edi_transaction` ADD CONSTRAINT `fk_enrollment_edi_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_contract_network_participation_id` FOREIGN KEY (`contract_network_participation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_network_participation`(`contract_network_participation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);

-- ========= enrollment --> member (2 constraint(s)) =========
-- Requires: enrollment schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);

-- ========= enrollment --> plan (7 constraint(s)) =========
-- Requires: enrollment schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ADD CONSTRAINT `fk_enrollment_eligibility_span_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`rate`(`rate_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`offering`(`offering_id`);

-- ========= enrollment --> provider (1 constraint(s)) =========
-- Requires: enrollment schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);

-- ========= enrollment --> risk (1 constraint(s)) =========
-- Requires: enrollment schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`enrollment`.`eligibility_span` ADD CONSTRAINT `fk_enrollment_eligibility_span_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);

-- ========= member --> billing (1 constraint(s)) =========
-- Requires: member schema, billing schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_health_insurance_v1`.`billing`.`account`(`account_id`);

-- ========= member --> care (1 constraint(s)) =========
-- Requires: member schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);

-- ========= member --> contract (4 constraint(s)) =========
-- Requires: member schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span2` ADD CONSTRAINT `fk_member_eligibility_span2_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);

-- ========= member --> enrollment (6 constraint(s)) =========
-- Requires: member schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`enrollment2` ADD CONSTRAINT `fk_member_enrollment2_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`enrollment2` ADD CONSTRAINT `fk_member_enrollment2_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`enrollment2` ADD CONSTRAINT `fk_member_enrollment2_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`transaction`(`transaction_id`);

-- ========= member --> pharmacy (1 constraint(s)) =========
-- Requires: member schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span2` ADD CONSTRAINT `fk_member_eligibility_span2_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= member --> plan (5 constraint(s)) =========
-- Requires: member schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span2` ADD CONSTRAINT `fk_member_eligibility_span2_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`enrollment2` ADD CONSTRAINT `fk_member_enrollment2_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`enrollment2` ADD CONSTRAINT `fk_member_enrollment2_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`offering`(`offering_id`);

-- ========= member --> provider (2 constraint(s)) =========
-- Requires: member schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= pharmacy --> claim (1 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_health_insurance_v1`.`claim`.`header`(`header_id`);

-- ========= pharmacy --> contract (2 constraint(s)) =========
-- Requires: pharmacy schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);

-- ========= pharmacy --> enrollment (3 constraint(s)) =========
-- Requires: pharmacy schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_medicare_entitlement_id` FOREIGN KEY (`medicare_entitlement_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement`(`medicare_entitlement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= pharmacy --> member (5 constraint(s)) =========
-- Requires: pharmacy schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= pharmacy --> plan (8 constraint(s)) =========
-- Requires: pharmacy schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= pharmacy --> provider (2 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= pharmacy --> risk (3 constraint(s)) =========
-- Requires: pharmacy schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= pharmacy --> utilization (3 constraint(s)) =========
-- Requires: pharmacy schema, utilization schema
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `vibe_health_insurance_v1`.`utilization`.`pa_request`(`pa_request_id`);

-- ========= plan --> contract (2 constraint(s)) =========
-- Requires: plan schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ADD CONSTRAINT `fk_plan_provider_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);

-- ========= plan --> pharmacy (4 constraint(s)) =========
-- Requires: plan schema, pharmacy schema
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= provider --> contract (7 constraint(s)) =========
-- Requires: provider schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ADD CONSTRAINT `fk_provider_facility_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ADD CONSTRAINT `fk_provider_provider_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`party`(`party_id`);

-- ========= provider --> plan (5 constraint(s)) =========
-- Requires: provider schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);

-- ========= risk --> member (3 constraint(s)) =========
-- Requires: risk schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= risk --> provider (1 constraint(s)) =========
-- Requires: risk schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= utilization --> care (5 constraint(s)) =========
-- Requires: utilization schema, care schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_health_insurance_v1`.`care`.`program`(`program_id`);

-- ========= utilization --> contract (2 constraint(s)) =========
-- Requires: utilization schema, contract schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_contract_network_participation_id` FOREIGN KEY (`contract_network_participation_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`contract_network_participation`(`contract_network_participation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `vibe_health_insurance_v1`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= utilization --> enrollment (1 constraint(s)) =========
-- Requires: utilization schema, enrollment schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `vibe_health_insurance_v1`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= utilization --> member (9 constraint(s)) =========
-- Requires: utilization schema, member schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);

-- ========= utilization --> plan (7 constraint(s)) =========
-- Requires: utilization schema, plan schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);

-- ========= utilization --> provider (4 constraint(s)) =========
-- Requires: utilization schema, provider schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= utilization --> risk (2 constraint(s)) =========
-- Requires: utilization schema, risk schema
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`utilization`.`episode_of_care` ADD CONSTRAINT `fk_utilization_episode_of_care_radv_audit_id` FOREIGN KEY (`radv_audit_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`radv_audit`(`radv_audit_id`);

