-- Cross-Domain Foreign Keys for Business: Life Insurance | Version: v1_mvm
-- Generated on: 2026-05-04 07:01:21
-- Total cross-domain FK constraints: 1355
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: actuarial, agent, annuity, billing, claims, commission, compliance, document, finance, investment, policy, policyholder, product, reinsurance, underwriting

-- ========= actuarial --> annuity (3 constraint(s)) =========
-- Requires: actuarial schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= actuarial --> billing (2 constraint(s)) =========
-- Requires: actuarial schema, billing schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);

-- ========= actuarial --> compliance (7 constraint(s)) =========
-- Requires: actuarial schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= actuarial --> document (7 constraint(s)) =========
-- Requires: actuarial schema, document schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ADD CONSTRAINT `fk_actuarial_scenario_set_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= actuarial --> investment (5 constraint(s)) =========
-- Requires: actuarial schema, investment schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= actuarial --> policy (3 constraint(s)) =========
-- Requires: actuarial schema, policy schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= actuarial --> policyholder (6 constraint(s)) =========
-- Requires: actuarial schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= actuarial --> product (32 constraint(s)) =========
-- Requires: actuarial schema, product schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);

-- ========= actuarial --> reinsurance (3 constraint(s)) =========
-- Requires: actuarial schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);

-- ========= actuarial --> underwriting (6 constraint(s)) =========
-- Requires: actuarial schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);

-- ========= agent --> commission (8 constraint(s)) =========
-- Requires: agent schema, commission schema
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ADD CONSTRAINT `fk_agent_hierarchy_node_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_compensation_contract_id` FOREIGN KEY (`compensation_contract_id`) REFERENCES `life_insurance_ecm`.`commission`.`compensation_contract`(`compensation_contract_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ADD CONSTRAINT `fk_agent_agency_producer_affiliation_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);

-- ========= agent --> compliance (5 constraint(s)) =========
-- Requires: agent schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ADD CONSTRAINT `fk_agent_license_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= agent --> document (13 constraint(s)) =========
-- Requires: agent schema, document schema
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ADD CONSTRAINT `fk_agent_license_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `life_insurance_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `life_insurance_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);

-- ========= agent --> finance (18 constraint(s)) =========
-- Requires: agent schema, finance schema
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ADD CONSTRAINT `fk_agent_hierarchy_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ADD CONSTRAINT `fk_agent_hierarchy_node_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= agent --> product (5 constraint(s)) =========
-- Requires: agent schema, product schema
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);

-- ========= annuity --> actuarial (19 constraint(s)) =========
-- Requires: annuity schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`account_value` ADD CONSTRAINT `fk_annuity_account_value_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`surrender_charge` ADD CONSTRAINT `fk_annuity_surrender_charge_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);

-- ========= annuity --> agent (5 constraint(s)) =========
-- Requires: annuity schema, agent schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= annuity --> billing (6 constraint(s)) =========
-- Requires: annuity schema, billing schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_suspense_account_id` FOREIGN KEY (`suspense_account_id`) REFERENCES `life_insurance_ecm`.`billing`.`suspense_account`(`suspense_account_id`);

-- ========= annuity --> compliance (19 constraint(s)) =========
-- Requires: annuity schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`surrender_charge` ADD CONSTRAINT `fk_annuity_surrender_charge_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);

-- ========= annuity --> document (6 constraint(s)) =========
-- Requires: annuity schema, document schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);

-- ========= annuity --> finance (21 constraint(s)) =========
-- Requires: annuity schema, finance schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`account_value` ADD CONSTRAINT `fk_annuity_account_value_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`account_value` ADD CONSTRAINT `fk_annuity_account_value_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_credit_event` ADD CONSTRAINT `fk_annuity_index_credit_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`surrender_charge` ADD CONSTRAINT `fk_annuity_surrender_charge_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= annuity --> investment (11 constraint(s)) =========
-- Requires: annuity schema, investment schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_derivative_contract_id` FOREIGN KEY (`derivative_contract_id`) REFERENCES `life_insurance_ecm`.`investment`.`derivative_contract`(`derivative_contract_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_derivative_contract_id` FOREIGN KEY (`derivative_contract_id`) REFERENCES `life_insurance_ecm`.`investment`.`derivative_contract`(`derivative_contract_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`sub_account_allocation` ADD CONSTRAINT `fk_annuity_sub_account_allocation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= annuity --> policy (2 constraint(s)) =========
-- Requires: annuity schema, policy schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= annuity --> policyholder (17 constraint(s)) =========
-- Requires: annuity schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_primary_annuity_annuitant_party_id` FOREIGN KEY (`primary_annuity_annuitant_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`account_value` ADD CONSTRAINT `fk_annuity_account_value_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= annuity --> product (18 constraint(s)) =========
-- Requires: annuity schema, product schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_rate_action_id` FOREIGN KEY (`rate_action_id`) REFERENCES `life_insurance_ecm`.`product`.`rate_action`(`rate_action_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_state_approval_id` FOREIGN KEY (`state_approval_id`) REFERENCES `life_insurance_ecm`.`product`.`state_approval`(`state_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_suitability_rule_id` FOREIGN KEY (`suitability_rule_id`) REFERENCES `life_insurance_ecm`.`product`.`suitability_rule`(`suitability_rule_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_charge_schedule_id` FOREIGN KEY (`charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_rate_action_id` FOREIGN KEY (`rate_action_id`) REFERENCES `life_insurance_ecm`.`product`.`rate_action`(`rate_action_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_credit_event` ADD CONSTRAINT `fk_annuity_index_credit_event_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`sub_account_allocation` ADD CONSTRAINT `fk_annuity_sub_account_allocation_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`surrender_charge` ADD CONSTRAINT `fk_annuity_surrender_charge_charge_schedule_id` FOREIGN KEY (`charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);

-- ========= annuity --> underwriting (9 constraint(s)) =========
-- Requires: annuity schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract` ADD CONSTRAINT `fk_annuity_contract_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_exclusion_rider_id` FOREIGN KEY (`exclusion_rider_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`exclusion_rider`(`exclusion_rider_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= billing --> agent (10 constraint(s)) =========
-- Requires: billing schema, agent schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= billing --> annuity (7 constraint(s)) =========
-- Requires: billing schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= billing --> compliance (21 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= billing --> document (12 constraint(s)) =========
-- Requires: billing schema, document schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `life_insurance_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= billing --> finance (18 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `life_insurance_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `life_insurance_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);

-- ========= billing --> investment (4 constraint(s)) =========
-- Requires: billing schema, investment schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= billing --> policy (13 constraint(s)) =========
-- Requires: billing schema, policy schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `life_insurance_ecm`.`policy`.`loan`(`loan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= billing --> policyholder (24 constraint(s)) =========
-- Requires: billing schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_trust_id` FOREIGN KEY (`trust_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`trust`(`trust_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_party_address_id` FOREIGN KEY (`party_address_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party_address`(`party_address_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_kyc_verification_id` FOREIGN KEY (`kyc_verification_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`kyc_verification`(`kyc_verification_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_account_payer_party_id` FOREIGN KEY (`account_payer_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_primary_account_party_id` FOREIGN KEY (`primary_account_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= billing --> product (30 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_charge_schedule_id` FOREIGN KEY (`charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_rate_action_id` FOREIGN KEY (`rate_action_id`) REFERENCES `life_insurance_ecm`.`product`.`rate_action`(`rate_action_id`);

-- ========= billing --> underwriting (3 constraint(s)) =========
-- Requires: billing schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);

-- ========= claims --> actuarial (10 constraint(s)) =========
-- Requires: claims schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_cash_flow_projection_id` FOREIGN KEY (`cash_flow_projection_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cash_flow_projection`(`cash_flow_projection_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);

-- ========= claims --> agent (5 constraint(s)) =========
-- Requires: claims schema, agent schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= claims --> annuity (13 constraint(s)) =========
-- Requires: claims schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_cost_basis_ledger_id` FOREIGN KEY (`cost_basis_ledger_id`) REFERENCES `life_insurance_ecm`.`annuity`.`cost_basis_ledger`(`cost_basis_ledger_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_account_value_id` FOREIGN KEY (`account_value_id`) REFERENCES `life_insurance_ecm`.`annuity`.`account_value`(`account_value_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_benefit_base_id` FOREIGN KEY (`benefit_base_id`) REFERENCES `life_insurance_ecm`.`annuity`.`benefit_base`(`benefit_base_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_benefit_base_id` FOREIGN KEY (`benefit_base_id`) REFERENCES `life_insurance_ecm`.`annuity`.`benefit_base`(`benefit_base_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_rider_benefit_id` FOREIGN KEY (`rider_benefit_id`) REFERENCES `life_insurance_ecm`.`annuity`.`rider_benefit`(`rider_benefit_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_payout_schedule_id` FOREIGN KEY (`payout_schedule_id`) REFERENCES `life_insurance_ecm`.`annuity`.`payout_schedule`(`payout_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_surrender_charge_id` FOREIGN KEY (`surrender_charge_id`) REFERENCES `life_insurance_ecm`.`annuity`.`surrender_charge`(`surrender_charge_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_contract_valuation_id` FOREIGN KEY (`contract_valuation_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract_valuation`(`contract_valuation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= claims --> billing (6 constraint(s)) =========
-- Requires: claims schema, billing schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_billing_reinstatement_id` FOREIGN KEY (`billing_reinstatement_id`) REFERENCES `life_insurance_ecm`.`billing`.`billing_reinstatement`(`billing_reinstatement_id`);

-- ========= claims --> compliance (15 constraint(s)) =========
-- Requires: claims schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= claims --> document (10 constraint(s)) =========
-- Requires: claims schema, document schema
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_nigo_record_id` FOREIGN KEY (`nigo_record_id`) REFERENCES `life_insurance_ecm`.`document`.`nigo_record`(`nigo_record_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_retention_schedule_id` FOREIGN KEY (`retention_schedule_id`) REFERENCES `life_insurance_ecm`.`document`.`retention_schedule`(`retention_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_type_id` FOREIGN KEY (`type_id`) REFERENCES `life_insurance_ecm`.`document`.`type`(`type_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_version_id` FOREIGN KEY (`version_id`) REFERENCES `life_insurance_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ADD CONSTRAINT `fk_claims_claim_status_history_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= claims --> finance (12 constraint(s)) =========
-- Requires: claims schema, finance schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= claims --> investment (8 constraint(s)) =========
-- Requires: claims schema, investment schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= claims --> policy (25 constraint(s)) =========
-- Requires: claims schema, policy schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `life_insurance_ecm`.`policy`.`assignment`(`assignment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_claim_policy_in_force_policy_id` FOREIGN KEY (`claim_policy_in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `life_insurance_ecm`.`policy`.`loan`(`loan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_policy_beneficiary_id` FOREIGN KEY (`policy_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_beneficiary`(`policy_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_policy_beneficiary_id` FOREIGN KEY (`policy_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_beneficiary`(`policy_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `life_insurance_ecm`.`policy`.`assignment`(`assignment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_dividend_id` FOREIGN KEY (`dividend_id`) REFERENCES `life_insurance_ecm`.`policy`.`dividend`(`dividend_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `life_insurance_ecm`.`policy`.`loan`(`loan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);

-- ========= claims --> policyholder (12 constraint(s)) =========
-- Requires: claims schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_beneficiary_designation_id` FOREIGN KEY (`beneficiary_designation_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`beneficiary_designation`(`beneficiary_designation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= claims --> product (20 constraint(s)) =========
-- Requires: claims schema, product schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_form_id` FOREIGN KEY (`form_id`) REFERENCES `life_insurance_ecm`.`product`.`form`(`form_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);

-- ========= claims --> reinsurance (8 constraint(s)) =========
-- Requires: claims schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);

-- ========= claims --> underwriting (13 constraint(s)) =========
-- Requires: claims schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_exclusion_rider_id` FOREIGN KEY (`exclusion_rider_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`exclusion_rider`(`exclusion_rider_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_evidence_review_id` FOREIGN KEY (`evidence_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_review`(`evidence_review_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_financial_uw_review_id` FOREIGN KEY (`financial_uw_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`financial_uw_review`(`financial_uw_review_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);

-- ========= commission --> actuarial (6 constraint(s)) =========
-- Requires: commission schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);

-- ========= commission --> agent (23 constraint(s)) =========
-- Requires: commission schema, agent schema
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_tertiary_commission_co_agent_producer_id` FOREIGN KEY (`tertiary_commission_co_agent_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_transaction_commission_producer_id` FOREIGN KEY (`transaction_commission_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_payment` ADD CONSTRAINT `fk_commission_bonus_payment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_adjustment_producer_id` FOREIGN KEY (`adjustment_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_agency_producer_affiliation_id` FOREIGN KEY (`agency_producer_affiliation_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency_producer_affiliation`(`agency_producer_affiliation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_contracting_id` FOREIGN KEY (`contracting_id`) REFERENCES `life_insurance_ecm`.`agent`.`contracting`(`contracting_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= commission --> annuity (8 constraint(s)) =========
-- Requires: commission schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_annuity_premium_payment_id` FOREIGN KEY (`annuity_premium_payment_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_premium_payment`(`annuity_premium_payment_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_tax_free_exchange_id` FOREIGN KEY (`tax_free_exchange_id`) REFERENCES `life_insurance_ecm`.`annuity`.`tax_free_exchange`(`tax_free_exchange_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_withdrawal_transaction_id` FOREIGN KEY (`withdrawal_transaction_id`) REFERENCES `life_insurance_ecm`.`annuity`.`withdrawal_transaction`(`withdrawal_transaction_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= commission --> billing (10 constraint(s)) =========
-- Requires: commission schema, billing schema
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_premium_allocation_id` FOREIGN KEY (`premium_allocation_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_allocation`(`premium_allocation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_billing_reinstatement_id` FOREIGN KEY (`billing_reinstatement_id`) REFERENCES `life_insurance_ecm`.`billing`.`billing_reinstatement`(`billing_reinstatement_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `life_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_billing_reinstatement_id` FOREIGN KEY (`billing_reinstatement_id`) REFERENCES `life_insurance_ecm`.`billing`.`billing_reinstatement`(`billing_reinstatement_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_premium_adjustment_id` FOREIGN KEY (`premium_adjustment_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_adjustment`(`premium_adjustment_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);

-- ========= commission --> claims (3 constraint(s)) =========
-- Requires: commission schema, claims schema
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_contestability_review_id` FOREIGN KEY (`contestability_review_id`) REFERENCES `life_insurance_ecm`.`claims`.`contestability_review`(`contestability_review_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_claim_investigation_id` FOREIGN KEY (`claim_investigation_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_investigation`(`claim_investigation_id`);

-- ========= commission --> compliance (13 constraint(s)) =========
-- Requires: commission schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= commission --> document (8 constraint(s)) =========
-- Requires: commission schema, document schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= commission --> finance (16 constraint(s)) =========
-- Requires: commission schema, finance schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_payment` ADD CONSTRAINT `fk_commission_bonus_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= commission --> investment (6 constraint(s)) =========
-- Requires: commission schema, investment schema
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= commission --> policy (9 constraint(s)) =========
-- Requires: commission schema, policy schema
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_policy_reinstatement_id` FOREIGN KEY (`policy_reinstatement_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_reinstatement`(`policy_reinstatement_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_surrender_id` FOREIGN KEY (`surrender_id`) REFERENCES `life_insurance_ecm`.`policy`.`surrender`(`surrender_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_policy_reinstatement_id` FOREIGN KEY (`policy_reinstatement_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_reinstatement`(`policy_reinstatement_id`);

-- ========= commission --> policyholder (4 constraint(s)) =========
-- Requires: commission schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_ownership_transfer_id` FOREIGN KEY (`ownership_transfer_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`ownership_transfer`(`ownership_transfer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_death_verification_id` FOREIGN KEY (`death_verification_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`death_verification`(`death_verification_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_ownership_transfer_id` FOREIGN KEY (`ownership_transfer_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`ownership_transfer`(`ownership_transfer_id`);

-- ========= commission --> product (21 constraint(s)) =========
-- Requires: commission schema, product schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payment` ADD CONSTRAINT `fk_commission_payment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);

-- ========= commission --> reinsurance (3 constraint(s)) =========
-- Requires: commission schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`commission`.`transaction` ADD CONSTRAINT `fk_commission_transaction_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_recapture_event_id` FOREIGN KEY (`recapture_event_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`recapture_event`(`recapture_event_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);

-- ========= compliance --> agent (12 constraint(s)) =========
-- Requires: compliance schema, agent schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_termination_event_id` FOREIGN KEY (`termination_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`termination_event`(`termination_event_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `life_insurance_ecm`.`agent`.`appointment`(`appointment_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= compliance --> commission (5 constraint(s)) =========
-- Requires: compliance schema, commission schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_chargeback_rule_id` FOREIGN KEY (`chargeback_rule_id`) REFERENCES `life_insurance_ecm`.`commission`.`chargeback_rule`(`chargeback_rule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_compensation_contract_id` FOREIGN KEY (`compensation_contract_id`) REFERENCES `life_insurance_ecm`.`commission`.`compensation_contract`(`compensation_contract_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);

-- ========= compliance --> document (11 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_acord_form_id` FOREIGN KEY (`acord_form_id`) REFERENCES `life_insurance_ecm`.`document`.`acord_form`(`acord_form_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`jurisdiction_license` ADD CONSTRAINT `fk_compliance_jurisdiction_license_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= compliance --> finance (28 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`jurisdiction_license` ADD CONSTRAINT `fk_compliance_jurisdiction_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`jurisdiction_license` ADD CONSTRAINT `fk_compliance_jurisdiction_license_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> investment (6 constraint(s)) =========
-- Requires: compliance schema, investment schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_compliance_breach_id` FOREIGN KEY (`compliance_breach_id`) REFERENCES `life_insurance_ecm`.`investment`.`compliance_breach`(`compliance_breach_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);

-- ========= compliance --> policy (6 constraint(s)) =========
-- Requires: compliance schema, policy schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= compliance --> policyholder (4 constraint(s)) =========
-- Requires: compliance schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= compliance --> product (14 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_suitability_rule_id` FOREIGN KEY (`suitability_rule_id`) REFERENCES `life_insurance_ecm`.`product`.`suitability_rule`(`suitability_rule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_form_id` FOREIGN KEY (`form_id`) REFERENCES `life_insurance_ecm`.`product`.`form`(`form_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= compliance --> underwriting (7 constraint(s)) =========
-- Requires: compliance schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_mib_inquiry_id` FOREIGN KEY (`mib_inquiry_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`mib_inquiry`(`mib_inquiry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_paramedical_exam_id` FOREIGN KEY (`paramedical_exam_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`paramedical_exam`(`paramedical_exam_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_aps_record_id` FOREIGN KEY (`aps_record_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`aps_record`(`aps_record_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= document --> agent (5 constraint(s)) =========
-- Requires: document schema, agent schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= document --> annuity (2 constraint(s)) =========
-- Requires: document schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= document --> claims (1 constraint(s)) =========
-- Requires: document schema, claims schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= document --> compliance (7 constraint(s)) =========
-- Requires: document schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`retention_schedule` ADD CONSTRAINT `fk_document_retention_schedule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= document --> investment (8 constraint(s)) =========
-- Requires: document schema, investment schema
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_mortgage_loan_id` FOREIGN KEY (`mortgage_loan_id`) REFERENCES `life_insurance_ecm`.`investment`.`mortgage_loan`(`mortgage_loan_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_mortgage_loan_id` FOREIGN KEY (`mortgage_loan_id`) REFERENCES `life_insurance_ecm`.`investment`.`mortgage_loan`(`mortgage_loan_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);

-- ========= document --> policy (5 constraint(s)) =========
-- Requires: document schema, policy schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= document --> policyholder (13 constraint(s)) =========
-- Requires: document schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_policyholder_beneficiary_id` FOREIGN KEY (`policyholder_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary`(`policyholder_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= document --> underwriting (2 constraint(s)) =========
-- Requires: document schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= finance --> actuarial (24 constraint(s)) =========
-- Requires: finance schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_cash_flow_projection_id` FOREIGN KEY (`cash_flow_projection_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cash_flow_projection`(`cash_flow_projection_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);

-- ========= finance --> claims (2 constraint(s)) =========
-- Requires: finance schema, claims schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= finance --> document (8 constraint(s)) =========
-- Requires: finance schema, document schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= finance --> investment (11 constraint(s)) =========
-- Requires: finance schema, investment schema
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_alm_analysis_id` FOREIGN KEY (`alm_analysis_id`) REFERENCES `life_insurance_ecm`.`investment`.`alm_analysis`(`alm_analysis_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_derivative_contract_id` FOREIGN KEY (`derivative_contract_id`) REFERENCES `life_insurance_ecm`.`investment`.`derivative_contract`(`derivative_contract_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_alm_analysis_id` FOREIGN KEY (`alm_analysis_id`) REFERENCES `life_insurance_ecm`.`investment`.`alm_analysis`(`alm_analysis_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);

-- ========= finance --> policy (12 constraint(s)) =========
-- Requires: finance schema, policy schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_tax_compliance_test_id` FOREIGN KEY (`tax_compliance_test_id`) REFERENCES `life_insurance_ecm`.`policy`.`tax_compliance_test`(`tax_compliance_test_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= finance --> product (6 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= finance --> reinsurance (3 constraint(s)) =========
-- Requires: finance schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);

-- ========= finance --> underwriting (3 constraint(s)) =========
-- Requires: finance schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);

-- ========= investment --> actuarial (2 constraint(s)) =========
-- Requires: investment schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);

-- ========= investment --> agent (1 constraint(s)) =========
-- Requires: investment schema, agent schema
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= investment --> compliance (8 constraint(s)) =========
-- Requires: investment schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= investment --> finance (9 constraint(s)) =========
-- Requires: investment schema, finance schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ADD CONSTRAINT `fk_investment_mortgage_loan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ADD CONSTRAINT `fk_investment_counterparty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= investment --> policyholder (3 constraint(s)) =========
-- Requires: investment schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ADD CONSTRAINT `fk_investment_unit_value_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ADD CONSTRAINT `fk_investment_unit_value_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);

-- ========= investment --> product (14 constraint(s)) =========
-- Requires: investment schema, product schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ADD CONSTRAINT `fk_investment_unit_value_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= policy --> actuarial (15 constraint(s)) =========
-- Requires: policy schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);

-- ========= policy --> agent (11 constraint(s)) =========
-- Requires: policy schema, agent schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `life_insurance_ecm`.`agent`.`appointment`(`appointment_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ADD CONSTRAINT `fk_policy_assignment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_conversion_producer_id` FOREIGN KEY (`conversion_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= policy --> annuity (3 constraint(s)) =========
-- Requires: policy schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= policy --> billing (3 constraint(s)) =========
-- Requires: policy schema, billing schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `life_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);

-- ========= policy --> commission (1 constraint(s)) =========
-- Requires: policy schema, commission schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);

-- ========= policy --> compliance (13 constraint(s)) =========
-- Requires: policy schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);

-- ========= policy --> document (11 constraint(s)) =========
-- Requires: policy schema, document schema
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ADD CONSTRAINT `fk_policy_policy_beneficiary_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ADD CONSTRAINT `fk_policy_assignment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= policy --> finance (8 constraint(s)) =========
-- Requires: policy schema, finance schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= policy --> investment (17 constraint(s)) =========
-- Requires: policy schema, investment schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_unit_value_id` FOREIGN KEY (`unit_value_id`) REFERENCES `life_insurance_ecm`.`investment`.`unit_value`(`unit_value_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);

-- ========= policy --> policyholder (6 constraint(s)) =========
-- Requires: policy schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_owner_party_id` FOREIGN KEY (`owner_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_owner_poa_party_id` FOREIGN KEY (`owner_poa_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_ownership_transfer_id` FOREIGN KEY (`ownership_transfer_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`ownership_transfer`(`ownership_transfer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_party_address_id` FOREIGN KEY (`party_address_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party_address`(`party_address_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= policy --> product (12 constraint(s)) =========
-- Requires: policy schema, product schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_form_id` FOREIGN KEY (`form_id`) REFERENCES `life_insurance_ecm`.`product`.`form`(`form_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_charge_schedule_id` FOREIGN KEY (`charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_irc7702_parameter_id` FOREIGN KEY (`irc7702_parameter_id`) REFERENCES `life_insurance_ecm`.`product`.`irc7702_parameter`(`irc7702_parameter_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= policy --> reinsurance (3 constraint(s)) =========
-- Requires: policy schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);

-- ========= policy --> underwriting (8 constraint(s)) =========
-- Requires: policy schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ADD CONSTRAINT `fk_policy_rider_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);

-- ========= policyholder --> actuarial (3 constraint(s)) =========
-- Requires: policyholder schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);

-- ========= policyholder --> agent (2 constraint(s)) =========
-- Requires: policyholder schema, agent schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= policyholder --> annuity (5 constraint(s)) =========
-- Requires: policyholder schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= policyholder --> claims (1 constraint(s)) =========
-- Requires: policyholder schema, claims schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= policyholder --> compliance (11 constraint(s)) =========
-- Requires: policyholder schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_remediation_plan_id` FOREIGN KEY (`remediation_plan_id`) REFERENCES `life_insurance_ecm`.`compliance`.`remediation_plan`(`remediation_plan_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`trust` ADD CONSTRAINT `fk_policyholder_trust_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);

-- ========= policyholder --> document (6 constraint(s)) =========
-- Requires: policyholder schema, document schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`relationship` ADD CONSTRAINT `fk_policyholder_relationship_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`trust` ADD CONSTRAINT `fk_policyholder_trust_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= policyholder --> finance (3 constraint(s)) =========
-- Requires: policyholder schema, finance schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= policyholder --> policy (13 constraint(s)) =========
-- Requires: policyholder schema, policy schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`party_address` ADD CONSTRAINT `fk_policyholder_party_address_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`party_contact` ADD CONSTRAINT `fk_policyholder_party_contact_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`trust` ADD CONSTRAINT `fk_policyholder_trust_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `life_insurance_ecm`.`policy`.`assignment`(`assignment_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= policyholder --> product (6 constraint(s)) =========
-- Requires: policyholder schema, product schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_form_id` FOREIGN KEY (`form_id`) REFERENCES `life_insurance_ecm`.`product`.`form`(`form_id`);

-- ========= policyholder --> underwriting (7 constraint(s)) =========
-- Requires: policyholder schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`trust` ADD CONSTRAINT `fk_policyholder_trust_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= product --> compliance (9 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ADD CONSTRAINT `fk_product_rider_definition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ADD CONSTRAINT `fk_product_irc7702_parameter_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ADD CONSTRAINT `fk_product_charge_schedule_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ADD CONSTRAINT `fk_product_suitability_rule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);

-- ========= product --> document (6 constraint(s)) =========
-- Requires: product schema, document schema
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ADD CONSTRAINT `fk_product_irc7702_parameter_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_acord_form_id` FOREIGN KEY (`acord_form_id`) REFERENCES `life_insurance_ecm`.`document`.`acord_form`(`acord_form_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= product --> finance (15 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ADD CONSTRAINT `fk_product_plan_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ADD CONSTRAINT `fk_product_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ADD CONSTRAINT `fk_product_plan_version_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ADD CONSTRAINT `fk_product_plan_version_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ADD CONSTRAINT `fk_product_benefit_structure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ADD CONSTRAINT `fk_product_rider_definition_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ADD CONSTRAINT `fk_product_irc7702_parameter_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ADD CONSTRAINT `fk_product_crediting_strategy_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ADD CONSTRAINT `fk_product_crediting_strategy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ADD CONSTRAINT `fk_product_charge_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= reinsurance --> actuarial (23 constraint(s)) =========
-- Requires: reinsurance schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);

-- ========= reinsurance --> annuity (12 constraint(s)) =========
-- Requires: reinsurance schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_rider_benefit_id` FOREIGN KEY (`rider_benefit_id`) REFERENCES `life_insurance_ecm`.`annuity`.`rider_benefit`(`rider_benefit_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_benefit_payment_id` FOREIGN KEY (`benefit_payment_id`) REFERENCES `life_insurance_ecm`.`annuity`.`benefit_payment`(`benefit_payment_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_account_value_id` FOREIGN KEY (`account_value_id`) REFERENCES `life_insurance_ecm`.`annuity`.`account_value`(`account_value_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_benefit_base_id` FOREIGN KEY (`benefit_base_id`) REFERENCES `life_insurance_ecm`.`annuity`.`benefit_base`(`benefit_base_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_rider_benefit_id` FOREIGN KEY (`rider_benefit_id`) REFERENCES `life_insurance_ecm`.`annuity`.`rider_benefit`(`rider_benefit_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`contract`(`contract_id`);

-- ========= reinsurance --> billing (9 constraint(s)) =========
-- Requires: reinsurance schema, billing schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `life_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_premium_adjustment_id` FOREIGN KEY (`premium_adjustment_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_adjustment`(`premium_adjustment_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_premium_adjustment_id` FOREIGN KEY (`premium_adjustment_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_adjustment`(`premium_adjustment_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_billing_reinstatement_id` FOREIGN KEY (`billing_reinstatement_id`) REFERENCES `life_insurance_ecm`.`billing`.`billing_reinstatement`(`billing_reinstatement_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);

-- ========= reinsurance --> claims (2 constraint(s)) =========
-- Requires: reinsurance schema, claims schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= reinsurance --> compliance (16 constraint(s)) =========
-- Requires: reinsurance schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= reinsurance --> document (8 constraint(s)) =========
-- Requires: reinsurance schema, document schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= reinsurance --> finance (13 constraint(s)) =========
-- Requires: reinsurance schema, finance schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_reinsurance_recoverable_id` FOREIGN KEY (`reinsurance_recoverable_id`) REFERENCES `life_insurance_ecm`.`finance`.`reinsurance_recoverable`(`reinsurance_recoverable_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_reinsurance_recoverable_id` FOREIGN KEY (`reinsurance_recoverable_id`) REFERENCES `life_insurance_ecm`.`finance`.`reinsurance_recoverable`(`reinsurance_recoverable_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);

-- ========= reinsurance --> investment (9 constraint(s)) =========
-- Requires: reinsurance schema, investment schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= reinsurance --> policy (12 constraint(s)) =========
-- Requires: reinsurance schema, policy schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_surrender_id` FOREIGN KEY (`surrender_id`) REFERENCES `life_insurance_ecm`.`policy`.`surrender`(`surrender_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_value_id` FOREIGN KEY (`value_id`) REFERENCES `life_insurance_ecm`.`policy`.`value`(`value_id`);

-- ========= reinsurance --> policyholder (5 constraint(s)) =========
-- Requires: reinsurance schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= reinsurance --> product (27 constraint(s)) =========
-- Requires: reinsurance schema, product schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty` ADD CONSTRAINT `fk_reinsurance_treaty_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`cession` ADD CONSTRAINT `fk_reinsurance_cession_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);

-- ========= underwriting --> actuarial (4 constraint(s)) =========
-- Requires: underwriting schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);

-- ========= underwriting --> agent (4 constraint(s)) =========
-- Requires: underwriting schema, agent schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_producer_product_auth_id` FOREIGN KEY (`producer_product_auth_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer_product_auth`(`producer_product_auth_id`);

-- ========= underwriting --> billing (3 constraint(s)) =========
-- Requires: underwriting schema, billing schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_premium_adjustment_id` FOREIGN KEY (`premium_adjustment_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_adjustment`(`premium_adjustment_id`);

-- ========= underwriting --> commission (2 constraint(s)) =========
-- Requires: underwriting schema, commission schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_chargeback_rule_id` FOREIGN KEY (`chargeback_rule_id`) REFERENCES `life_insurance_ecm`.`commission`.`chargeback_rule`(`chargeback_rule_id`);

-- ========= underwriting --> compliance (9 constraint(s)) =========
-- Requires: underwriting schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ADD CONSTRAINT `fk_underwriting_risk_class_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ADD CONSTRAINT `fk_underwriting_risk_class_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= underwriting --> document (15 constraint(s)) =========
-- Requires: underwriting schema, document schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_acord_form_id` FOREIGN KEY (`acord_form_id`) REFERENCES `life_insurance_ecm`.`document`.`acord_form`(`acord_form_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_type_id` FOREIGN KEY (`type_id`) REFERENCES `life_insurance_ecm`.`document`.`type`(`type_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= underwriting --> finance (3 constraint(s)) =========
-- Requires: underwriting schema, finance schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= underwriting --> investment (3 constraint(s)) =========
-- Requires: underwriting schema, investment schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= underwriting --> policy (7 constraint(s)) =========
-- Requires: underwriting schema, policy schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= underwriting --> policyholder (10 constraint(s)) =========
-- Requires: underwriting schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= underwriting --> product (14 constraint(s)) =========
-- Requires: underwriting schema, product schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ADD CONSTRAINT `fk_underwriting_risk_class_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= underwriting --> reinsurance (20 constraint(s)) =========
-- Requires: underwriting schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_automatic_binding_limit_id` FOREIGN KEY (`automatic_binding_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit`(`automatic_binding_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_retention_limit_id` FOREIGN KEY (`retention_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`retention_limit`(`retention_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_retention_limit_id` FOREIGN KEY (`retention_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`retention_limit`(`retention_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_automatic_binding_limit_id` FOREIGN KEY (`automatic_binding_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit`(`automatic_binding_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_retention_limit_id` FOREIGN KEY (`retention_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`retention_limit`(`retention_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_retention_limit_id` FOREIGN KEY (`retention_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`retention_limit`(`retention_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_retention_limit_id` FOREIGN KEY (`retention_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`retention_limit`(`retention_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_retention_limit_id` FOREIGN KEY (`retention_limit_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`retention_limit`(`retention_limit_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_treaty_schedule_id` FOREIGN KEY (`treaty_schedule_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty_schedule`(`treaty_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_cession_id` FOREIGN KEY (`cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`cession`(`cession_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_treaty_id` FOREIGN KEY (`treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty`(`treaty_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);

