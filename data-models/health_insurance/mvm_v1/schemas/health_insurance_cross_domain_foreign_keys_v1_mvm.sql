-- Cross-Domain Foreign Keys for Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:47
-- Total cross-domain FK constraints: 1003
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: appeal, billing, care, claim, compliance, contract, employer, enrollment, member, network, pharmacy, plan, provider, risk, utilization

-- ========= appeal --> billing (5 constraint(s)) =========
-- Requires: appeal schema, billing schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `health_insurance_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_payment`(`premium_payment_id`);

-- ========= appeal --> care (15 constraint(s)) =========
-- Requires: appeal schema, care schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `health_insurance_ecm`.`care`.`gap`(`gap_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_hra_id` FOREIGN KEY (`hra_id`) REFERENCES `health_insurance_ecm`.`care`.`hra`(`hra_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `health_insurance_ecm`.`care`.`condition_registry`(`condition_registry_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `health_insurance_ecm`.`care`.`gap`(`gap_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `health_insurance_ecm`.`care`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `health_insurance_ecm`.`care`.`gap`(`gap_id`);

-- ========= appeal --> claim (6 constraint(s)) =========
-- Requires: appeal schema, claim schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);

-- ========= appeal --> compliance (9 constraint(s)) =========
-- Requires: appeal schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`communication` ADD CONSTRAINT `fk_appeal_communication_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= appeal --> contract (8 constraint(s)) =========
-- Requires: appeal schema, contract schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `health_insurance_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_term_id` FOREIGN KEY (`term_id`) REFERENCES `health_insurance_ecm`.`contract`.`term`(`term_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `health_insurance_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= appeal --> employer (8 constraint(s)) =========
-- Requires: appeal schema, employer schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`communication` ADD CONSTRAINT `fk_appeal_communication_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= appeal --> enrollment (10 constraint(s)) =========
-- Requires: appeal schema, enrollment schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_event_id` FOREIGN KEY (`event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`event`(`event_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_cobra_election_id` FOREIGN KEY (`cobra_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`cobra_election`(`cobra_election_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_medicaid_eligibility_id` FOREIGN KEY (`medicaid_eligibility_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`medicaid_eligibility`(`medicaid_eligibility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_medicare_entitlement_id` FOREIGN KEY (`medicare_entitlement_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`medicare_entitlement`(`medicare_entitlement_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_cobra_election_id` FOREIGN KEY (`cobra_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`cobra_election`(`cobra_election_id`);

-- ========= appeal --> member (20 constraint(s)) =========
-- Requires: appeal schema, member schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`document` ADD CONSTRAINT `fk_appeal_document_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`communication` ADD CONSTRAINT `fk_appeal_communication_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_cob_record_id` FOREIGN KEY (`cob_record_id`) REFERENCES `health_insurance_ecm`.`member`.`cob_record`(`cob_record_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);

-- ========= appeal --> network (7 constraint(s)) =========
-- Requires: appeal schema, network schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_adequacy_gap_id` FOREIGN KEY (`adequacy_gap_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_gap`(`adequacy_gap_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= appeal --> pharmacy (6 constraint(s)) =========
-- Requires: appeal schema, pharmacy schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_formulary_drug_tier_id` FOREIGN KEY (`formulary_drug_tier_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary_drug_tier`(`formulary_drug_tier_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= appeal --> plan (14 constraint(s)) =========
-- Requires: appeal schema, plan schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `health_insurance_ecm`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `health_insurance_ecm`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);

-- ========= appeal --> provider (15 constraint(s)) =========
-- Requires: appeal schema, provider schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`document` ADD CONSTRAINT `fk_appeal_document_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= appeal --> risk (5 constraint(s)) =========
-- Requires: appeal schema, risk schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `health_insurance_ecm`.`risk`.`raps_submission`(`raps_submission_id`);

-- ========= appeal --> utilization (13 constraint(s)) =========
-- Requires: appeal schema, utilization schema
ALTER TABLE `health_insurance_ecm`.`appeal`.`grievance` ADD CONSTRAINT `fk_appeal_grievance_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`case` ADD CONSTRAINT `fk_appeal_case_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`adverse_determination` ADD CONSTRAINT `fk_appeal_adverse_determination_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`review` ADD CONSTRAINT `fk_appeal_review_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`external_review` ADD CONSTRAINT `fk_appeal_external_review_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`timeline` ADD CONSTRAINT `fk_appeal_timeline_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`coverage_dispute` ADD CONSTRAINT `fk_appeal_coverage_dispute_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`expedited_review` ADD CONSTRAINT `fk_appeal_expedited_review_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`appeal`.`outcome` ADD CONSTRAINT `fk_appeal_outcome_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);

-- ========= billing --> appeal (2 constraint(s)) =========
-- Requires: billing schema, appeal schema
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `health_insurance_ecm`.`appeal`.`case`(`case_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_case_id` FOREIGN KEY (`case_id`) REFERENCES `health_insurance_ecm`.`appeal`.`case`(`case_id`);

-- ========= billing --> care (2 constraint(s)) =========
-- Requires: billing schema, care schema
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `health_insurance_ecm`.`care`.`condition_registry`(`condition_registry_id`);

-- ========= billing --> compliance (5 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= billing --> contract (1 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);

-- ========= billing --> employer (12 constraint(s)) =========
-- Requires: billing schema, employer schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `health_insurance_ecm`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_tpa_arrangement_id` FOREIGN KEY (`tpa_arrangement_id`) REFERENCES `health_insurance_ecm`.`employer`.`tpa_arrangement`(`tpa_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_tpa_arrangement_id` FOREIGN KEY (`tpa_arrangement_id`) REFERENCES `health_insurance_ecm`.`employer`.`tpa_arrangement`(`tpa_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);

-- ========= billing --> enrollment (11 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_cobra_election_id` FOREIGN KEY (`cobra_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`cobra_election`(`cobra_election_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_exchange_enrollment_id` FOREIGN KEY (`exchange_enrollment_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`exchange_enrollment`(`exchange_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);

-- ========= billing --> member (12 constraint(s)) =========
-- Requires: billing schema, member schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);

-- ========= billing --> network (10 constraint(s)) =========
-- Requires: billing schema, network schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= billing --> plan (7 constraint(s)) =========
-- Requires: billing schema, plan schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `health_insurance_ecm`.`plan`.`rate`(`rate_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `health_insurance_ecm`.`plan`.`rate`(`rate_id`);

-- ========= billing --> provider (3 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= billing --> risk (4 constraint(s)) =========
-- Requires: billing schema, risk schema
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);

-- ========= billing --> utilization (4 constraint(s)) =========
-- Requires: billing schema, utilization schema
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `health_insurance_ecm`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_retrospective_review_id` FOREIGN KEY (`retrospective_review_id`) REFERENCES `health_insurance_ecm`.`utilization`.`retrospective_review`(`retrospective_review_id`);

-- ========= care --> billing (4 constraint(s)) =========
-- Requires: care schema, billing schema
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `health_insurance_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `health_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);

-- ========= care --> claim (3 constraint(s)) =========
-- Requires: care schema, claim schema
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `health_insurance_ecm`.`claim`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `health_insurance_ecm`.`claim`.`procedure`(`procedure_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_line_id` FOREIGN KEY (`line_id`) REFERENCES `health_insurance_ecm`.`claim`.`line`(`line_id`);

-- ========= care --> compliance (12 constraint(s)) =========
-- Requires: care schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `health_insurance_ecm`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_hipaa_privacy_request_id` FOREIGN KEY (`hipaa_privacy_request_id`) REFERENCES `health_insurance_ecm`.`compliance`.`hipaa_privacy_request`(`hipaa_privacy_request_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `health_insurance_ecm`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_measure` ADD CONSTRAINT `fk_care_hedis_measure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `health_insurance_ecm`.`compliance`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= care --> contract (17 constraint(s)) =========
-- Requires: care schema, contract schema
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_incentive_arrangement_id` FOREIGN KEY (`incentive_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`incentive_arrangement`(`incentive_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_incentive_arrangement_id` FOREIGN KEY (`incentive_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`incentive_arrangement`(`incentive_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator` ADD CONSTRAINT `fk_care_coordinator_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_incentive_arrangement_id` FOREIGN KEY (`incentive_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`incentive_arrangement`(`incentive_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_vbc_performance_period_id` FOREIGN KEY (`vbc_performance_period_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_performance_period`(`vbc_performance_period_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);

-- ========= care --> employer (3 constraint(s)) =========
-- Requires: care schema, employer schema
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= care --> member (17 constraint(s)) =========
-- Requires: care schema, member schema
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `health_insurance_ecm`.`member`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `health_insurance_ecm`.`member`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);

-- ========= care --> network (9 constraint(s)) =========
-- Requires: care schema, network schema
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_vbc_program_id` FOREIGN KEY (`vbc_program_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_program`(`vbc_program_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);

-- ========= care --> pharmacy (3 constraint(s)) =========
-- Requires: care schema, pharmacy schema
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_outreach` ADD CONSTRAINT `fk_care_member_outreach_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);

-- ========= care --> plan (13 constraint(s)) =========
-- Requires: care schema, plan schema
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`cahps_survey` ADD CONSTRAINT `fk_care_cahps_survey_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);

-- ========= care --> provider (19 constraint(s)) =========
-- Requires: care schema, provider schema
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`program` ADD CONSTRAINT `fk_care_program_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hedis_result` ADD CONSTRAINT `fk_care_hedis_result_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`team` ADD CONSTRAINT `fk_care_team_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);

-- ========= care --> risk (8 constraint(s)) =========
-- Requires: care schema, risk schema
ALTER TABLE `health_insurance_ecm`.`care`.`care_enrollment` ADD CONSTRAINT `fk_care_care_enrollment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`care_plan` ADD CONSTRAINT `fk_care_care_plan_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `health_insurance_ecm`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `health_insurance_ecm`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`member_risk_tier` ADD CONSTRAINT `fk_care_member_risk_tier_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= care --> utilization (5 constraint(s)) =========
-- Requires: care schema, utilization schema
ALTER TABLE `health_insurance_ecm`.`care`.`gap` ADD CONSTRAINT `fk_care_gap_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`coordinator_assignment` ADD CONSTRAINT `fk_care_coordinator_assignment_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`hra` ADD CONSTRAINT `fk_care_hra_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`condition_registry` ADD CONSTRAINT `fk_care_condition_registry_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`care`.`sdoh_assessment` ADD CONSTRAINT `fk_care_sdoh_assessment_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);

-- ========= claim --> appeal (4 constraint(s)) =========
-- Requires: claim schema, appeal schema
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `health_insurance_ecm`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_adverse_determination_id` FOREIGN KEY (`adverse_determination_id`) REFERENCES `health_insurance_ecm`.`appeal`.`adverse_determination`(`adverse_determination_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `health_insurance_ecm`.`appeal`.`case`(`case_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_outcome_id` FOREIGN KEY (`outcome_id`) REFERENCES `health_insurance_ecm`.`appeal`.`outcome`(`outcome_id`);

-- ========= claim --> billing (3 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `health_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `health_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);

-- ========= claim --> care (4 constraint(s)) =========
-- Requires: claim schema, care schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);

-- ========= claim --> compliance (2 constraint(s)) =========
-- Requires: claim schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `health_insurance_ecm`.`compliance`.`fwa_case`(`fwa_case_id`);

-- ========= claim --> contract (13 constraint(s)) =========
-- Requires: claim schema, contract schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `health_insurance_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fee_schedule_rate_id` FOREIGN KEY (`fee_schedule_rate_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule_rate`(`fee_schedule_rate_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `health_insurance_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `health_insurance_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_payment_payer_party_id` FOREIGN KEY (`payment_payer_party_id`) REFERENCES `health_insurance_ecm`.`contract`.`party`(`party_id`);

-- ========= claim --> employer (3 constraint(s)) =========
-- Requires: claim schema, employer schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_tpa_arrangement_id` FOREIGN KEY (`tpa_arrangement_id`) REFERENCES `health_insurance_ecm`.`employer`.`tpa_arrangement`(`tpa_arrangement_id`);

-- ========= claim --> enrollment (13 constraint(s)) =========
-- Requires: claim schema, enrollment schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_cobra_election_id` FOREIGN KEY (`cobra_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`cobra_election`(`cobra_election_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_eligibility_verification_id` FOREIGN KEY (`eligibility_verification_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`eligibility_verification`(`eligibility_verification_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_exchange_enrollment_id` FOREIGN KEY (`exchange_enrollment_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`exchange_enrollment`(`exchange_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_medicaid_eligibility_id` FOREIGN KEY (`medicaid_eligibility_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`medicaid_eligibility`(`medicaid_eligibility_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_medicare_entitlement_id` FOREIGN KEY (`medicare_entitlement_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`medicare_entitlement`(`medicare_entitlement_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);

-- ========= claim --> member (16 constraint(s)) =========
-- Requires: claim schema, member schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pcp_assignment_id` FOREIGN KEY (`pcp_assignment_id`) REFERENCES `health_insurance_ecm`.`member`.`pcp_assignment`(`pcp_assignment_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_cob_record_id` FOREIGN KEY (`cob_record_id`) REFERENCES `health_insurance_ecm`.`member`.`cob_record`(`cob_record_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);

-- ========= claim --> network (8 constraint(s)) =========
-- Requires: claim schema, network schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= claim --> pharmacy (11 constraint(s)) =========
-- Requires: claim schema, pharmacy schema
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);

-- ========= claim --> plan (13 constraint(s)) =========
-- Requires: claim schema, plan schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `health_insurance_ecm`.`plan`.`plan_service_area`(`plan_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `health_insurance_ecm`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `health_insurance_ecm`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= claim --> provider (15 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_provider_provider_id` FOREIGN KEY (`provider_provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= claim --> risk (4 constraint(s)) =========
-- Requires: claim schema, risk schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `health_insurance_ecm`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_reinsurance_claim_id` FOREIGN KEY (`reinsurance_claim_id`) REFERENCES `health_insurance_ecm`.`risk`.`reinsurance_claim`(`reinsurance_claim_id`);

-- ========= claim --> utilization (12 constraint(s)) =========
-- Requires: claim schema, utilization schema
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_inpatient_admission_id` FOREIGN KEY (`inpatient_admission_id`) REFERENCES `health_insurance_ecm`.`utilization`.`inpatient_admission`(`inpatient_admission_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ADD CONSTRAINT `fk_claim_header_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `health_insurance_ecm`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_auth_service_line_id` FOREIGN KEY (`auth_service_line_id`) REFERENCES `health_insurance_ecm`.`utilization`.`auth_service_line`(`auth_service_line_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_medical_policy_id` FOREIGN KEY (`medical_policy_id`) REFERENCES `health_insurance_ecm`.`utilization`.`medical_policy`(`medical_policy_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_decision_id` FOREIGN KEY (`pa_decision_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_decision`(`pa_decision_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);

-- ========= compliance --> billing (4 constraint(s)) =========
-- Requires: compliance schema, billing schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `health_insurance_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `health_insurance_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);

-- ========= compliance --> claim (1 constraint(s)) =========
-- Requires: compliance schema, claim schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);

-- ========= compliance --> contract (13 constraint(s)) =========
-- Requires: compliance schema, contract schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_survey` ADD CONSTRAINT `fk_compliance_accreditation_survey_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= compliance --> employer (9 constraint(s)) =========
-- Requires: compliance schema, employer schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_tpa_arrangement_id` FOREIGN KEY (`tpa_arrangement_id`) REFERENCES `health_insurance_ecm`.`employer`.`tpa_arrangement`(`tpa_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= compliance --> member (4 constraint(s)) =========
-- Requires: compliance schema, member schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);

-- ========= compliance --> network (2 constraint(s)) =========
-- Requires: compliance schema, network schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);

-- ========= compliance --> pharmacy (3 constraint(s)) =========
-- Requires: compliance schema, pharmacy schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= compliance --> plan (13 constraint(s)) =========
-- Requires: compliance schema, plan schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `health_insurance_ecm`.`plan`.`rate`(`rate_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`hipaa_privacy_request` ADD CONSTRAINT `fk_compliance_hipaa_privacy_request_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`mlr_calculation` ADD CONSTRAINT `fk_compliance_mlr_calculation_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`accreditation_program` ADD CONSTRAINT `fk_compliance_accreditation_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= compliance --> provider (8 constraint(s)) =========
-- Requires: compliance schema, provider schema
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`baa` ADD CONSTRAINT `fk_compliance_baa_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_case` ADD CONSTRAINT `fk_compliance_fwa_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= contract --> network (14 constraint(s)) =========
-- Requires: contract schema, network schema
ALTER TABLE `health_insurance_ecm`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule_rate` ADD CONSTRAINT `fk_contract_fee_schedule_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_vbc_program_id` FOREIGN KEY (`vbc_program_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_program`(`vbc_program_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`reimbursement_policy` ADD CONSTRAINT `fk_contract_reimbursement_policy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= contract --> plan (15 constraint(s)) =========
-- Requires: contract schema, plan schema
ALTER TABLE `health_insurance_ecm`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_performance_period` ADD CONSTRAINT `fk_contract_vbc_performance_period_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`delegation_agreement` ADD CONSTRAINT `fk_contract_delegation_agreement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= contract --> provider (21 constraint(s)) =========
-- Requires: contract schema, provider schema
ALTER TABLE `health_insurance_ecm`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`provider_contract` ADD CONSTRAINT `fk_contract_provider_contract_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`fee_schedule` ADD CONSTRAINT `fk_contract_fee_schedule_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_payment` ADD CONSTRAINT `fk_contract_capitation_payment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`incentive_arrangement` ADD CONSTRAINT `fk_contract_incentive_arrangement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`contract_network_participation` ADD CONSTRAINT `fk_contract_contract_network_participation_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);

-- ========= contract --> risk (6 constraint(s)) =========
-- Requires: contract schema, risk schema
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `health_insurance_ecm`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`capitation_arrangement` ADD CONSTRAINT `fk_contract_capitation_arrangement_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `health_insurance_ecm`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_contract` ADD CONSTRAINT `fk_contract_vbc_contract_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_performance_period` ADD CONSTRAINT `fk_contract_vbc_performance_period_cms_submission_id` FOREIGN KEY (`cms_submission_id`) REFERENCES `health_insurance_ecm`.`risk`.`cms_submission`(`cms_submission_id`);
ALTER TABLE `health_insurance_ecm`.`contract`.`vbc_performance_period` ADD CONSTRAINT `fk_contract_vbc_performance_period_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `health_insurance_ecm`.`risk`.`raps_submission`(`raps_submission_id`);

-- ========= employer --> contract (2 constraint(s)) =========
-- Requires: employer schema, contract schema
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);

-- ========= employer --> network (5 constraint(s)) =========
-- Requires: employer schema, network schema
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);

-- ========= employer --> plan (11 constraint(s)) =========
-- Requires: employer schema, plan schema
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_plan_service_area_id` FOREIGN KEY (`plan_service_area_id`) REFERENCES `health_insurance_ecm`.`plan`.`plan_service_area`(`plan_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ADD CONSTRAINT `fk_employer_participation_requirement_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= employer --> provider (1 constraint(s)) =========
-- Requires: employer schema, provider schema
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);

-- ========= employer --> risk (1 constraint(s)) =========
-- Requires: employer schema, risk schema
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `health_insurance_ecm`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);

-- ========= enrollment --> care (2 constraint(s)) =========
-- Requires: enrollment schema, care schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);

-- ========= enrollment --> compliance (6 constraint(s)) =========
-- Requires: enrollment schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= enrollment --> contract (9 constraint(s)) =========
-- Requires: enrollment schema, contract schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);

-- ========= enrollment --> employer (17 constraint(s)) =========
-- Requires: enrollment schema, employer schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_group_location_id` FOREIGN KEY (`group_location_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_location`(`group_location_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_contact_id` FOREIGN KEY (`group_contact_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_contact`(`group_contact_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_open_enrollment_window_id` FOREIGN KEY (`open_enrollment_window_id`) REFERENCES `health_insurance_ecm`.`employer`.`open_enrollment_window`(`open_enrollment_window_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `health_insurance_ecm`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_open_enrollment_window_id` FOREIGN KEY (`open_enrollment_window_id`) REFERENCES `health_insurance_ecm`.`employer`.`open_enrollment_window`(`open_enrollment_window_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= enrollment --> member (11 constraint(s)) =========
-- Requires: enrollment schema, member schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`qualifying_life_event` ADD CONSTRAINT `fk_enrollment_qualifying_life_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);

-- ========= enrollment --> network (11 constraint(s)) =========
-- Requires: enrollment schema, network schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);

-- ========= enrollment --> plan (18 constraint(s)) =========
-- Requires: enrollment schema, plan schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `health_insurance_ecm`.`plan`.`rate`(`rate_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`open_enrollment_period` ADD CONSTRAINT `fk_enrollment_open_enrollment_period_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`cobra_election` ADD CONSTRAINT `fk_enrollment_cobra_election_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_hsa_hra_config_id` FOREIGN KEY (`hsa_hra_config_id`) REFERENCES `health_insurance_ecm`.`plan`.`hsa_hra_config`(`hsa_hra_config_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);

-- ========= enrollment --> provider (6 constraint(s)) =========
-- Requires: enrollment schema, provider schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span` ADD CONSTRAINT `fk_enrollment_enrollment_eligibility_span_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`eligibility_verification` ADD CONSTRAINT `fk_enrollment_eligibility_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicaid_eligibility` ADD CONSTRAINT `fk_enrollment_medicaid_eligibility_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`exchange_enrollment` ADD CONSTRAINT `fk_enrollment_exchange_enrollment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= enrollment --> risk (4 constraint(s)) =========
-- Requires: enrollment schema, risk schema
ALTER TABLE `health_insurance_ecm`.`enrollment`.`transaction` ADD CONSTRAINT `fk_enrollment_transaction_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`event` ADD CONSTRAINT `fk_enrollment_event_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`plan_election` ADD CONSTRAINT `fk_enrollment_plan_election_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`enrollment`.`medicare_entitlement` ADD CONSTRAINT `fk_enrollment_medicare_entitlement_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= member --> billing (3 constraint(s)) =========
-- Requires: member schema, billing schema
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);

-- ========= member --> care (4 constraint(s)) =========
-- Requires: member schema, care schema
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);

-- ========= member --> contract (8 constraint(s)) =========
-- Requires: member schema, contract schema
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_vbc_contract_id` FOREIGN KEY (`vbc_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`vbc_contract`(`vbc_contract_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_contract_network_participation_id` FOREIGN KEY (`contract_network_participation_id`) REFERENCES `health_insurance_ecm`.`contract`.`contract_network_participation`(`contract_network_participation_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= member --> employer (12 constraint(s)) =========
-- Requires: member schema, employer schema
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_open_enrollment_window_id` FOREIGN KEY (`open_enrollment_window_id`) REFERENCES `health_insurance_ecm`.`employer`.`open_enrollment_window`(`open_enrollment_window_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_tpa_arrangement_id` FOREIGN KEY (`tpa_arrangement_id`) REFERENCES `health_insurance_ecm`.`employer`.`tpa_arrangement`(`tpa_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_tpa_arrangement_id` FOREIGN KEY (`tpa_arrangement_id`) REFERENCES `health_insurance_ecm`.`employer`.`tpa_arrangement`(`tpa_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_open_enrollment_window_id` FOREIGN KEY (`open_enrollment_window_id`) REFERENCES `health_insurance_ecm`.`employer`.`open_enrollment_window`(`open_enrollment_window_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);

-- ========= member --> enrollment (10 constraint(s)) =========
-- Requires: member schema, enrollment schema
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_cobra_election_id` FOREIGN KEY (`cobra_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`cobra_election`(`cobra_election_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_qualifying_life_event_id` FOREIGN KEY (`qualifying_life_event_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`qualifying_life_event`(`qualifying_life_event_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`open_enrollment_period`(`open_enrollment_period_id`);

-- ========= member --> network (8 constraint(s)) =========
-- Requires: member schema, network schema
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= member --> pharmacy (2 constraint(s)) =========
-- Requires: member schema, pharmacy schema
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= member --> plan (14 constraint(s)) =========
-- Requires: member schema, plan schema
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `health_insurance_ecm`.`plan`.`rate`(`rate_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `health_insurance_ecm`.`plan`.`rate`(`rate_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_disenrollment_new_plan_health_plan_id` FOREIGN KEY (`disenrollment_new_plan_health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);

-- ========= member --> provider (4 constraint(s)) =========
-- Requires: member schema, provider schema
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= member --> utilization (2 constraint(s)) =========
-- Requires: member schema, utilization schema
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);

-- ========= network --> appeal (1 constraint(s)) =========
-- Requires: network schema, appeal schema
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_case_id` FOREIGN KEY (`case_id`) REFERENCES `health_insurance_ecm`.`appeal`.`case`(`case_id`);

-- ========= network --> compliance (9 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ADD CONSTRAINT `fk_network_adequacy_standard_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ADD CONSTRAINT `fk_network_access_standard_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ADD CONSTRAINT `fk_network_vbc_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `health_insurance_ecm`.`compliance`.`baa`(`baa_id`);

-- ========= network --> contract (5 constraint(s)) =========
-- Requires: network schema, contract schema
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= network --> plan (10 constraint(s)) =========
-- Requires: network schema, plan schema
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= network --> provider (3 constraint(s)) =========
-- Requires: network schema, provider schema
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ADD CONSTRAINT `fk_network_network_provider_practice_location_id` FOREIGN KEY (`practice_location_id`) REFERENCES `health_insurance_ecm`.`provider`.`practice_location`(`practice_location_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ADD CONSTRAINT `fk_network_network_provider_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `health_insurance_ecm`.`provider`.`group_practice`(`group_practice_id`);

-- ========= pharmacy --> appeal (1 constraint(s)) =========
-- Requires: pharmacy schema, appeal schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_case_id` FOREIGN KEY (`case_id`) REFERENCES `health_insurance_ecm`.`appeal`.`case`(`case_id`);

-- ========= pharmacy --> billing (3 constraint(s)) =========
-- Requires: pharmacy schema, billing schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `health_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `health_insurance_ecm`.`billing`.`cycle`(`cycle_id`);

-- ========= pharmacy --> care (1 constraint(s)) =========
-- Requires: pharmacy schema, care schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);

-- ========= pharmacy --> claim (2 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);

-- ========= pharmacy --> compliance (3 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `health_insurance_ecm`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= pharmacy --> contract (9 constraint(s)) =========
-- Requires: pharmacy schema, contract schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= pharmacy --> employer (1 constraint(s)) =========
-- Requires: pharmacy schema, employer schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= pharmacy --> enrollment (6 constraint(s)) =========
-- Requires: pharmacy schema, enrollment schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_pharmacy_claim_transaction_id` FOREIGN KEY (`pharmacy_claim_transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_medicare_entitlement_id` FOREIGN KEY (`medicare_entitlement_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`medicare_entitlement`(`medicare_entitlement_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);

-- ========= pharmacy --> member (3 constraint(s)) =========
-- Requires: pharmacy schema, member schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);

-- ========= pharmacy --> network (5 constraint(s)) =========
-- Requires: pharmacy schema, network schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);

-- ========= pharmacy --> plan (4 constraint(s)) =========
-- Requires: pharmacy schema, plan schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= pharmacy --> provider (4 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= pharmacy --> risk (2 constraint(s)) =========
-- Requires: pharmacy schema, risk schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= pharmacy --> utilization (10 constraint(s)) =========
-- Requires: pharmacy schema, utilization schema
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pharmacy_claim` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim_um_case_id` FOREIGN KEY (`um_case_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_case`(`um_case_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_clinical_criteria_id` FOREIGN KEY (`clinical_criteria_id`) REFERENCES `health_insurance_ecm`.`utilization`.`clinical_criteria`(`clinical_criteria_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_pa_request_id` FOREIGN KEY (`pa_request_id`) REFERENCES `health_insurance_ecm`.`utilization`.`pa_request`(`pa_request_id`);
ALTER TABLE `health_insurance_ecm`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_um_program_id` FOREIGN KEY (`um_program_id`) REFERENCES `health_insurance_ecm`.`utilization`.`um_program`(`um_program_id`);

-- ========= plan --> compliance (4 constraint(s)) =========
-- Requires: plan schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`hsa_hra_config` ADD CONSTRAINT `fk_plan_hsa_hra_config_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= plan --> employer (3 constraint(s)) =========
-- Requires: plan schema, employer schema
ALTER TABLE `health_insurance_ecm`.`plan`.`hsa_hra_config` ADD CONSTRAINT `fk_plan_hsa_hra_config_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);

-- ========= plan --> network (8 constraint(s)) =========
-- Requires: plan schema, network schema
ALTER TABLE `health_insurance_ecm`.`plan`.`health_plan` ADD CONSTRAINT `fk_plan_health_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= plan --> pharmacy (5 constraint(s)) =========
-- Requires: plan schema, pharmacy schema
ALTER TABLE `health_insurance_ecm`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_formulary_drug_tier_id` FOREIGN KEY (`formulary_drug_tier_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary_drug_tier`(`formulary_drug_tier_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_formulary_drug_tier_id` FOREIGN KEY (`formulary_drug_tier_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary_drug_tier`(`formulary_drug_tier_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `health_insurance_ecm`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= plan --> risk (2 constraint(s)) =========
-- Requires: plan schema, risk schema
ALTER TABLE `health_insurance_ecm`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_risk_underwriting_case_id` FOREIGN KEY (`risk_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`risk`.`risk_underwriting_case`(`risk_underwriting_case_id`);

-- ========= provider --> compliance (5 constraint(s)) =========
-- Requires: provider schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_provider` ADD CONSTRAINT `fk_provider_provider_provider_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `health_insurance_ecm`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`license` ADD CONSTRAINT `fk_provider_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `health_insurance_ecm`.`compliance`.`fwa_case`(`fwa_case_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= provider --> contract (2 constraint(s)) =========
-- Requires: provider schema, contract schema
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);

-- ========= provider --> network (5 constraint(s)) =========
-- Requires: provider schema, network schema
ALTER TABLE `health_insurance_ecm`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_directory_id` FOREIGN KEY (`provider_directory_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_directory`(`provider_directory_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);

-- ========= provider --> plan (2 constraint(s)) =========
-- Requires: provider schema, plan schema
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= risk --> compliance (6 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ADD CONSTRAINT `fk_risk_cms_submission_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ADD CONSTRAINT `fk_risk_cms_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ADD CONSTRAINT `fk_risk_reinsurance_arrangement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= risk --> employer (2 constraint(s)) =========
-- Requires: risk schema, employer schema
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_employer_underwriting_case_id` FOREIGN KEY (`employer_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`employer`.`employer_underwriting_case`(`employer_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= risk --> member (8 constraint(s)) =========
-- Requires: risk schema, member schema
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);

-- ========= risk --> network (1 constraint(s)) =========
-- Requires: risk schema, network schema
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);

-- ========= risk --> plan (10 constraint(s)) =========
-- Requires: risk schema, plan schema
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ADD CONSTRAINT `fk_risk_cms_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ADD CONSTRAINT `fk_risk_cms_submission_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ADD CONSTRAINT `fk_risk_reinsurance_arrangement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ADD CONSTRAINT `fk_risk_reinsurance_arrangement_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);

-- ========= risk --> provider (2 constraint(s)) =========
-- Requires: risk schema, provider schema
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);

-- ========= utilization --> care (14 constraint(s)) =========
-- Requires: utilization schema, care schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_gap_id` FOREIGN KEY (`gap_id`) REFERENCES `health_insurance_ecm`.`care`.`gap`(`gap_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `health_insurance_ecm`.`care`.`care_plan`(`care_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_coordinator_id` FOREIGN KEY (`coordinator_id`) REFERENCES `health_insurance_ecm`.`care`.`coordinator`(`coordinator_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_care_enrollment_id` FOREIGN KEY (`care_enrollment_id`) REFERENCES `health_insurance_ecm`.`care`.`care_enrollment`(`care_enrollment_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `health_insurance_ecm`.`care`.`program`(`program_id`);

-- ========= utilization --> claim (1 constraint(s)) =========
-- Requires: utilization schema, claim schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);

-- ========= utilization --> compliance (14 constraint(s)) =========
-- Requires: utilization schema, compliance schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `health_insurance_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `health_insurance_ecm`.`compliance`.`fwa_case`(`fwa_case_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `health_insurance_ecm`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `health_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`clinical_criteria` ADD CONSTRAINT `fk_utilization_clinical_criteria_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `health_insurance_ecm`.`compliance`.`policy_document`(`policy_document_id`);

-- ========= utilization --> contract (17 constraint(s)) =========
-- Requires: utilization schema, contract schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `health_insurance_ecm`.`contract`.`service_scope`(`service_scope_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_capitation_arrangement_id` FOREIGN KEY (`capitation_arrangement_id`) REFERENCES `health_insurance_ecm`.`contract`.`capitation_arrangement`(`capitation_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `health_insurance_ecm`.`contract`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_contract_id` FOREIGN KEY (`provider_contract_id`) REFERENCES `health_insurance_ecm`.`contract`.`provider_contract`(`provider_contract_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_delegation_agreement_id` FOREIGN KEY (`delegation_agreement_id`) REFERENCES `health_insurance_ecm`.`contract`.`delegation_agreement`(`delegation_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `health_insurance_ecm`.`contract`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_service_scope_id` FOREIGN KEY (`service_scope_id`) REFERENCES `health_insurance_ecm`.`contract`.`service_scope`(`service_scope_id`);

-- ========= utilization --> employer (11 constraint(s)) =========
-- Requires: utilization schema, employer schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);

-- ========= utilization --> enrollment (7 constraint(s)) =========
-- Requires: utilization schema, enrollment schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`transaction`(`transaction_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_enrollment_eligibility_span_id` FOREIGN KEY (`enrollment_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`(`enrollment_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_plan_election_id` FOREIGN KEY (`plan_election_id`) REFERENCES `health_insurance_ecm`.`enrollment`.`plan_election`(`plan_election_id`);

-- ========= utilization --> member (11 constraint(s)) =========
-- Requires: utilization schema, member schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);

-- ========= utilization --> network (8 constraint(s)) =========
-- Requires: utilization schema, network schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= utilization --> plan (26 constraint(s)) =========
-- Requires: utilization schema, plan schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_cost_share_rule_id` FOREIGN KEY (`cost_share_rule_id`) REFERENCES `health_insurance_ecm`.`plan`.`cost_share_rule`(`cost_share_rule_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_program` ADD CONSTRAINT `fk_utilization_um_program_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_year_id` FOREIGN KEY (`year_id`) REFERENCES `health_insurance_ecm`.`plan`.`year`(`year_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `health_insurance_ecm`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`medical_policy` ADD CONSTRAINT `fk_utilization_medical_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `health_insurance_ecm`.`plan`.`health_plan`(`health_plan_id`);

-- ========= utilization --> provider (11 constraint(s)) =========
-- Requires: utilization schema, provider schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_decision` ADD CONSTRAINT `fk_utilization_pa_decision_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`auth_service_line` ADD CONSTRAINT `fk_utilization_auth_service_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`retrospective_review` ADD CONSTRAINT `fk_utilization_retrospective_review_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `health_insurance_ecm`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `health_insurance_ecm`.`provider`.`facility`(`facility_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_required_service` ADD CONSTRAINT `fk_utilization_pa_required_service_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `health_insurance_ecm`.`provider`.`specialty`(`specialty_id`);

-- ========= utilization --> risk (4 constraint(s)) =========
-- Requires: utilization schema, risk schema
ALTER TABLE `health_insurance_ecm`.`utilization`.`pa_request` ADD CONSTRAINT `fk_utilization_pa_request_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`concurrent_review` ADD CONSTRAINT `fk_utilization_concurrent_review_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`um_case` ADD CONSTRAINT `fk_utilization_um_case_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `health_insurance_ecm`.`utilization`.`inpatient_admission` ADD CONSTRAINT `fk_utilization_inpatient_admission_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);

