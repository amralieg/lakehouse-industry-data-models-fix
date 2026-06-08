-- Cross-Domain Foreign Keys for Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:16
-- Total cross-domain FK constraints: 1723
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: actuarial, agent, annuity, billing, claims, commission, compliance, correspondence, document, finance, investment, policy, policyholder, product, reinsurance, reporting, underwriting, vendor, workforce

-- ========= actuarial --> annuity (5 constraint(s)) =========
-- Requires: actuarial schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ADD CONSTRAINT `fk_actuarial_tax_qualification_test_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= actuarial --> compliance (10 constraint(s)) =========
-- Requires: actuarial schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ADD CONSTRAINT `fk_actuarial_alm_position_orsa_report_id` FOREIGN KEY (`orsa_report_id`) REFERENCES `life_insurance_ecm`.`compliance`.`orsa_report`(`orsa_report_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ADD CONSTRAINT `fk_actuarial_tax_qualification_test_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_orsa_report_id` FOREIGN KEY (`orsa_report_id`) REFERENCES `life_insurance_ecm`.`compliance`.`orsa_report`(`orsa_report_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ADD CONSTRAINT `fk_actuarial_model_governance_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);

-- ========= actuarial --> document (5 constraint(s)) =========
-- Requires: actuarial schema, document schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ADD CONSTRAINT `fk_actuarial_model_governance_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= actuarial --> investment (4 constraint(s)) =========
-- Requires: actuarial schema, investment schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ADD CONSTRAINT `fk_actuarial_alm_position_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ADD CONSTRAINT `fk_actuarial_alm_strategy_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= actuarial --> policy (4 constraint(s)) =========
-- Requires: actuarial schema, policy schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= actuarial --> policyholder (6 constraint(s)) =========
-- Requires: actuarial schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ADD CONSTRAINT `fk_actuarial_tax_qualification_test_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= actuarial --> product (14 constraint(s)) =========
-- Requires: actuarial schema, product schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ADD CONSTRAINT `fk_actuarial_tax_qualification_test_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ADD CONSTRAINT `fk_actuarial_assumption_application_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= actuarial --> reinsurance (6 constraint(s)) =========
-- Requires: actuarial schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);

-- ========= actuarial --> reporting (8 constraint(s)) =========
-- Requires: actuarial schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);

-- ========= actuarial --> vendor (11 constraint(s)) =========
-- Requires: actuarial schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ADD CONSTRAINT `fk_actuarial_alm_position_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ADD CONSTRAINT `fk_actuarial_model_governance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ADD CONSTRAINT `fk_actuarial_assumption_data_source_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= actuarial --> workforce (16 constraint(s)) =========
-- Requires: actuarial schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_tertiary_assumption_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_assumption_last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ADD CONSTRAINT `fk_actuarial_experience_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ADD CONSTRAINT `fk_actuarial_alm_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ADD CONSTRAINT `fk_actuarial_tax_qualification_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ADD CONSTRAINT `fk_actuarial_model_governance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ADD CONSTRAINT `fk_actuarial_assumption_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ADD CONSTRAINT `fk_actuarial_assumption_data_source_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= agent --> compliance (2 constraint(s)) =========
-- Requires: agent schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ADD CONSTRAINT `fk_agent_agent_training_completion_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ADD CONSTRAINT `fk_agent_agent_training_completion_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `life_insurance_ecm`.`compliance`.`training_course`(`training_course_id`);

-- ========= agent --> correspondence (2 constraint(s)) =========
-- Requires: agent schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ADD CONSTRAINT `fk_agent_agent_bulk_comm_recipient_bulk_comm_campaign_id` FOREIGN KEY (`bulk_comm_campaign_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign`(`bulk_comm_campaign_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ADD CONSTRAINT `fk_agent_agent_bulk_comm_recipient_correspondence_bulk_comm_recipient_id` FOREIGN KEY (`correspondence_bulk_comm_recipient_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient`(`correspondence_bulk_comm_recipient_id`);

-- ========= agent --> document (9 constraint(s)) =========
-- Requires: agent schema, document schema
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ADD CONSTRAINT `fk_agent_license_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ADD CONSTRAINT `fk_agent_eo_policy_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ADD CONSTRAINT `fk_agent_finra_registration_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_package_id` FOREIGN KEY (`package_id`) REFERENCES `life_insurance_ecm`.`document`.`package`(`package_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= agent --> finance (6 constraint(s)) =========
-- Requires: agent schema, finance schema
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= agent --> product (4 constraint(s)) =========
-- Requires: agent schema, product schema
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ADD CONSTRAINT `fk_agent_incentive_program_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ADD CONSTRAINT `fk_agent_producer_product_authorization_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= agent --> vendor (3 constraint(s)) =========
-- Requires: agent schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ADD CONSTRAINT `fk_agent_eo_policy_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= agent --> workforce (7 constraint(s)) =========
-- Requires: agent schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_background_check_id` FOREIGN KEY (`background_check_id`) REFERENCES `life_insurance_ecm`.`workforce`.`background_check`(`background_check_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= annuity --> actuarial (6 constraint(s)) =========
-- Requires: annuity schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);

-- ========= annuity --> agent (3 constraint(s)) =========
-- Requires: annuity schema, agent schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= annuity --> billing (6 constraint(s)) =========
-- Requires: annuity schema, billing schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_suspense_account_id` FOREIGN KEY (`suspense_account_id`) REFERENCES `life_insurance_ecm`.`billing`.`suspense_account`(`suspense_account_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`systematic_withdrawal_plan` ADD CONSTRAINT `fk_annuity_systematic_withdrawal_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);

-- ========= annuity --> compliance (14 constraint(s)) =========
-- Requires: annuity schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`systematic_withdrawal_plan` ADD CONSTRAINT `fk_annuity_systematic_withdrawal_plan_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`surrender_charge` ADD CONSTRAINT `fk_annuity_surrender_charge_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_remediation` ADD CONSTRAINT `fk_annuity_contract_remediation_remediation_plan_id` FOREIGN KEY (`remediation_plan_id`) REFERENCES `life_insurance_ecm`.`compliance`.`remediation_plan`(`remediation_plan_id`);

-- ========= annuity --> document (3 constraint(s)) =========
-- Requires: annuity schema, document schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`systematic_withdrawal_plan` ADD CONSTRAINT `fk_annuity_systematic_withdrawal_plan_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= annuity --> finance (15 constraint(s)) =========
-- Requires: annuity schema, finance schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`account_value` ADD CONSTRAINT `fk_annuity_account_value_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_tax_provision_id` FOREIGN KEY (`tax_provision_id`) REFERENCES `life_insurance_ecm`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_gaap_reserve_id` FOREIGN KEY (`gaap_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`gaap_reserve`(`gaap_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`charge_detail` ADD CONSTRAINT `fk_annuity_charge_detail_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`bonus_credit` ADD CONSTRAINT `fk_annuity_bonus_credit_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);

-- ========= annuity --> investment (7 constraint(s)) =========
-- Requires: annuity schema, investment schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`mva_calculation` ADD CONSTRAINT `fk_annuity_mva_calculation_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`hedge_position` ADD CONSTRAINT `fk_annuity_hedge_position_derivative_contract_id` FOREIGN KEY (`derivative_contract_id`) REFERENCES `life_insurance_ecm`.`investment`.`derivative_contract`(`derivative_contract_id`);

-- ========= annuity --> policy (2 constraint(s)) =========
-- Requires: annuity schema, policy schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_policy_rider_id` FOREIGN KEY (`policy_rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_rider`(`policy_rider_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`charge_detail` ADD CONSTRAINT `fk_annuity_charge_detail_policy_rider_id` FOREIGN KEY (`policy_rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_rider`(`policy_rider_id`);

-- ========= annuity --> policyholder (15 constraint(s)) =========
-- Requires: annuity schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_owner_party_id` FOREIGN KEY (`owner_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_primary_annuity_annuitant_party_id` FOREIGN KEY (`primary_annuity_annuitant_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`account_value` ADD CONSTRAINT `fk_annuity_account_value_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuitization_election` ADD CONSTRAINT `fk_annuity_annuitization_election_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`systematic_withdrawal_plan` ADD CONSTRAINT `fk_annuity_systematic_withdrawal_plan_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= annuity --> product (18 constraint(s)) =========
-- Requires: annuity schema, product schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_charge_schedule_id` FOREIGN KEY (`charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_base` ADD CONSTRAINT `fk_annuity_benefit_base_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_crediting_strategy` ADD CONSTRAINT `fk_annuity_index_crediting_strategy_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_credit_event` ADD CONSTRAINT `fk_annuity_index_credit_event_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_benefit` ADD CONSTRAINT `fk_annuity_rider_benefit_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`cost_basis_ledger` ADD CONSTRAINT `fk_annuity_cost_basis_ledger_tax_qualification_id` FOREIGN KEY (`tax_qualification_id`) REFERENCES `life_insurance_ecm`.`product`.`tax_qualification`(`tax_qualification_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`sub_account_allocation` ADD CONSTRAINT `fk_annuity_sub_account_allocation_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`charge_detail` ADD CONSTRAINT `fk_annuity_charge_detail_expense_charge_id` FOREIGN KEY (`expense_charge_id`) REFERENCES `life_insurance_ecm`.`product`.`expense_charge`(`expense_charge_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`charge_detail` ADD CONSTRAINT `fk_annuity_charge_detail_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`bonus_credit` ADD CONSTRAINT `fk_annuity_bonus_credit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_crediting_allocation` ADD CONSTRAINT `fk_annuity_contract_crediting_allocation_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rider_election` ADD CONSTRAINT `fk_annuity_rider_election_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);

-- ========= annuity --> underwriting (3 constraint(s)) =========
-- Requires: annuity schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`tax_free_exchange` ADD CONSTRAINT `fk_annuity_tax_free_exchange_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= annuity --> vendor (4 constraint(s)) =========
-- Requires: annuity schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`index_credit_event` ADD CONSTRAINT `fk_annuity_index_credit_event_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`contract_valuation` ADD CONSTRAINT `fk_annuity_contract_valuation_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`mva_calculation` ADD CONSTRAINT `fk_annuity_mva_calculation_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);

-- ========= annuity --> workforce (9 constraint(s)) =========
-- Requires: annuity schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_contract` ADD CONSTRAINT `fk_annuity_annuity_contract_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`withdrawal_transaction` ADD CONSTRAINT `fk_annuity_withdrawal_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`rmd_schedule` ADD CONSTRAINT `fk_annuity_rmd_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`payout_schedule` ADD CONSTRAINT `fk_annuity_payout_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`benefit_payment` ADD CONSTRAINT `fk_annuity_benefit_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`annuity_premium_payment` ADD CONSTRAINT `fk_annuity_annuity_premium_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`systematic_withdrawal_plan` ADD CONSTRAINT `fk_annuity_systematic_withdrawal_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`annuity`.`mva_calculation` ADD CONSTRAINT `fk_annuity_mva_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> agent (9 constraint(s)) =========
-- Requires: billing schema, agent schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`list_bill_group` ADD CONSTRAINT `fk_billing_list_bill_group_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= billing --> compliance (9 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_market_conduct_exam_id` FOREIGN KEY (`market_conduct_exam_id`) REFERENCES `life_insurance_ecm`.`compliance`.`market_conduct_exam`(`market_conduct_exam_id`);

-- ========= billing --> correspondence (8 constraint(s)) =========
-- Requires: billing schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_inbound_correspondence_id` FOREIGN KEY (`inbound_correspondence_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`inbound_correspondence`(`inbound_correspondence_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);

-- ========= billing --> document (9 constraint(s)) =========
-- Requires: billing schema, document schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= billing --> finance (9 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `life_insurance_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_dac_amortization_id` FOREIGN KEY (`dac_amortization_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_amortization`(`dac_amortization_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_statutory_reserve_id` FOREIGN KEY (`statutory_reserve_id`) REFERENCES `life_insurance_ecm`.`finance`.`statutory_reserve`(`statutory_reserve_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> investment (1 constraint(s)) =========
-- Requires: billing schema, investment schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= billing --> policy (15 constraint(s)) =========
-- Requires: billing schema, policy schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_premium_policy_in_force_policy_id` FOREIGN KEY (`premium_policy_in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`refund_transaction` ADD CONSTRAINT `fk_billing_refund_transaction_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= billing --> policyholder (18 constraint(s)) =========
-- Requires: billing schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_party_address_id` FOREIGN KEY (`party_address_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party_address`(`party_address_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`eft_authorization` ADD CONSTRAINT `fk_billing_eft_authorization_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_account_payer_party_id` FOREIGN KEY (`account_payer_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_primary_account_party_id` FOREIGN KEY (`primary_account_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= billing --> product (12 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= billing --> reporting (10 constraint(s)) =========
-- Requires: billing schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_allocation` ADD CONSTRAINT `fk_billing_premium_allocation_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`apl_transaction` ADD CONSTRAINT `fk_billing_apl_transaction_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);

-- ========= billing --> workforce (13 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_schedule` ADD CONSTRAINT `fk_billing_premium_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_bill` ADD CONSTRAINT `fk_billing_premium_bill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_premium_payment` ADD CONSTRAINT `fk_billing_billing_premium_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`lapse_event` ADD CONSTRAINT `fk_billing_lapse_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_reinstatement` ADD CONSTRAINT `fk_billing_billing_reinstatement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`nsf_event` ADD CONSTRAINT `fk_billing_nsf_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`suspense_account` ADD CONSTRAINT `fk_billing_suspense_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`premium_adjustment` ADD CONSTRAINT `fk_billing_premium_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_billing_escalated_to_employee_id` FOREIGN KEY (`billing_escalated_to_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`refund_transaction` ADD CONSTRAINT `fk_billing_refund_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`billing`.`refund_transaction` ADD CONSTRAINT `fk_billing_refund_transaction_processed_by_user_employee_id` FOREIGN KEY (`processed_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= claims --> actuarial (4 constraint(s)) =========
-- Requires: claims schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);

-- ========= claims --> agent (4 constraint(s)) =========
-- Requires: claims schema, agent schema
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= claims --> annuity (5 constraint(s)) =========
-- Requires: claims schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= claims --> compliance (14 constraint(s)) =========
-- Requires: claims schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_erisa_plan_filing_id` FOREIGN KEY (`erisa_plan_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`erisa_plan_filing`(`erisa_plan_filing_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);

-- ========= claims --> document (1 constraint(s)) =========
-- Requires: claims schema, document schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ADD CONSTRAINT `fk_claims_claim_status_history_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= claims --> finance (4 constraint(s)) =========
-- Requires: claims schema, finance schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ADD CONSTRAINT `fk_claims_subrogation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= claims --> investment (4 constraint(s)) =========
-- Requires: claims schema, investment schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= claims --> policy (16 constraint(s)) =========
-- Requires: claims schema, policy schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_claim_policy_in_force_policy_id` FOREIGN KEY (`claim_policy_in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ADD CONSTRAINT `fk_claims_subrogation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ADD CONSTRAINT `fk_claims_interpleader_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= claims --> policyholder (7 constraint(s)) =========
-- Requires: claims schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_beneficiary_designation_id` FOREIGN KEY (`beneficiary_designation_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`beneficiary_designation`(`beneficiary_designation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ADD CONSTRAINT `fk_claims_interpleader_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= claims --> product (14 constraint(s)) =========
-- Requires: claims schema, product schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ADD CONSTRAINT `fk_claims_interpleader_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= claims --> reinsurance (4 constraint(s)) =========
-- Requires: claims schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ADD CONSTRAINT `fk_claims_claims_cession_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ADD CONSTRAINT `fk_claims_claims_cession_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);

-- ========= claims --> reporting (2 constraint(s)) =========
-- Requires: claims schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_report_line_definition_id` FOREIGN KEY (`report_line_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_line_definition`(`report_line_definition_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_report_line_definition_id` FOREIGN KEY (`report_line_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_line_definition`(`report_line_definition_id`);

-- ========= claims --> underwriting (5 constraint(s)) =========
-- Requires: claims schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= claims --> vendor (5 constraint(s)) =========
-- Requires: claims schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= claims --> workforce (21 constraint(s)) =========
-- Requires: claims schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ADD CONSTRAINT `fk_claims_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_fnol_employee_id` FOREIGN KEY (`fnol_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_adjudication_supervisor_employee_id` FOREIGN KEY (`adjudication_supervisor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_staff_license_id` FOREIGN KEY (`staff_license_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_license`(`staff_license_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ADD CONSTRAINT `fk_claims_claim_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_staff_license_id` FOREIGN KEY (`staff_license_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_license`(`staff_license_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ADD CONSTRAINT `fk_claims_subrogation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_staff_license_id` FOREIGN KEY (`staff_license_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_license`(`staff_license_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_tertiary_contestability_medical_director_employee_id` FOREIGN KEY (`tertiary_contestability_medical_director_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ADD CONSTRAINT `fk_claims_investigation_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ADD CONSTRAINT `fk_claims_interpleader_team_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= commission --> actuarial (5 constraint(s)) =========
-- Requires: commission schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_cash_flow_projection_id` FOREIGN KEY (`cash_flow_projection_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cash_flow_projection`(`cash_flow_projection_id`);

-- ========= commission --> agent (25 constraint(s)) =========
-- Requires: commission schema, agent schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_primary_commission_producer_id` FOREIGN KEY (`primary_commission_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_tertiary_commission_co_agent_producer_id` FOREIGN KEY (`tertiary_commission_co_agent_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_hierarchy_node_id` FOREIGN KEY (`hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_payment` ADD CONSTRAINT `fk_commission_bonus_payment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_adjustment_producer_id` FOREIGN KEY (`adjustment_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `life_insurance_ecm`.`agent`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`split_commission` ADD CONSTRAINT `fk_commission_split_commission_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_contracting_id` FOREIGN KEY (`contracting_id`) REFERENCES `life_insurance_ecm`.`agent`.`contracting`(`contracting_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= commission --> annuity (11 constraint(s)) =========
-- Requires: commission schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`split_commission` ADD CONSTRAINT `fk_commission_split_commission_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= commission --> billing (10 constraint(s)) =========
-- Requires: commission schema, billing schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `life_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);

-- ========= commission --> claims (1 constraint(s)) =========
-- Requires: commission schema, claims schema
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= commission --> compliance (12 constraint(s)) =========
-- Requires: commission schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hierarchy_override_rule` ADD CONSTRAINT `fk_commission_hierarchy_override_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule_regulatory_compliance` ADD CONSTRAINT `fk_commission_schedule_regulatory_compliance_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= commission --> correspondence (11 constraint(s)) =========
-- Requires: commission schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_payment` ADD CONSTRAINT `fk_commission_bonus_payment_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);

-- ========= commission --> document (5 constraint(s)) =========
-- Requires: commission schema, document schema
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`statement` ADD CONSTRAINT `fk_commission_statement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= commission --> finance (11 constraint(s)) =========
-- Requires: commission schema, finance schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_payment` ADD CONSTRAINT `fk_commission_bonus_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_dac_asset_id` FOREIGN KEY (`dac_asset_id`) REFERENCES `life_insurance_ecm`.`finance`.`dac_asset`(`dac_asset_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= commission --> investment (2 constraint(s)) =========
-- Requires: commission schema, investment schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= commission --> policy (11 constraint(s)) =========
-- Requires: commission schema, policy schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`split_commission` ADD CONSTRAINT `fk_commission_split_commission_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= commission --> product (23 constraint(s)) =========
-- Requires: commission schema, product schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback_rule` ADD CONSTRAINT `fk_commission_chargeback_rule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`override_commission` ADD CONSTRAINT `fk_commission_override_commission_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_qualification` ADD CONSTRAINT `fk_commission_bonus_qualification_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_dispute` ADD CONSTRAINT `fk_commission_commission_dispute_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hierarchy_override_rule` ADD CONSTRAINT `fk_commission_hierarchy_override_rule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hold` ADD CONSTRAINT `fk_commission_hold_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`split_commission` ADD CONSTRAINT `fk_commission_split_commission_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`service_fee` ADD CONSTRAINT `fk_commission_service_fee_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule_product_rate` ADD CONSTRAINT `fk_commission_schedule_product_rate_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= commission --> reinsurance (5 constraint(s)) =========
-- Requires: commission schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_transaction` ADD CONSTRAINT `fk_commission_commission_transaction_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`persistency_credit` ADD CONSTRAINT `fk_commission_persistency_credit_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`advance_commission` ADD CONSTRAINT `fk_commission_advance_commission_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);

-- ========= commission --> reporting (5 constraint(s)) =========
-- Requires: commission schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`chargeback` ADD CONSTRAINT `fk_commission_chargeback_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_payment` ADD CONSTRAINT `fk_commission_bonus_payment_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);

-- ========= commission --> vendor (3 constraint(s)) =========
-- Requires: commission schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`commission_payment` ADD CONSTRAINT `fk_commission_commission_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= commission --> workforce (10 constraint(s)) =========
-- Requires: commission schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule` ADD CONSTRAINT `fk_commission_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`rate` ADD CONSTRAINT `fk_commission_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`bonus_program` ADD CONSTRAINT `fk_commission_bonus_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`adjustment` ADD CONSTRAINT `fk_commission_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`tax_report` ADD CONSTRAINT `fk_commission_tax_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`run` ADD CONSTRAINT `fk_commission_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`payee` ADD CONSTRAINT `fk_commission_payee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`hierarchy_override_rule` ADD CONSTRAINT `fk_commission_hierarchy_override_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`compensation_contract` ADD CONSTRAINT `fk_commission_compensation_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`commission`.`schedule_regulatory_compliance` ADD CONSTRAINT `fk_commission_schedule_regulatory_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> agent (8 constraint(s)) =========
-- Requires: compliance schema, agent schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);

-- ========= compliance --> billing (1 constraint(s)) =========
-- Requires: compliance schema, billing schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `life_insurance_ecm`.`billing`.`transaction`(`transaction_id`);

-- ========= compliance --> commission (7 constraint(s)) =========
-- Requires: compliance schema, commission schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_bonus_program_id` FOREIGN KEY (`bonus_program_id`) REFERENCES `life_insurance_ecm`.`commission`.`bonus_program`(`bonus_program_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`training_course` ADD CONSTRAINT `fk_compliance_training_course_bonus_program_id` FOREIGN KEY (`bonus_program_id`) REFERENCES `life_insurance_ecm`.`commission`.`bonus_program`(`bonus_program_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);

-- ========= compliance --> correspondence (13 constraint(s)) =========
-- Requires: compliance schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`course_communication` ADD CONSTRAINT `fk_compliance_course_communication_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);

-- ========= compliance --> document (17 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`erisa_plan_filing` ADD CONSTRAINT `fk_compliance_erisa_plan_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= compliance --> finance (38 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_tax_provision_id` FOREIGN KEY (`tax_provision_id`) REFERENCES `life_insurance_ecm`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`training_course` ADD CONSTRAINT `fk_compliance_training_course_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_ifrs17_contract_group_id` FOREIGN KEY (`ifrs17_contract_group_id`) REFERENCES `life_insurance_ecm`.`finance`.`ifrs17_contract_group`(`ifrs17_contract_group_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_embedded_value_id` FOREIGN KEY (`embedded_value_id`) REFERENCES `life_insurance_ecm`.`finance`.`embedded_value`(`embedded_value_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`erisa_plan_filing` ADD CONSTRAINT `fk_compliance_erisa_plan_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`erisa_plan_filing` ADD CONSTRAINT `fk_compliance_erisa_plan_filing_tax_provision_id` FOREIGN KEY (`tax_provision_id`) REFERENCES `life_insurance_ecm`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`jurisdiction_license` ADD CONSTRAINT `fk_compliance_jurisdiction_license_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`entity_license` ADD CONSTRAINT `fk_compliance_entity_license_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> investment (16 constraint(s)) =========
-- Requires: compliance schema, investment schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `life_insurance_ecm`.`investment`.`guideline`(`guideline_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_compliance_breach_id` FOREIGN KEY (`compliance_breach_id`) REFERENCES `life_insurance_ecm`.`investment`.`compliance_breach`(`compliance_breach_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_investment_transaction_id` FOREIGN KEY (`investment_transaction_id`) REFERENCES `life_insurance_ecm`.`investment`.`investment_transaction`(`investment_transaction_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`training_course` ADD CONSTRAINT `fk_compliance_training_course_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `life_insurance_ecm`.`investment`.`guideline`(`guideline_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `life_insurance_ecm`.`investment`.`guideline`(`guideline_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);

-- ========= compliance --> policy (10 constraint(s)) =========
-- Requires: compliance schema, policy schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= compliance --> policyholder (6 constraint(s)) =========
-- Requires: compliance schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`erisa_plan_filing` ADD CONSTRAINT `fk_compliance_erisa_plan_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= compliance --> product (4 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= compliance --> reporting (16 constraint(s)) =========
-- Requires: compliance schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_report_run_id` FOREIGN KEY (`report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_report_run_id` FOREIGN KEY (`report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_report_control_id` FOREIGN KEY (`report_control_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_control`(`report_control_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_report_version_id` FOREIGN KEY (`report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`training_course` ADD CONSTRAINT `fk_compliance_training_course_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_report_version_id` FOREIGN KEY (`report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`erisa_plan_filing` ADD CONSTRAINT `fk_compliance_erisa_plan_filing_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_report_run_id` FOREIGN KEY (`report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);

-- ========= compliance --> underwriting (10 constraint(s)) =========
-- Requires: compliance schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_financial_uw_review_id` FOREIGN KEY (`financial_uw_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`financial_uw_review`(`financial_uw_review_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rule`(`rule_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_stoli_review_id` FOREIGN KEY (`stoli_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`stoli_review`(`stoli_review_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_mib_inquiry_id` FOREIGN KEY (`mib_inquiry_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`mib_inquiry`(`mib_inquiry_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_paramedical_exam_id` FOREIGN KEY (`paramedical_exam_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`paramedical_exam`(`paramedical_exam_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_aps_record_id` FOREIGN KEY (`aps_record_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`aps_record`(`aps_record_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= compliance --> vendor (16 constraint(s)) =========
-- Requires: compliance schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`market_conduct_exam` ADD CONSTRAINT `fk_compliance_market_conduct_exam_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`training_course` ADD CONSTRAINT `fk_compliance_training_course_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`policy_form_approval` ADD CONSTRAINT `fk_compliance_policy_form_approval_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`rate_filing` ADD CONSTRAINT `fk_compliance_rate_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`orsa_report` ADD CONSTRAINT `fk_compliance_orsa_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`erisa_plan_filing` ADD CONSTRAINT `fk_compliance_erisa_plan_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`contract_regulatory_compliance` ADD CONSTRAINT `fk_compliance_contract_regulatory_compliance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);

-- ========= compliance --> workforce (23 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_primary_regulatory_employee_id` FOREIGN KEY (`primary_regulatory_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`remediation_plan` ADD CONSTRAINT `fk_compliance_remediation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`suitability_review` ADD CONSTRAINT `fk_compliance_suitability_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_attestation_remediation_owner_employee_id` FOREIGN KEY (`attestation_remediation_owner_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`training_course` ADD CONSTRAINT `fk_compliance_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`exception` ADD CONSTRAINT `fk_compliance_exception_exception_employee_id` FOREIGN KEY (`exception_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`issue` ADD CONSTRAINT `fk_compliance_issue_issue_executive_sponsor_employee_id` FOREIGN KEY (`issue_executive_sponsor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_primary_sar_employee_id` FOREIGN KEY (`primary_sar_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_qa_reviewer_user_employee_id` FOREIGN KEY (`qa_reviewer_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= correspondence --> actuarial (5 constraint(s)) =========
-- Requires: correspondence schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);

-- ========= correspondence --> agent (8 constraint(s)) =========
-- Requires: correspondence schema, agent schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ADD CONSTRAINT `fk_correspondence_comm_preference_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= correspondence --> annuity (7 constraint(s)) =========
-- Requires: correspondence schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= correspondence --> billing (1 constraint(s)) =========
-- Requires: correspondence schema, billing schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);

-- ========= correspondence --> claims (10 constraint(s)) =========
-- Requires: correspondence schema, claims schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= correspondence --> compliance (7 constraint(s)) =========
-- Requires: correspondence schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_market_conduct_exam_id` FOREIGN KEY (`market_conduct_exam_id`) REFERENCES `life_insurance_ecm`.`compliance`.`market_conduct_exam`(`market_conduct_exam_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= correspondence --> document (8 constraint(s)) =========
-- Requires: correspondence schema, document schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= correspondence --> investment (5 constraint(s)) =========
-- Requires: correspondence schema, investment schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= correspondence --> policy (22 constraint(s)) =========
-- Requires: correspondence schema, policy schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ADD CONSTRAINT `fk_correspondence_queue_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `life_insurance_ecm`.`policy`.`assignment`(`assignment_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ADD CONSTRAINT `fk_correspondence_returned_mail_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ADD CONSTRAINT `fk_correspondence_address_search_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ADD CONSTRAINT `fk_correspondence_comm_preference_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ADD CONSTRAINT `fk_correspondence_suppression_list_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= correspondence --> policyholder (29 constraint(s)) =========
-- Requires: correspondence schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_policyholder_beneficiary_id` FOREIGN KEY (`policyholder_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary`(`policyholder_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_policyholder_beneficiary_id` FOREIGN KEY (`policyholder_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary`(`policyholder_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ADD CONSTRAINT `fk_correspondence_returned_mail_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ADD CONSTRAINT `fk_correspondence_address_search_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ADD CONSTRAINT `fk_correspondence_comm_preference_party_address_id` FOREIGN KEY (`party_address_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party_address`(`party_address_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ADD CONSTRAINT `fk_correspondence_comm_preference_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ADD CONSTRAINT `fk_correspondence_suppression_list_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= correspondence --> product (9 constraint(s)) =========
-- Requires: correspondence schema, product schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= correspondence --> reporting (5 constraint(s)) =========
-- Requires: correspondence schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_rbc_filing_id` FOREIGN KEY (`rbc_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`rbc_filing`(`rbc_filing_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);

-- ========= correspondence --> underwriting (2 constraint(s)) =========
-- Requires: correspondence schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= correspondence --> vendor (8 constraint(s)) =========
-- Requires: correspondence schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contact`(`contact_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ADD CONSTRAINT `fk_correspondence_template_translation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ADD CONSTRAINT `fk_correspondence_queue_vendor_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contact`(`contact_id`);

-- ========= correspondence --> workforce (34 constraint(s)) =========
-- Requires: correspondence schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ADD CONSTRAINT `fk_correspondence_comm_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ADD CONSTRAINT `fk_correspondence_comm_template_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ADD CONSTRAINT `fk_correspondence_comm_template_version_quaternary_comm_approved_by_user_employee_id` FOREIGN KEY (`quaternary_comm_approved_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ADD CONSTRAINT `fk_correspondence_comm_template_version_tertiary_comm_modified_by_user_employee_id` FOREIGN KEY (`tertiary_comm_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_primary_complaint_employee_id` FOREIGN KEY (`primary_complaint_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_tertiary_complaint_modified_by_user_employee_id` FOREIGN KEY (`tertiary_complaint_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ADD CONSTRAINT `fk_correspondence_queue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ADD CONSTRAINT `fk_correspondence_queue_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ADD CONSTRAINT `fk_correspondence_returned_mail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ADD CONSTRAINT `fk_correspondence_address_search_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_tertiary_secure_compliance_reviewer_employee_id` FOREIGN KEY (`tertiary_secure_compliance_reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_escalation_escalated_by_user_employee_id` FOREIGN KEY (`escalation_escalated_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ADD CONSTRAINT `fk_correspondence_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_tertiary_doi_approved_by_user_employee_id` FOREIGN KEY (`tertiary_doi_approved_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ADD CONSTRAINT `fk_correspondence_bulk_comm_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ADD CONSTRAINT `fk_correspondence_comm_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ADD CONSTRAINT `fk_correspondence_suppression_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_tertiary_comm_exception_approval_user_employee_id` FOREIGN KEY (`tertiary_comm_exception_approval_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_team_id` FOREIGN KEY (`team_id`) REFERENCES `life_insurance_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_escalated_to_employee_id` FOREIGN KEY (`escalated_to_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_team_id` FOREIGN KEY (`team_id`) REFERENCES `life_insurance_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= document --> agent (7 constraint(s)) =========
-- Requires: document schema, agent schema
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= document --> annuity (4 constraint(s)) =========
-- Requires: document schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= document --> billing (2 constraint(s)) =========
-- Requires: document schema, billing schema
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);

-- ========= document --> claims (12 constraint(s)) =========
-- Requires: document schema, claims schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_claimant_id` FOREIGN KEY (`claimant_id`) REFERENCES `life_insurance_ecm`.`claims`.`claimant`(`claimant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_claim_investigation_id` FOREIGN KEY (`claim_investigation_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_investigation`(`claim_investigation_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_contestability_review_id` FOREIGN KEY (`contestability_review_id`) REFERENCES `life_insurance_ecm`.`claims`.`contestability_review`(`contestability_review_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `life_insurance_ecm`.`claims`.`appeal`(`appeal_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_claim_investigation_id` FOREIGN KEY (`claim_investigation_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_investigation`(`claim_investigation_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_claim_investigation_id` FOREIGN KEY (`claim_investigation_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_investigation`(`claim_investigation_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= document --> correspondence (1 constraint(s)) =========
-- Requires: document schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);

-- ========= document --> investment (2 constraint(s)) =========
-- Requires: document schema, investment schema
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= document --> policy (8 constraint(s)) =========
-- Requires: document schema, policy schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= document --> policyholder (23 constraint(s)) =========
-- Requires: document schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_group_member_id` FOREIGN KEY (`group_member_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_member`(`group_member_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_policyholder_beneficiary_id` FOREIGN KEY (`policyholder_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary`(`policyholder_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_consent` ADD CONSTRAINT `fk_document_delivery_consent_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`delivery_event` ADD CONSTRAINT `fk_document_delivery_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_group_member_id` FOREIGN KEY (`group_member_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_member`(`group_member_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_group_member_id` FOREIGN KEY (`group_member_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_member`(`group_member_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_policyholder_beneficiary_id` FOREIGN KEY (`policyholder_beneficiary_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary`(`policyholder_beneficiary_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= document --> reporting (3 constraint(s)) =========
-- Requires: document schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_close_task_id` FOREIGN KEY (`close_task_id`) REFERENCES `life_insurance_ecm`.`reporting`.`close_task`(`close_task_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);

-- ========= document --> underwriting (7 constraint(s)) =========
-- Requires: document schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_underwriting_workbench_case_application_id` FOREIGN KEY (`underwriting_workbench_case_application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_evidence_requirement_id` FOREIGN KEY (`evidence_requirement_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_requirement`(`evidence_requirement_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= document --> vendor (6 constraint(s)) =========
-- Requires: document schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`document`.`document` ADD CONSTRAINT `fk_document_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `life_insurance_ecm`.`vendor`.`incident`(`incident_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= document --> workforce (14 constraint(s)) =========
-- Requires: document schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_package_employee_id` FOREIGN KEY (`package_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`package` ADD CONSTRAINT `fk_document_package_package_updated_by_user_employee_id` FOREIGN KEY (`package_updated_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`nigo_record` ADD CONSTRAINT `fk_document_nigo_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_employee_id` FOREIGN KEY (`workflow_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_operator_employee_id` FOREIGN KEY (`workflow_operator_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_quality_control_reviewer_employee_id` FOREIGN KEY (`workflow_quality_control_reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_updated_by_user_employee_id` FOREIGN KEY (`workflow_updated_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`document`.`correspondence_link` ADD CONSTRAINT `fk_document_correspondence_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> actuarial (11 constraint(s)) =========
-- Requires: finance schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);

-- ========= finance --> agent (2 constraint(s)) =========
-- Requires: finance schema, agent schema
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);

-- ========= finance --> claims (4 constraint(s)) =========
-- Requires: finance schema, claims schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= finance --> correspondence (3 constraint(s)) =========
-- Requires: finance schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);

-- ========= finance --> document (10 constraint(s)) =========
-- Requires: finance schema, document schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= finance --> investment (1 constraint(s)) =========
-- Requires: finance schema, investment schema
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_investment_transaction_id` FOREIGN KEY (`investment_transaction_id`) REFERENCES `life_insurance_ecm`.`investment`.`investment_transaction`(`investment_transaction_id`);

-- ========= finance --> policy (8 constraint(s)) =========
-- Requires: finance schema, policy schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= finance --> product (11 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_product_line_id` FOREIGN KEY (`product_line_id`) REFERENCES `life_insurance_ecm`.`product`.`product_line`(`product_line_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_asset` ADD CONSTRAINT `fk_finance_dac_asset_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`dac_amortization` ADD CONSTRAINT `fk_finance_dac_amortization_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_contract_group` ADD CONSTRAINT `fk_finance_ifrs17_contract_group_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_product_line_id` FOREIGN KEY (`product_line_id`) REFERENCES `life_insurance_ecm`.`product`.`product_line`(`product_line_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= finance --> reinsurance (4 constraint(s)) =========
-- Requires: finance schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`reinsurance_recoverable` ADD CONSTRAINT `fk_finance_reinsurance_recoverable_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);

-- ========= finance --> reporting (9 constraint(s)) =========
-- Requires: finance schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`gaap_reserve` ADD CONSTRAINT `fk_finance_gaap_reserve_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`ifrs17_measurement` ADD CONSTRAINT `fk_finance_ifrs17_measurement_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);

-- ========= finance --> vendor (4 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `life_insurance_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`entity_vendor_contract` ADD CONSTRAINT `fk_finance_entity_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center_vendor_engagement` ADD CONSTRAINT `fk_finance_cost_center_vendor_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= finance --> workforce (12 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_tertiary_journal_modified_by_user_employee_id` FOREIGN KEY (`tertiary_journal_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`statutory_reserve` ADD CONSTRAINT `fk_finance_statutory_reserve_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`rbc_calculation` ADD CONSTRAINT `fk_finance_rbc_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`budget_variance` ADD CONSTRAINT `fk_finance_budget_variance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`finance`.`embedded_value` ADD CONSTRAINT `fk_finance_embedded_value_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= investment --> actuarial (9 constraint(s)) =========
-- Requires: investment schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_liability_segment_id` FOREIGN KEY (`liability_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`liability_segment`(`liability_segment_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ADD CONSTRAINT `fk_investment_valuation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ADD CONSTRAINT `fk_investment_alm_gap_measurement_stochastic_scenario_id` FOREIGN KEY (`stochastic_scenario_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`stochastic_scenario`(`stochastic_scenario_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ADD CONSTRAINT `fk_investment_credit_default_rate_stochastic_scenario_id` FOREIGN KEY (`stochastic_scenario_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`stochastic_scenario`(`stochastic_scenario_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_stochastic_scenario_id` FOREIGN KEY (`stochastic_scenario_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`stochastic_scenario`(`stochastic_scenario_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ADD CONSTRAINT `fk_investment_derivative_valuation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ADD CONSTRAINT `fk_investment_portfolio_segment_liability_segment_id` FOREIGN KEY (`liability_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`liability_segment`(`liability_segment_id`);

-- ========= investment --> agent (2 constraint(s)) =========
-- Requires: investment schema, agent schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= investment --> commission (1 constraint(s)) =========
-- Requires: investment schema, commission schema
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ADD CONSTRAINT `fk_investment_performance_attribution_run_id` FOREIGN KEY (`run_id`) REFERENCES `life_insurance_ecm`.`commission`.`run`(`run_id`);

-- ========= investment --> compliance (8 constraint(s)) =========
-- Requires: investment schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_rate_filing_id` FOREIGN KEY (`rate_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`rate_filing`(`rate_filing_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_orsa_report_id` FOREIGN KEY (`orsa_report_id`) REFERENCES `life_insurance_ecm`.`compliance`.`orsa_report`(`orsa_report_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ADD CONSTRAINT `fk_investment_performance_attribution_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_orsa_report_id` FOREIGN KEY (`orsa_report_id`) REFERENCES `life_insurance_ecm`.`compliance`.`orsa_report`(`orsa_report_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ADD CONSTRAINT `fk_investment_guideline_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ADD CONSTRAINT `fk_investment_guideline_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= investment --> finance (12 constraint(s)) =========
-- Requires: investment schema, finance schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ADD CONSTRAINT `fk_investment_mortgage_loan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ADD CONSTRAINT `fk_investment_alternative_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ADD CONSTRAINT `fk_investment_counterparty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ADD CONSTRAINT `fk_investment_impairment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= investment --> policyholder (3 constraint(s)) =========
-- Requires: investment schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_group_sponsor_id` FOREIGN KEY (`group_sponsor_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`group_sponsor`(`group_sponsor_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_contract_owner_id` FOREIGN KEY (`contract_owner_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`contract_owner`(`contract_owner_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ADD CONSTRAINT `fk_investment_unit_value_annuitant_id` FOREIGN KEY (`annuitant_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`annuitant`(`annuitant_id`);

-- ========= investment --> product (9 constraint(s)) =========
-- Requires: investment schema, product schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= investment --> reporting (11 constraint(s)) =========
-- Requires: investment schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_statutory_exhibit_id` FOREIGN KEY (`statutory_exhibit_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_exhibit`(`statutory_exhibit_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ADD CONSTRAINT `fk_investment_security_report_line_definition_id` FOREIGN KEY (`report_line_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_line_definition`(`report_line_definition_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_report_exception_id` FOREIGN KEY (`report_exception_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_exception`(`report_exception_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_report_line_definition_id` FOREIGN KEY (`report_line_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_line_definition`(`report_line_definition_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ADD CONSTRAINT `fk_investment_alm_gap_measurement_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_report_exception_id` FOREIGN KEY (`report_exception_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_exception`(`report_exception_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ADD CONSTRAINT `fk_investment_performance_attribution_management_report_config_id` FOREIGN KEY (`management_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`management_report_config`(`management_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_rbc_filing_id` FOREIGN KEY (`rbc_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`rbc_filing`(`rbc_filing_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ADD CONSTRAINT `fk_investment_mortgage_loan_statutory_exhibit_id` FOREIGN KEY (`statutory_exhibit_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_exhibit`(`statutory_exhibit_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ADD CONSTRAINT `fk_investment_alternative_asset_statutory_exhibit_id` FOREIGN KEY (`statutory_exhibit_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_exhibit`(`statutory_exhibit_id`);

-- ========= investment --> vendor (5 constraint(s)) =========
-- Requires: investment schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ADD CONSTRAINT `fk_investment_separate_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ADD CONSTRAINT `fk_investment_mortgage_loan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ADD CONSTRAINT `fk_investment_counterparty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ADD CONSTRAINT `fk_investment_portfolio_segment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= investment --> workforce (21 constraint(s)) =========
-- Requires: investment schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ADD CONSTRAINT `fk_investment_trade_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ADD CONSTRAINT `fk_investment_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ADD CONSTRAINT `fk_investment_unit_value_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ADD CONSTRAINT `fk_investment_credit_default_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ADD CONSTRAINT `fk_investment_mortgage_loan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ADD CONSTRAINT `fk_investment_alternative_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ADD CONSTRAINT `fk_investment_derivative_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ADD CONSTRAINT `fk_investment_guideline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ADD CONSTRAINT `fk_investment_asset_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ADD CONSTRAINT `fk_investment_counterparty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ADD CONSTRAINT `fk_investment_securities_lending_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ADD CONSTRAINT `fk_investment_impairment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ADD CONSTRAINT `fk_investment_portfolio_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ADD CONSTRAINT `fk_investment_portfolio_segment_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= policy --> actuarial (5 constraint(s)) =========
-- Requires: policy schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);

-- ========= policy --> agent (11 constraint(s)) =========
-- Requires: policy schema, agent schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ADD CONSTRAINT `fk_policy_assignment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ADD CONSTRAINT `fk_policy_note_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ADD CONSTRAINT `fk_policy_nonforfeiture_option_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_conversion_producer_id` FOREIGN KEY (`conversion_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ADD CONSTRAINT `fk_policy_free_look_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= policy --> annuity (2 constraint(s)) =========
-- Requires: policy schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= policy --> billing (5 constraint(s)) =========
-- Requires: policy schema, billing schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ADD CONSTRAINT `fk_policy_nonforfeiture_option_lapse_event_id` FOREIGN KEY (`lapse_event_id`) REFERENCES `life_insurance_ecm`.`billing`.`lapse_event`(`lapse_event_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ADD CONSTRAINT `fk_policy_free_look_refund_transaction_id` FOREIGN KEY (`refund_transaction_id`) REFERENCES `life_insurance_ecm`.`billing`.`refund_transaction`(`refund_transaction_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ADD CONSTRAINT `fk_policy_incontestability_billing_reinstatement_id` FOREIGN KEY (`billing_reinstatement_id`) REFERENCES `life_insurance_ecm`.`billing`.`billing_reinstatement`(`billing_reinstatement_id`);

-- ========= policy --> commission (1 constraint(s)) =========
-- Requires: policy schema, commission schema
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_run_id` FOREIGN KEY (`run_id`) REFERENCES `life_insurance_ecm`.`commission`.`run`(`run_id`);

-- ========= policy --> compliance (2 constraint(s)) =========
-- Requires: policy schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ADD CONSTRAINT `fk_policy_note_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);

-- ========= policy --> document (3 constraint(s)) =========
-- Requires: policy schema, document schema
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ADD CONSTRAINT `fk_policy_assignment_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ADD CONSTRAINT `fk_policy_note_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ADD CONSTRAINT `fk_policy_free_look_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= policy --> investment (9 constraint(s)) =========
-- Requires: policy schema, investment schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `life_insurance_ecm`.`investment`.`valuation`(`valuation_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ADD CONSTRAINT `fk_policy_policy_rider_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ADD CONSTRAINT `fk_policy_guaranteed_benefit_allocation_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= policy --> policyholder (5 constraint(s)) =========
-- Requires: policy schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_owner_party_id` FOREIGN KEY (`owner_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_owner_poa_party_id` FOREIGN KEY (`owner_poa_party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_ownership_transfer_id` FOREIGN KEY (`ownership_transfer_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`ownership_transfer`(`ownership_transfer_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_party_address_id` FOREIGN KEY (`party_address_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party_address`(`party_address_id`);

-- ========= policy --> product (4 constraint(s)) =========
-- Requires: policy schema, product schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_product_plan_id` FOREIGN KEY (`product_plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ADD CONSTRAINT `fk_policy_policy_rider_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);

-- ========= policy --> reinsurance (1 constraint(s)) =========
-- Requires: policy schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ADD CONSTRAINT `fk_policy_policy_rider_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);

-- ========= policy --> vendor (3 constraint(s)) =========
-- Requires: policy schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ADD CONSTRAINT `fk_policy_in_force_policy_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= policy --> workforce (16 constraint(s)) =========
-- Requires: policy schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ADD CONSTRAINT `fk_policy_policy_rider_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ADD CONSTRAINT `fk_policy_policy_beneficiary_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ADD CONSTRAINT `fk_policy_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ADD CONSTRAINT `fk_policy_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ADD CONSTRAINT `fk_policy_nonforfeiture_option_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ADD CONSTRAINT `fk_policy_free_look_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= policyholder --> agent (1 constraint(s)) =========
-- Requires: policyholder schema, agent schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`consent_record` ADD CONSTRAINT `fk_policyholder_consent_record_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= policyholder --> annuity (6 constraint(s)) =========
-- Requires: policyholder schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`consent_record` ADD CONSTRAINT `fk_policyholder_consent_record_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`power_of_attorney` ADD CONSTRAINT `fk_policyholder_power_of_attorney_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= policyholder --> claims (1 constraint(s)) =========
-- Requires: policyholder schema, claims schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= policyholder --> compliance (11 constraint(s)) =========
-- Requires: policyholder schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_suitability_review_id` FOREIGN KEY (`suitability_review_id`) REFERENCES `life_insurance_ecm`.`compliance`.`suitability_review`(`suitability_review_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_remediation_plan_id` FOREIGN KEY (`remediation_plan_id`) REFERENCES `life_insurance_ecm`.`compliance`.`remediation_plan`(`remediation_plan_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`relationship` ADD CONSTRAINT `fk_policyholder_relationship_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`consent_record` ADD CONSTRAINT `fk_policyholder_consent_record_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`power_of_attorney` ADD CONSTRAINT `fk_policyholder_power_of_attorney_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `life_insurance_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_training_completion` ADD CONSTRAINT `fk_policyholder_policyholder_training_completion_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_training_completion` ADD CONSTRAINT `fk_policyholder_policyholder_training_completion_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `life_insurance_ecm`.`compliance`.`training_course`(`training_course_id`);

-- ========= policyholder --> document (2 constraint(s)) =========
-- Requires: policyholder schema, document schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`consent_record` ADD CONSTRAINT `fk_policyholder_consent_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= policyholder --> policy (9 constraint(s)) =========
-- Requires: policyholder schema, policy schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured` ADD CONSTRAINT `fk_policyholder_insured_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`group_member` ADD CONSTRAINT `fk_policyholder_group_member_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`consent_record` ADD CONSTRAINT `fk_policyholder_consent_record_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`power_of_attorney` ADD CONSTRAINT `fk_policyholder_power_of_attorney_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= policyholder --> underwriting (10 constraint(s)) =========
-- Requires: policyholder schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`contract_owner` ADD CONSTRAINT `fk_policyholder_contract_owner_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`annuitant` ADD CONSTRAINT `fk_policyholder_annuitant_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`policyholder_beneficiary` ADD CONSTRAINT `fk_policyholder_policyholder_beneficiary_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`group_member` ADD CONSTRAINT `fk_policyholder_group_member_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`consent_record` ADD CONSTRAINT `fk_policyholder_consent_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`trust` ADD CONSTRAINT `fk_policyholder_trust_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`power_of_attorney` ADD CONSTRAINT `fk_policyholder_power_of_attorney_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`insured_risk_assessment` ADD CONSTRAINT `fk_policyholder_insured_risk_assessment_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);

-- ========= policyholder --> workforce (4 constraint(s)) =========
-- Requires: policyholder schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`policyholder`.`kyc_verification` ADD CONSTRAINT `fk_policyholder_kyc_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`beneficiary_designation` ADD CONSTRAINT `fk_policyholder_beneficiary_designation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`ownership_transfer` ADD CONSTRAINT `fk_policyholder_ownership_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`policyholder`.`death_verification` ADD CONSTRAINT `fk_policyholder_death_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> actuarial (1 constraint(s)) =========
-- Requires: product schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`product`.`illustration_assumption` ADD CONSTRAINT `fk_product_illustration_assumption_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);

-- ========= product --> compliance (3 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_obligation_compliance` ADD CONSTRAINT `fk_product_plan_obligation_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= product --> correspondence (2 constraint(s)) =========
-- Requires: product schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);

-- ========= product --> document (4 constraint(s)) =========
-- Requires: product schema, document schema
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`illustration_assumption` ADD CONSTRAINT `fk_product_illustration_assumption_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_template_assignment` ADD CONSTRAINT `fk_product_plan_template_assignment_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);

-- ========= product --> finance (9 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ADD CONSTRAINT `fk_product_plan_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ADD CONSTRAINT `fk_product_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ADD CONSTRAINT `fk_product_plan_version_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ADD CONSTRAINT `fk_product_benefit_structure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ADD CONSTRAINT `fk_product_rider_definition_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ADD CONSTRAINT `fk_product_crediting_strategy_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= product --> vendor (6 constraint(s)) =========
-- Requires: product schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ADD CONSTRAINT `fk_product_rider_definition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`illustration_assumption` ADD CONSTRAINT `fk_product_illustration_assumption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`vendor_service` ADD CONSTRAINT `fk_product_vendor_service_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= product --> workforce (21 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ADD CONSTRAINT `fk_product_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ADD CONSTRAINT `fk_product_plan_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ADD CONSTRAINT `fk_product_benefit_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ADD CONSTRAINT `fk_product_rider_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ADD CONSTRAINT `fk_product_premium_rate_table_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ADD CONSTRAINT `fk_product_coi_rate_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ADD CONSTRAINT `fk_product_underwriting_class_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_filing_employee_id` FOREIGN KEY (`filing_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ADD CONSTRAINT `fk_product_crediting_strategy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ADD CONSTRAINT `fk_product_charge_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`illustration_assumption` ADD CONSTRAINT `fk_product_illustration_assumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`retirement` ADD CONSTRAINT `fk_product_retirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`profitability_assumption` ADD CONSTRAINT `fk_product_profitability_assumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`expense_charge` ADD CONSTRAINT `fk_product_expense_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ADD CONSTRAINT `fk_product_suitability_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`di_benefit_definition` ADD CONSTRAINT `fk_product_di_benefit_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`tax_qualification` ADD CONSTRAINT `fk_product_tax_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reinsurance --> actuarial (14 constraint(s)) =========
-- Requires: reinsurance schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`inforce_cession_snapshot` ADD CONSTRAINT `fk_reinsurance_inforce_cession_snapshot_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_reserve_calculation_id` FOREIGN KEY (`reserve_calculation_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`reserve_calculation`(`reserve_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`experience_refund` ADD CONSTRAINT `fk_reinsurance_experience_refund_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_credit_assumption` ADD CONSTRAINT `fk_reinsurance_reinsurer_credit_assumption_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_experience_analysis` ADD CONSTRAINT `fk_reinsurance_treaty_experience_analysis_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);

-- ========= reinsurance --> billing (5 constraint(s)) =========
-- Requires: reinsurance schema, billing schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_grace_period_id` FOREIGN KEY (`grace_period_id`) REFERENCES `life_insurance_ecm`.`billing`.`grace_period`(`grace_period_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_premium_bill_id` FOREIGN KEY (`premium_bill_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_bill`(`premium_bill_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);

-- ========= reinsurance --> claims (3 constraint(s)) =========
-- Requires: reinsurance schema, claims schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);

-- ========= reinsurance --> compliance (14 constraint(s)) =========
-- Requires: reinsurance schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_jurisdiction_license_id` FOREIGN KEY (`jurisdiction_license_id`) REFERENCES `life_insurance_ecm`.`compliance`.`jurisdiction_license`(`jurisdiction_license_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retrocession_treaty` ADD CONSTRAINT `fk_reinsurance_retrocession_treaty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`experience_refund` ADD CONSTRAINT `fk_reinsurance_experience_refund_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_market_conduct_exam_id` FOREIGN KEY (`market_conduct_exam_id`) REFERENCES `life_insurance_ecm`.`compliance`.`market_conduct_exam`(`market_conduct_exam_id`);

-- ========= reinsurance --> correspondence (2 constraint(s)) =========
-- Requires: reinsurance schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);

-- ========= reinsurance --> document (6 constraint(s)) =========
-- Requires: reinsurance schema, document schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`experience_refund` ADD CONSTRAINT `fk_reinsurance_experience_refund_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`dispute_evidence` ADD CONSTRAINT `fk_reinsurance_dispute_evidence_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= reinsurance --> finance (11 constraint(s)) =========
-- Requires: reinsurance schema, finance schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retrocession_treaty` ADD CONSTRAINT `fk_reinsurance_retrocession_treaty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`experience_refund` ADD CONSTRAINT `fk_reinsurance_experience_refund_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`coinsurance_fund_withheld` ADD CONSTRAINT `fk_reinsurance_coinsurance_fund_withheld_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= reinsurance --> investment (5 constraint(s)) =========
-- Requires: reinsurance schema, investment schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`coinsurance_fund_withheld` ADD CONSTRAINT `fk_reinsurance_coinsurance_fund_withheld_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= reinsurance --> policy (8 constraint(s)) =========
-- Requires: reinsurance schema, policy schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`inforce_cession_snapshot` ADD CONSTRAINT `fk_reinsurance_inforce_cession_snapshot_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= reinsurance --> policyholder (3 constraint(s)) =========
-- Requires: reinsurance schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);

-- ========= reinsurance --> product (10 constraint(s)) =========
-- Requires: reinsurance schema, product schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`treaty_schedule` ADD CONSTRAINT `fk_reinsurance_treaty_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_cession` ADD CONSTRAINT `fk_reinsurance_reinsurance_cession_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`premium` ADD CONSTRAINT `fk_reinsurance_premium_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux_line` ADD CONSTRAINT `fk_reinsurance_bordereaux_line_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`inforce_cession_snapshot` ADD CONSTRAINT `fk_reinsurance_inforce_cession_snapshot_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`retention_limit` ADD CONSTRAINT `fk_reinsurance_retention_limit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= reinsurance --> reporting (5 constraint(s)) =========
-- Requires: reinsurance schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`claim_recoverable` ADD CONSTRAINT `fk_reinsurance_claim_recoverable_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reserve` ADD CONSTRAINT `fk_reinsurance_reserve_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);

-- ========= reinsurance --> vendor (7 constraint(s)) =========
-- Requires: reinsurance schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`nar_calculation` ADD CONSTRAINT `fk_reinsurance_nar_calculation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`inforce_cession_snapshot` ADD CONSTRAINT `fk_reinsurance_inforce_cession_snapshot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_contact` ADD CONSTRAINT `fk_reinsurance_reinsurer_contact_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contact`(`contact_id`);

-- ========= reinsurance --> workforce (12 constraint(s)) =========
-- Requires: reinsurance schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty` ADD CONSTRAINT `fk_reinsurance_reinsurance_treaty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer` ADD CONSTRAINT `fk_reinsurance_reinsurer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`facultative_submission` ADD CONSTRAINT `fk_reinsurance_facultative_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`bordereaux` ADD CONSTRAINT `fk_reinsurance_bordereaux_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`recapture_event` ADD CONSTRAINT `fk_reinsurance_recapture_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_settlement` ADD CONSTRAINT `fk_reinsurance_reinsurer_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`experience_refund` ADD CONSTRAINT `fk_reinsurance_experience_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`automatic_binding_limit` ADD CONSTRAINT `fk_reinsurance_automatic_binding_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurance_dispute` ADD CONSTRAINT `fk_reinsurance_reinsurance_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`reinsurer_credit_assumption` ADD CONSTRAINT `fk_reinsurance_reinsurer_credit_assumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`dispute_evidence` ADD CONSTRAINT `fk_reinsurance_dispute_evidence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reinsurance`.`dispute_evidence` ADD CONSTRAINT `fk_reinsurance_dispute_evidence_reviewed_by_user_employee_id` FOREIGN KEY (`reviewed_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reporting --> actuarial (6 constraint(s)) =========
-- Requires: reporting schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ADD CONSTRAINT `fk_reporting_ifrs17_report_config_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ADD CONSTRAINT `fk_reporting_statutory_exhibit_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);

-- ========= reporting --> agent (11 constraint(s)) =========
-- Requires: reporting schema, agent schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `life_insurance_ecm`.`agent`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_production_activity_id` FOREIGN KEY (`production_activity_id`) REFERENCES `life_insurance_ecm`.`agent`.`production_activity`(`production_activity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `life_insurance_ecm`.`agent`.`appointment`(`appointment_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ADD CONSTRAINT `fk_reporting_report_recipient_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ADD CONSTRAINT `fk_reporting_report_recipient_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ADD CONSTRAINT `fk_reporting_management_report_config_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);

-- ========= reporting --> annuity (8 constraint(s)) =========
-- Requires: reporting schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ADD CONSTRAINT `fk_reporting_statutory_exhibit_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_account_value_id` FOREIGN KEY (`account_value_id`) REFERENCES `life_insurance_ecm`.`annuity`.`account_value`(`account_value_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_account_value_id` FOREIGN KEY (`account_value_id`) REFERENCES `life_insurance_ecm`.`annuity`.`account_value`(`account_value_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= reporting --> compliance (2 constraint(s)) =========
-- Requires: reporting schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);

-- ========= reporting --> document (2 constraint(s)) =========
-- Requires: reporting schema, document schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ADD CONSTRAINT `fk_reporting_report_package_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ADD CONSTRAINT `fk_reporting_management_report_config_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `life_insurance_ecm`.`document`.`workflow`(`workflow_id`);

-- ========= reporting --> finance (11 constraint(s)) =========
-- Requires: reporting schema, finance schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ADD CONSTRAINT `fk_reporting_gaap_report_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ADD CONSTRAINT `fk_reporting_ifrs17_report_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ADD CONSTRAINT `fk_reporting_management_report_config_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ADD CONSTRAINT `fk_reporting_management_report_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_rbc_calculation_id` FOREIGN KEY (`rbc_calculation_id`) REFERENCES `life_insurance_ecm`.`finance`.`rbc_calculation`(`rbc_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= reporting --> policy (4 constraint(s)) =========
-- Requires: reporting schema, policy schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= reporting --> policyholder (1 constraint(s)) =========
-- Requires: reporting schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ADD CONSTRAINT `fk_reporting_report_recipient_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= reporting --> product (9 constraint(s)) =========
-- Requires: reporting schema, product schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ADD CONSTRAINT `fk_reporting_statutory_exhibit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_separate_account_fund_id` FOREIGN KEY (`separate_account_fund_id`) REFERENCES `life_insurance_ecm`.`product`.`separate_account_fund`(`separate_account_fund_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ADD CONSTRAINT `fk_reporting_management_report_config_product_line_id` FOREIGN KEY (`product_line_id`) REFERENCES `life_insurance_ecm`.`product`.`product_line`(`product_line_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ADD CONSTRAINT `fk_reporting_segment_definition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= reporting --> reinsurance (1 constraint(s)) =========
-- Requires: reporting schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ADD CONSTRAINT `fk_reporting_statutory_exhibit_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);

-- ========= reporting --> underwriting (1 constraint(s)) =========
-- Requires: reporting schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rule`(`rule_id`);

-- ========= reporting --> vendor (1 constraint(s)) =========
-- Requires: reporting schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ADD CONSTRAINT `fk_reporting_statutory_exhibit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);

-- ========= reporting --> workforce (16 constraint(s)) =========
-- Requires: reporting schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ADD CONSTRAINT `fk_reporting_report_schedule_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `life_insurance_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ADD CONSTRAINT `fk_reporting_report_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ADD CONSTRAINT `fk_reporting_report_schedule_tertiary_report_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_report_last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ADD CONSTRAINT `fk_reporting_report_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ADD CONSTRAINT `fk_reporting_report_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_primary_report_employee_id` FOREIGN KEY (`primary_report_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_reviewer_user_employee_id` FOREIGN KEY (`reviewer_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ADD CONSTRAINT `fk_reporting_report_access_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ADD CONSTRAINT `fk_reporting_report_access_policy_primary_report_employee_id` FOREIGN KEY (`primary_report_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ADD CONSTRAINT `fk_reporting_report_access_policy_tertiary_report_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_report_last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= underwriting --> actuarial (6 constraint(s)) =========
-- Requires: underwriting schema, actuarial schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ADD CONSTRAINT `fk_underwriting_underwriting_risk_assessment_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ADD CONSTRAINT `fk_underwriting_impairment_guide_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);

-- ========= underwriting --> agent (7 constraint(s)) =========
-- Requires: underwriting schema, agent schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);

-- ========= underwriting --> billing (4 constraint(s)) =========
-- Requires: underwriting schema, billing schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_account_id` FOREIGN KEY (`account_id`) REFERENCES `life_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_premium_schedule_id` FOREIGN KEY (`premium_schedule_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_schedule`(`premium_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_premium_adjustment_id` FOREIGN KEY (`premium_adjustment_id`) REFERENCES `life_insurance_ecm`.`billing`.`premium_adjustment`(`premium_adjustment_id`);

-- ========= underwriting --> commission (2 constraint(s)) =========
-- Requires: underwriting schema, commission schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_compensation_contract_id` FOREIGN KEY (`compensation_contract_id`) REFERENCES `life_insurance_ecm`.`commission`.`compensation_contract`(`compensation_contract_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `life_insurance_ecm`.`commission`.`schedule`(`schedule_id`);

-- ========= underwriting --> compliance (7 constraint(s)) =========
-- Requires: underwriting schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ADD CONSTRAINT `fk_underwriting_risk_class_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ADD CONSTRAINT `fk_underwriting_impairment_guide_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ADD CONSTRAINT `fk_underwriting_program_policy_form_approval_id` FOREIGN KEY (`policy_form_approval_id`) REFERENCES `life_insurance_ecm`.`compliance`.`policy_form_approval`(`policy_form_approval_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ADD CONSTRAINT `fk_underwriting_program_state_regulation_id` FOREIGN KEY (`state_regulation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`state_regulation`(`state_regulation_id`);

-- ========= underwriting --> correspondence (7 constraint(s)) =========
-- Requires: underwriting schema, correspondence schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ADD CONSTRAINT `fk_underwriting_underwriting_risk_assessment_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);

-- ========= underwriting --> document (13 constraint(s)) =========
-- Requires: underwriting schema, document schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ADD CONSTRAINT `fk_underwriting_application_document_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);

-- ========= underwriting --> finance (5 constraint(s)) =========
-- Requires: underwriting schema, finance schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ADD CONSTRAINT `fk_underwriting_underwriting_risk_assessment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_reinsurance_recoverable_id` FOREIGN KEY (`reinsurance_recoverable_id`) REFERENCES `life_insurance_ecm`.`finance`.`reinsurance_recoverable`(`reinsurance_recoverable_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `life_insurance_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= underwriting --> investment (4 constraint(s)) =========
-- Requires: underwriting schema, investment schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);

-- ========= underwriting --> policy (9 constraint(s)) =========
-- Requires: underwriting schema, policy schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);

-- ========= underwriting --> policyholder (5 constraint(s)) =========
-- Requires: underwriting schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ADD CONSTRAINT `fk_underwriting_application_party_role_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= underwriting --> product (4 constraint(s)) =========
-- Requires: underwriting schema, product schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= underwriting --> reinsurance (9 constraint(s)) =========
-- Requires: underwriting schema, reinsurance schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_facultative_submission_id` FOREIGN KEY (`facultative_submission_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`facultative_submission`(`facultative_submission_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_reinsurance_treaty_id` FOREIGN KEY (`reinsurance_treaty_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`(`reinsurance_treaty_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_reinsurer_id` FOREIGN KEY (`reinsurer_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurer`(`reinsurer_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_reinsurance_cession_id` FOREIGN KEY (`reinsurance_cession_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`reinsurance_cession`(`reinsurance_cession_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ADD CONSTRAINT `fk_underwriting_treaty_risk_pricing_treaty_schedule_id` FOREIGN KEY (`treaty_schedule_id`) REFERENCES `life_insurance_ecm`.`reinsurance`.`treaty_schedule`(`treaty_schedule_id`);

-- ========= underwriting --> reporting (8 constraint(s)) =========
-- Requires: underwriting schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);

-- ========= underwriting --> vendor (9 constraint(s)) =========
-- Requires: underwriting schema, vendor schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_exam_vendor_order_id` FOREIGN KEY (`exam_vendor_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`exam_vendor_order`(`exam_vendor_order_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);

-- ========= underwriting --> workforce (18 constraint(s)) =========
-- Requires: underwriting schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ADD CONSTRAINT `fk_underwriting_underwriting_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_decision_supervisory_approver_employee_id` FOREIGN KEY (`decision_supervisory_approver_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ADD CONSTRAINT `fk_underwriting_uw_authority_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ADD CONSTRAINT `fk_underwriting_application_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_peer_reviewer_employee_id` FOREIGN KEY (`peer_reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= vendor --> annuity (1 constraint(s)) =========
-- Requires: vendor schema, annuity schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_annuity_contract_id` FOREIGN KEY (`annuity_contract_id`) REFERENCES `life_insurance_ecm`.`annuity`.`annuity_contract`(`annuity_contract_id`);

-- ========= vendor --> compliance (10 constraint(s)) =========
-- Requires: vendor schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_market_conduct_exam_id` FOREIGN KEY (`market_conduct_exam_id`) REFERENCES `life_insurance_ecm`.`compliance`.`market_conduct_exam`(`market_conduct_exam_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ADD CONSTRAINT `fk_vendor_vendor_risk_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ADD CONSTRAINT `fk_vendor_risk_finding_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `life_insurance_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ADD CONSTRAINT `fk_vendor_baa_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ADD CONSTRAINT `fk_vendor_tpa_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `life_insurance_ecm`.`compliance`.`issue`(`issue_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `life_insurance_ecm`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ADD CONSTRAINT `fk_vendor_policy_compliance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ADD CONSTRAINT `fk_vendor_policy_compliance_policy_compliance_policy_id` FOREIGN KEY (`policy_compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= vendor --> finance (6 constraint(s)) =========
-- Requires: vendor schema, finance schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `life_insurance_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= vendor --> policyholder (4 constraint(s)) =========
-- Requires: vendor schema, policyholder schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_insured_id` FOREIGN KEY (`insured_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`insured`(`insured_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `life_insurance_ecm`.`policyholder`.`party`(`party_id`);

-- ========= vendor --> reporting (9 constraint(s)) =========
-- Requires: vendor schema, reporting schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ADD CONSTRAINT `fk_vendor_vendor_payment_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ADD CONSTRAINT `fk_vendor_sla_measurement_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ADD CONSTRAINT `fk_vendor_vendor_risk_assessment_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ADD CONSTRAINT `fk_vendor_custodian_account_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);

-- ========= vendor --> underwriting (2 constraint(s)) =========
-- Requires: vendor schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);

-- ========= vendor --> workforce (28 constraint(s)) =========
-- Requires: vendor schema, workforce schema
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ADD CONSTRAINT `fk_vendor_vendor_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ADD CONSTRAINT `fk_vendor_sla_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ADD CONSTRAINT `fk_vendor_sla_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ADD CONSTRAINT `fk_vendor_vendor_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ADD CONSTRAINT `fk_vendor_risk_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ADD CONSTRAINT `fk_vendor_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ADD CONSTRAINT `fk_vendor_baa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ADD CONSTRAINT `fk_vendor_tpa_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ADD CONSTRAINT `fk_vendor_custodian_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_onboarding_requestor_employee_id` FOREIGN KEY (`onboarding_requestor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ADD CONSTRAINT `fk_vendor_insurance_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ADD CONSTRAINT `fk_vendor_insurance_cert_tertiary_insurance_updated_by_user_employee_id` FOREIGN KEY (`tertiary_insurance_updated_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_quaternary_contract_employee_id` FOREIGN KEY (`quaternary_contract_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_quinary_contract_updated_by_user_employee_id` FOREIGN KEY (`quinary_contract_updated_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_tertiary_contract_rejected_by_employee_id` FOREIGN KEY (`tertiary_contract_rejected_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ADD CONSTRAINT `fk_vendor_preferred_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> commission (1 constraint(s)) =========
-- Requires: workforce schema, commission schema
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_run_id` FOREIGN KEY (`run_id`) REFERENCES `life_insurance_ecm`.`commission`.`run`(`run_id`);

-- ========= workforce --> compliance (5 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ADD CONSTRAINT `fk_workforce_staff_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ADD CONSTRAINT `fk_workforce_staff_training_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `life_insurance_ecm`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `life_insurance_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `life_insurance_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= workforce --> document (3 constraint(s)) =========
-- Requires: workforce schema, document schema
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `life_insurance_ecm`.`document`.`document`(`document_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_template_id` FOREIGN KEY (`template_id`) REFERENCES `life_insurance_ecm`.`document`.`template`(`template_id`);

-- ========= workforce --> finance (3 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `life_insurance_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `life_insurance_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= workforce --> product (4 constraint(s)) =========
-- Requires: workforce schema, product schema
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ADD CONSTRAINT `fk_workforce_employee_skill_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);

-- ========= workforce --> underwriting (1 constraint(s)) =========
-- Requires: workforce schema, underwriting schema
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_uw_authority_id` FOREIGN KEY (`uw_authority_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`uw_authority`(`uw_authority_id`);

