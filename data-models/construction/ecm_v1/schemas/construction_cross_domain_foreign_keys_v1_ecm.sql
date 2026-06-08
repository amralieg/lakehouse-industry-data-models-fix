-- Cross-Domain Foreign Keys for Business: Construction | Version: v1_ecm
-- Generated on: 2026-05-07 06:58:32
-- Total cross-domain FK constraints: 1290
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: bid, client, compliance, contract, design, equipment, finance, hr, material, procurement, project, quality, safety, schedule, site, subcontractor, sustainability, workforce

-- ========= bid --> client (6 constraint(s)) =========
-- Requires: bid schema, client schema
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_prequalification` ADD CONSTRAINT `fk_bid_bid_prequalification_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= bid --> compliance (5 constraint(s)) =========
-- Requires: bid schema, compliance schema
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_risk` ADD CONSTRAINT `fk_bid_bid_risk_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_prequalification` ADD CONSTRAINT `fk_bid_bid_prequalification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);

-- ========= bid --> contract (5 constraint(s)) =========
-- Requires: bid schema, contract schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`bid`.`insurance_certificate` ADD CONSTRAINT `fk_bid_insurance_certificate_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`bid`.`performance_scorecard` ADD CONSTRAINT `fk_bid_performance_scorecard_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);

-- ========= bid --> design (5 constraint(s)) =========
-- Requires: bid schema, design schema
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_design_submittal_id` FOREIGN KEY (`design_submittal_id`) REFERENCES `construction_ecm`.`design`.`design_submittal`(`design_submittal_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);

-- ========= bid --> equipment (1 constraint(s)) =========
-- Requires: bid schema, equipment schema
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= bid --> finance (11 constraint(s)) =========
-- Requires: bid schema, finance schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`bid`.`contract_agreement` ADD CONSTRAINT `fk_bid_contract_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`bid`.`payment_application` ADD CONSTRAINT `fk_bid_payment_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`payment_application` ADD CONSTRAINT `fk_bid_payment_application_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`bid`.`payment_application` ADD CONSTRAINT `fk_bid_payment_application_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= bid --> hr (18 constraint(s)) =========
-- Requires: bid schema, hr schema
ALTER TABLE `construction_ecm`.`bid`.`subcontractor_prequalification` ADD CONSTRAINT `fk_bid_subcontractor_prequalification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`contract_agreement` ADD CONSTRAINT `fk_bid_contract_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`payment_application` ADD CONSTRAINT `fk_bid_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`insurance_certificate` ADD CONSTRAINT `fk_bid_insurance_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`performance_scorecard` ADD CONSTRAINT `fk_bid_performance_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_risk` ADD CONSTRAINT `fk_bid_bid_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_risk` ADD CONSTRAINT `fk_bid_bid_risk_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_risk` ADD CONSTRAINT `fk_bid_bid_risk_primary_bid_employee_id` FOREIGN KEY (`primary_bid_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_prequalification` ADD CONSTRAINT `fk_bid_bid_prequalification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_team_assignment` ADD CONSTRAINT `fk_bid_bid_team_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= bid --> material (1 constraint(s)) =========
-- Requires: bid schema, material schema
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= bid --> procurement (2 constraint(s)) =========
-- Requires: bid schema, procurement schema
ALTER TABLE `construction_ecm`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`bid`.`vendor_quote` ADD CONSTRAINT `fk_bid_vendor_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= bid --> project (19 constraint(s)) =========
-- Requires: bid schema, project schema
ALTER TABLE `construction_ecm`.`bid`.`subcontractor_prequalification` ADD CONSTRAINT `fk_bid_subcontractor_prequalification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`bid`.`contract_agreement` ADD CONSTRAINT `fk_bid_contract_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`payment_application` ADD CONSTRAINT `fk_bid_payment_application_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`insurance_certificate` ADD CONSTRAINT `fk_bid_insurance_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`performance_scorecard` ADD CONSTRAINT `fk_bid_performance_scorecard_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`subcontractor_bond` ADD CONSTRAINT `fk_bid_subcontractor_bond_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_risk` ADD CONSTRAINT `fk_bid_bid_risk_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_prequalification` ADD CONSTRAINT `fk_bid_bid_prequalification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= bid --> quality (2 constraint(s)) =========
-- Requires: bid schema, quality schema
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_quality_plan_id` FOREIGN KEY (`quality_plan_id`) REFERENCES `construction_ecm`.`quality`.`quality_plan`(`quality_plan_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);

-- ========= bid --> schedule (2 constraint(s)) =========
-- Requires: bid schema, schedule schema
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `construction_ecm`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);

-- ========= bid --> sustainability (14 constraint(s)) =========
-- Requires: bid schema, sustainability schema
ALTER TABLE `construction_ecm`.`bid`.`firm_profile` ADD CONSTRAINT `fk_bid_firm_profile_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `construction_ecm`.`sustainability`.`green_certification`(`green_certification_id`);
ALTER TABLE `construction_ecm`.`bid`.`contract_agreement` ADD CONSTRAINT `fk_bid_contract_agreement_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `construction_ecm`.`bid`.`performance_scorecard` ADD CONSTRAINT `fk_bid_performance_scorecard_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_embodied_carbon_assessment_id` FOREIGN KEY (`embodied_carbon_assessment_id`) REFERENCES `construction_ecm`.`sustainability`.`embodied_carbon_assessment`(`embodied_carbon_assessment_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`bid`.`win_loss_record` ADD CONSTRAINT `fk_bid_win_loss_record_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `construction_ecm`.`bid`.`vendor_quote` ADD CONSTRAINT `fk_bid_vendor_quote_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_risk` ADD CONSTRAINT `fk_bid_bid_risk_climate_risk_assessment_id` FOREIGN KEY (`climate_risk_assessment_id`) REFERENCES `construction_ecm`.`sustainability`.`climate_risk_assessment`(`climate_risk_assessment_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_prequalification` ADD CONSTRAINT `fk_bid_bid_prequalification_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);

-- ========= bid --> workforce (2 constraint(s)) =========
-- Requires: bid schema, workforce schema
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);

-- ========= client --> bid (1 constraint(s)) =========
-- Requires: client schema, bid schema
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ADD CONSTRAINT `fk_client_client_opportunity_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);

-- ========= client --> contract (2 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= client --> hr (10 constraint(s)) =========
-- Requires: client schema, hr schema
ALTER TABLE `construction_ecm`.`client`.`account` ADD CONSTRAINT `fk_client_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ADD CONSTRAINT `fk_client_client_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`client_prequalification` ADD CONSTRAINT `fk_client_client_prequalification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ADD CONSTRAINT `fk_client_account_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`client_framework_agreement` ADD CONSTRAINT `fk_client_client_framework_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`client`.`survey` ADD CONSTRAINT `fk_client_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= client --> project (4 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`client`.`survey` ADD CONSTRAINT `fk_client_survey_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= compliance --> bid (8 constraint(s)) =========
-- Requires: compliance schema, bid schema
ALTER TABLE `construction_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`waiver_exemption` ADD CONSTRAINT `fk_compliance_waiver_exemption_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= compliance --> client (3 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `construction_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= compliance --> contract (4 constraint(s)) =========
-- Requires: compliance schema, contract schema
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`compliance`.`waiver_exemption` ADD CONSTRAINT `fk_compliance_waiver_exemption_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= compliance --> design (3 constraint(s)) =========
-- Requires: compliance schema, design schema
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= compliance --> finance (6 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);

-- ========= compliance --> hr (20 constraint(s)) =========
-- Requires: compliance schema, hr schema
ALTER TABLE `construction_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `construction_ecm`.`hr`.`applicant`(`applicant_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`leed_certification` ADD CONSTRAINT `fk_compliance_leed_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`leed_credit` ADD CONSTRAINT `fk_compliance_leed_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `construction_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `construction_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`pci_assessment` ADD CONSTRAINT `fk_compliance_pci_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `construction_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`iso_certification` ADD CONSTRAINT `fk_compliance_iso_certification_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `construction_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= compliance --> procurement (3 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `construction_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= compliance --> project (20 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `construction_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`leed_certification` ADD CONSTRAINT `fk_compliance_leed_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`leed_credit` ADD CONSTRAINT `fk_compliance_leed_credit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`pci_control` ADD CONSTRAINT `fk_compliance_pci_control_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`pci_assessment` ADD CONSTRAINT `fk_compliance_pci_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`iso_certification` ADD CONSTRAINT `fk_compliance_iso_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`waiver_exemption` ADD CONSTRAINT `fk_compliance_waiver_exemption_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= compliance --> safety (1 constraint(s)) =========
-- Requires: compliance schema, safety schema
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);

-- ========= compliance --> schedule (1 constraint(s)) =========
-- Requires: compliance schema, schedule schema
ALTER TABLE `construction_ecm`.`compliance`.`compliance_action` ADD CONSTRAINT `fk_compliance_compliance_action_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= compliance --> site (1 constraint(s)) =========
-- Requires: compliance schema, site schema
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);

-- ========= contract --> bid (8 constraint(s)) =========
-- Requires: contract schema, bid schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_scope` ADD CONSTRAINT `fk_contract_contract_scope_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_payment_application_id` FOREIGN KEY (`payment_application_id`) REFERENCES `construction_ecm`.`bid`.`payment_application`(`payment_application_id`);

-- ========= contract --> client (3 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= contract --> compliance (5 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);

-- ========= contract --> design (3 constraint(s)) =========
-- Requires: contract schema, design schema
ALTER TABLE `construction_ecm`.`contract`.`contract_scope` ADD CONSTRAINT `fk_contract_contract_scope_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= contract --> hr (11 constraint(s)) =========
-- Requires: contract schema, hr schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_tertiary_contract_claim_updated_by_user_employee_id` FOREIGN KEY (`tertiary_contract_claim_updated_by_user_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_retention_ledger` ADD CONSTRAINT `fk_contract_contract_retention_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`dlp_register` ADD CONSTRAINT `fk_contract_dlp_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= contract --> material (2 constraint(s)) =========
-- Requires: contract schema, material schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_approved_material_list_id` FOREIGN KEY (`approved_material_list_id`) REFERENCES `construction_ecm`.`material`.`approved_material_list`(`approved_material_list_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= contract --> procurement (6 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`advance_payment` ADD CONSTRAINT `fk_contract_advance_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= contract --> project (7 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_scope` ADD CONSTRAINT `fk_contract_contract_scope_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`dispute` ADD CONSTRAINT `fk_contract_dispute_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= contract --> quality (1 constraint(s)) =========
-- Requires: contract schema, quality schema
ALTER TABLE `construction_ecm`.`contract`.`contract_eot_claim` ADD CONSTRAINT `fk_contract_contract_eot_claim_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= contract --> schedule (1 constraint(s)) =========
-- Requires: contract schema, schedule schema
ALTER TABLE `construction_ecm`.`contract`.`change_order_activity_impact` ADD CONSTRAINT `fk_contract_change_order_activity_impact_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= contract --> site (3 constraint(s)) =========
-- Requires: contract schema, site schema
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);

-- ========= contract --> sustainability (3 constraint(s)) =========
-- Requires: contract schema, sustainability schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `construction_ecm`.`sustainability`.`green_certification`(`green_certification_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_waste_target_id` FOREIGN KEY (`waste_target_id`) REFERENCES `construction_ecm`.`sustainability`.`waste_target`(`waste_target_id`);

-- ========= design --> bid (6 constraint(s)) =========
-- Requires: design schema, bid schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `construction_ecm`.`bid`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_contract_agreement_id` FOREIGN KEY (`contract_agreement_id`) REFERENCES `construction_ecm`.`bid`.`contract_agreement`(`contract_agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= design --> client (6 constraint(s)) =========
-- Requires: design schema, client schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= design --> compliance (4 constraint(s)) =========
-- Requires: design schema, compliance schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= design --> contract (24 constraint(s)) =========
-- Requires: design schema, contract schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal_item` ADD CONSTRAINT `fk_design_transmittal_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`distribution_matrix` ADD CONSTRAINT `fk_design_distribution_matrix_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`mep_coordination_zone` ADD CONSTRAINT `fk_design_mep_coordination_zone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= design --> equipment (6 constraint(s)) =========
-- Requires: design schema, equipment schema
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`equipment_installation` ADD CONSTRAINT `fk_design_equipment_installation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_equipment_assignment` ADD CONSTRAINT `fk_design_interface_equipment_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`change_impact` ADD CONSTRAINT `fk_design_change_impact_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`zone_equipment_allocation` ADD CONSTRAINT `fk_design_zone_equipment_allocation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= design --> finance (5 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

-- ========= design --> hr (32 constraint(s)) =========
-- Requires: design schema, hr schema
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_revision_employee_id` FOREIGN KEY (`revision_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_quaternary_workflow_initiated_by_employee_id` FOREIGN KEY (`quaternary_workflow_initiated_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_tertiary_workflow_escalated_to_employee_id` FOREIGN KEY (`tertiary_workflow_escalated_to_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_primary_correspondence_employee_id` FOREIGN KEY (`primary_correspondence_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_primary_access_employee_id` FOREIGN KEY (`primary_access_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_quaternary_access_revoked_by_user_employee_id` FOREIGN KEY (`quaternary_access_revoked_by_user_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_quinary_access_created_by_user_employee_id` FOREIGN KEY (`quinary_access_created_by_user_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_tertiary_access_approved_by_user_employee_id` FOREIGN KEY (`tertiary_access_approved_by_user_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_primary_drawing_employee_id` FOREIGN KEY (`primary_drawing_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`mep_coordination_zone` ADD CONSTRAINT `fk_design_mep_coordination_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_primary_calculation_employee_id` FOREIGN KEY (`primary_calculation_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= design --> material (8 constraint(s)) =========
-- Requires: design schema, material schema
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= design --> project (29 constraint(s)) =========
-- Requires: design schema, project schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence_response` ADD CONSTRAINT `fk_design_correspondence_response_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`distribution_matrix` ADD CONSTRAINT `fk_design_distribution_matrix_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`access_permission` ADD CONSTRAINT `fk_design_access_permission_team_member_id` FOREIGN KEY (`team_member_id`) REFERENCES `construction_ecm`.`project`.`team_member`(`team_member_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`design_submittal` ADD CONSTRAINT `fk_design_design_submittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`clash_detection_run` ADD CONSTRAINT `fk_design_clash_detection_run_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`mep_coordination_zone` ADD CONSTRAINT `fk_design_mep_coordination_zone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`value_engineering_proposal` ADD CONSTRAINT `fk_design_value_engineering_proposal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`design_scope` ADD CONSTRAINT `fk_design_design_scope_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= design --> safety (1 constraint(s)) =========
-- Requires: design schema, safety schema
ALTER TABLE `construction_ecm`.`design`.`drawing_incident_link` ADD CONSTRAINT `fk_design_drawing_incident_link_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);

-- ========= design --> schedule (1 constraint(s)) =========
-- Requires: design schema, schedule schema
ALTER TABLE `construction_ecm`.`design`.`drawing_requirement` ADD CONSTRAINT `fk_design_drawing_requirement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= design --> sustainability (2 constraint(s)) =========
-- Requires: design schema, sustainability schema
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `construction_ecm`.`design`.`calculation_register` ADD CONSTRAINT `fk_design_calculation_register_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `construction_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);

-- ========= design --> workforce (5 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`interface_point` ADD CONSTRAINT `fk_design_interface_point_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= equipment --> bid (5 constraint(s)) =========
-- Requires: equipment schema, bid schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= equipment --> compliance (5 constraint(s)) =========
-- Requires: equipment schema, compliance schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_compliance_calendar_id` FOREIGN KEY (`compliance_calendar_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_calendar`(`compliance_calendar_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= equipment --> contract (10 constraint(s)) =========
-- Requires: equipment schema, contract schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`insurance_policy` ADD CONSTRAINT `fk_equipment_insurance_policy_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= equipment --> design (1 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= equipment --> finance (8 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset_valuation` ADD CONSTRAINT `fk_equipment_asset_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset_valuation` ADD CONSTRAINT `fk_equipment_asset_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= equipment --> hr (13 constraint(s)) =========
-- Requires: equipment schema, hr schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_hours_employee_id` FOREIGN KEY (`hours_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_tertiary_maintenance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_maintenance_last_modified_by_user_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= equipment --> material (3 constraint(s)) =========
-- Requires: equipment schema, material schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= equipment --> procurement (4 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> project (16 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_current_location_site_construction_project_id` FOREIGN KEY (`current_location_site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= equipment --> schedule (1 constraint(s)) =========
-- Requires: equipment schema, schedule schema
ALTER TABLE `construction_ecm`.`equipment`.`asset_activity_assignment` ADD CONSTRAINT `fk_equipment_asset_activity_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= equipment --> site (4 constraint(s)) =========
-- Requires: equipment schema, site schema
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);

-- ========= equipment --> workforce (3 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= finance --> client (5 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `construction_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= finance --> compliance (3 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= finance --> contract (8 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= finance --> equipment (1 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= finance --> hr (9 constraint(s)) =========
-- Requires: finance schema, hr schema
ALTER TABLE `construction_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= finance --> procurement (7 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> project (31 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `construction_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `construction_ecm`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `construction_ecm`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_budget_revision` ADD CONSTRAINT `fk_finance_finance_budget_revision_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `construction_ecm`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `construction_ecm`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `construction_ecm`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`accounts_receivable_invoice` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`finance_retention_ledger` ADD CONSTRAINT `fk_finance_finance_retention_ledger_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`financial_guarantee` ADD CONSTRAINT `fk_finance_financial_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= finance --> schedule (2 constraint(s)) =========
-- Requires: finance schema, schedule schema
ALTER TABLE `construction_ecm`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`finance`.`commitment_item` ADD CONSTRAINT `fk_finance_commitment_item_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `construction_ecm`.`schedule`.`resource`(`resource_id`);

-- ========= finance --> sustainability (5 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `construction_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_waste_target_id` FOREIGN KEY (`waste_target_id`) REFERENCES `construction_ecm`.`sustainability`.`waste_target`(`waste_target_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_climate_risk_assessment_id` FOREIGN KEY (`climate_risk_assessment_id`) REFERENCES `construction_ecm`.`sustainability`.`climate_risk_assessment`(`climate_risk_assessment_id`);

-- ========= hr --> client (1 constraint(s)) =========
-- Requires: hr schema, client schema
ALTER TABLE `construction_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_address_id` FOREIGN KEY (`address_id`) REFERENCES `construction_ecm`.`client`.`address`(`address_id`);

-- ========= hr --> project (1 constraint(s)) =========
-- Requires: hr schema, project schema
ALTER TABLE `construction_ecm`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= material --> bid (7 constraint(s)) =========
-- Requires: material schema, bid schema
ALTER TABLE `construction_ecm`.`material`.`master` ADD CONSTRAINT `fk_material_master_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`material`.`conformance_certificate` ADD CONSTRAINT `fk_material_conformance_certificate_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);

-- ========= material --> client (6 constraint(s)) =========
-- Requires: material schema, client schema
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= material --> compliance (4 constraint(s)) =========
-- Requires: material schema, compliance schema
ALTER TABLE `construction_ecm`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= material --> contract (2 constraint(s)) =========
-- Requires: material schema, contract schema
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);

-- ========= material --> design (1 constraint(s)) =========
-- Requires: material schema, design schema
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);

-- ========= material --> equipment (1 constraint(s)) =========
-- Requires: material schema, equipment schema
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= material --> finance (6 constraint(s)) =========
-- Requires: material schema, finance schema
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= material --> hr (12 constraint(s)) =========
-- Requires: material schema, hr schema
ALTER TABLE `construction_ecm`.`material`.`master` ADD CONSTRAINT `fk_material_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`conformance_certificate` ADD CONSTRAINT `fk_material_conformance_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_requisition_employee_id` FOREIGN KEY (`requisition_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`approved_material_list` ADD CONSTRAINT `fk_material_approved_material_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_wastage_employee_id` FOREIGN KEY (`wastage_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= material --> procurement (5 constraint(s)) =========
-- Requires: material schema, procurement schema
ALTER TABLE `construction_ecm`.`material`.`master` ADD CONSTRAINT `fk_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= material --> project (12 constraint(s)) =========
-- Requires: material schema, project schema
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`project`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`conformance_certificate` ADD CONSTRAINT `fk_material_conformance_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`approved_material_list` ADD CONSTRAINT `fk_material_approved_material_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`project`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_source_site_id` FOREIGN KEY (`source_site_id`) REFERENCES `construction_ecm`.`project`.`site`(`site_id`);

-- ========= material --> schedule (3 constraint(s)) =========
-- Requires: material schema, schedule schema
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= material --> site (4 constraint(s)) =========
-- Requires: material schema, site schema
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`hazmat_register` ADD CONSTRAINT `fk_material_hazmat_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);

-- ========= material --> sustainability (1 constraint(s)) =========
-- Requires: material schema, sustainability schema
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);

-- ========= material --> workforce (3 constraint(s)) =========
-- Requires: material schema, workforce schema
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= procurement --> bid (9 constraint(s)) =========
-- Requires: procurement schema, bid schema
ALTER TABLE `construction_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`procurement_bid` ADD CONSTRAINT `fk_procurement_procurement_bid_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= procurement --> client (5 constraint(s)) =========
-- Requires: procurement schema, client schema
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= procurement --> contract (4 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= procurement --> design (6 constraint(s)) =========
-- Requires: procurement schema, design schema
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `construction_ecm`.`design`.`change_notice`(`change_notice_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= procurement --> equipment (4 constraint(s)) =========
-- Requires: procurement schema, equipment schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= procurement --> finance (5 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> hr (13 constraint(s)) =========
-- Requires: procurement schema, hr schema
ALTER TABLE `construction_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_primary_vendor_evaluator_employee_id` FOREIGN KEY (`primary_vendor_evaluator_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= procurement --> material (4 constraint(s)) =========
-- Requires: procurement schema, material schema
ALTER TABLE `construction_ecm`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= procurement --> project (13 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_amendment` ADD CONSTRAINT `fk_procurement_po_amendment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`procurement_framework_agreement` ADD CONSTRAINT `fk_procurement_procurement_framework_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_document` ADD CONSTRAINT `fk_procurement_vendor_document_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= procurement --> schedule (1 constraint(s)) =========
-- Requires: procurement schema, schedule schema
ALTER TABLE `construction_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= procurement --> site (1 constraint(s)) =========
-- Requires: procurement schema, site schema
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_site_location_id` FOREIGN KEY (`site_location_id`) REFERENCES `construction_ecm`.`site`.`site_location`(`site_location_id`);

-- ========= procurement --> sustainability (3 constraint(s)) =========
-- Requires: procurement schema, sustainability schema
ALTER TABLE `construction_ecm`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_embodied_carbon_assessment_id` FOREIGN KEY (`embodied_carbon_assessment_id`) REFERENCES `construction_ecm`.`sustainability`.`embodied_carbon_assessment`(`embodied_carbon_assessment_id`);

-- ========= procurement --> workforce (2 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);

-- ========= project --> bid (1 constraint(s)) =========
-- Requires: project schema, bid schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= project --> client (5 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= project --> compliance (1 constraint(s)) =========
-- Requires: project schema, compliance schema
ALTER TABLE `construction_ecm`.`project`.`regulatory_oversight` ADD CONSTRAINT `fk_project_regulatory_oversight_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);

-- ========= project --> contract (4 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= project --> design (1 constraint(s)) =========
-- Requires: project schema, design schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);

-- ========= project --> finance (1 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

-- ========= project --> hr (15 constraint(s)) =========
-- Requires: project schema, hr schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `construction_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `construction_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`project_budget_revision` ADD CONSTRAINT `fk_project_project_budget_revision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`commissioning_package` ADD CONSTRAINT `fk_project_commissioning_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`project`.`forecast` ADD CONSTRAINT `fk_project_forecast_forecast_prepared_by_user_employee_id` FOREIGN KEY (`forecast_prepared_by_user_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= project --> material (3 constraint(s)) =========
-- Requires: project schema, material schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= project --> procurement (1 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= project --> schedule (4 constraint(s)) =========
-- Requires: project schema, schedule schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> bid (13 constraint(s)) =========
-- Requires: quality schema, bid schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= quality --> client (5 constraint(s)) =========
-- Requires: quality schema, client schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= quality --> compliance (6 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= quality --> contract (14 constraint(s)) =========
-- Requires: quality schema, contract schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= quality --> design (16 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= quality --> equipment (6 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (7 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

-- ========= quality --> hr (11 constraint(s)) =========
-- Requires: quality schema, hr schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_quaternary_corrective_last_modified_by_employee_id` FOREIGN KEY (`quaternary_corrective_last_modified_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_tertiary_corrective_created_by_employee_id` FOREIGN KEY (`tertiary_corrective_created_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_tertiary_checklist_approved_by_employee_id` FOREIGN KEY (`tertiary_checklist_approved_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= quality --> procurement (4 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `construction_ecm`.`procurement`.`material_catalog`(`material_catalog_id`);

-- ========= quality --> project (36 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `construction_ecm`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`acceptance_test` ADD CONSTRAINT `fk_quality_acceptance_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_plan` ADD CONSTRAINT `fk_quality_quality_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_plan` ADD CONSTRAINT `fk_quality_quality_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_submittal` ADD CONSTRAINT `fk_quality_quality_submittal_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`ndt_record` ADD CONSTRAINT `fk_quality_ndt_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= quality --> safety (4 constraint(s)) =========
-- Requires: quality schema, safety schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= quality --> schedule (5 constraint(s)) =========
-- Requires: quality schema, schedule schema
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> site (1 constraint(s)) =========
-- Requires: quality schema, site schema
ALTER TABLE `construction_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_site_location_id` FOREIGN KEY (`site_location_id`) REFERENCES `construction_ecm`.`site`.`site_location`(`site_location_id`);

-- ========= quality --> sustainability (6 constraint(s)) =========
-- Requires: quality schema, sustainability schema
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `construction_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `construction_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `construction_ecm`.`quality`.`quality_plan` ADD CONSTRAINT `fk_quality_quality_plan_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);
ALTER TABLE `construction_ecm`.`quality`.`concrete_pour_record` ADD CONSTRAINT `fk_quality_concrete_pour_record_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);

-- ========= quality --> workforce (9 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`weld_record` ADD CONSTRAINT `fk_quality_weld_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);

-- ========= safety --> bid (14 constraint(s)) =========
-- Requires: safety schema, bid schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_subcontractor_involvement` ADD CONSTRAINT `fk_safety_incident_subcontractor_involvement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= safety --> client (6 constraint(s)) =========
-- Requires: safety schema, client schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= safety --> compliance (4 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= safety --> contract (10 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);

-- ========= safety --> design (3 constraint(s)) =========
-- Requires: safety schema, design schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_interface_point_id` FOREIGN KEY (`interface_point_id`) REFERENCES `construction_ecm`.`design`.`interface_point`(`interface_point_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_design_scope_id` FOREIGN KEY (`design_scope_id`) REFERENCES `construction_ecm`.`design`.`design_scope`(`design_scope_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_design_submittal_id` FOREIGN KEY (`design_submittal_id`) REFERENCES `construction_ecm`.`design`.`design_submittal`(`design_submittal_id`);

-- ========= safety --> equipment (6 constraint(s)) =========
-- Requires: safety schema, equipment schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= safety --> finance (9 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= safety --> hr (16 constraint(s)) =========
-- Requires: safety schema, hr schema
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_tertiary_incident_approved_by_employee_id` FOREIGN KEY (`tertiary_incident_approved_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_swms_employee_id` FOREIGN KEY (`swms_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_swms_prepared_by_employee_id` FOREIGN KEY (`swms_prepared_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= safety --> material (4 constraint(s)) =========
-- Requires: safety schema, material schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= safety --> procurement (3 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= safety --> project (18 constraint(s)) =========
-- Requires: safety schema, project schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= safety --> quality (1 constraint(s)) =========
-- Requires: safety schema, quality schema
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);

-- ========= safety --> schedule (1 constraint(s)) =========
-- Requires: safety schema, schedule schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= safety --> site (8 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site`(`site_id`);

-- ========= safety --> sustainability (1 constraint(s)) =========
-- Requires: safety schema, sustainability schema
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_sustainability_plan_id` FOREIGN KEY (`sustainability_plan_id`) REFERENCES `construction_ecm`.`sustainability`.`sustainability_plan`(`sustainability_plan_id`);

-- ========= safety --> workforce (6 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= schedule --> bid (4 constraint(s)) =========
-- Requires: schedule schema, bid schema
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_eot_claim` ADD CONSTRAINT `fk_schedule_schedule_eot_claim_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= schedule --> client (1 constraint(s)) =========
-- Requires: schedule schema, client schema
ALTER TABLE `construction_ecm`.`schedule`.`schedule_eot_claim` ADD CONSTRAINT `fk_schedule_schedule_eot_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= schedule --> compliance (4 constraint(s)) =========
-- Requires: schedule schema, compliance schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= schedule --> contract (5 constraint(s)) =========
-- Requires: schedule schema, contract schema
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);

-- ========= schedule --> design (5 constraint(s)) =========
-- Requires: schedule schema, design schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `construction_ecm`.`design`.`change_notice`(`change_notice_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_design_submittal_id` FOREIGN KEY (`design_submittal_id`) REFERENCES `construction_ecm`.`design`.`design_submittal`(`design_submittal_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_interface_point_id` FOREIGN KEY (`interface_point_id`) REFERENCES `construction_ecm`.`design`.`interface_point`(`interface_point_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_mep_coordination_zone_id` FOREIGN KEY (`mep_coordination_zone_id`) REFERENCES `construction_ecm`.`design`.`mep_coordination_zone`(`mep_coordination_zone_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);

-- ========= schedule --> equipment (3 constraint(s)) =========
-- Requires: schedule schema, equipment schema
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= schedule --> finance (4 constraint(s)) =========
-- Requires: schedule schema, finance schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= schedule --> hr (10 constraint(s)) =========
-- Requires: schedule schema, hr schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `construction_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_eot_claim` ADD CONSTRAINT `fk_schedule_schedule_eot_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= schedule --> material (1 constraint(s)) =========
-- Requires: schedule schema, material schema
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= schedule --> procurement (3 constraint(s)) =========
-- Requires: schedule schema, procurement schema
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= schedule --> project (12 constraint(s)) =========
-- Requires: schedule schema, project schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `construction_ecm`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_eot_claim` ADD CONSTRAINT `fk_schedule_schedule_eot_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= schedule --> quality (1 constraint(s)) =========
-- Requires: schedule schema, quality schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);

-- ========= schedule --> safety (2 constraint(s)) =========
-- Requires: schedule schema, safety schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);

-- ========= schedule --> workforce (4 constraint(s)) =========
-- Requires: schedule schema, workforce schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= site --> bid (11 constraint(s)) =========
-- Requires: site schema, bid schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_bid_boq_line_id` FOREIGN KEY (`bid_boq_line_id`) REFERENCES `construction_ecm`.`bid`.`bid_boq_line`(`bid_boq_line_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);

-- ========= site --> client (3 constraint(s)) =========
-- Requires: site schema, client schema
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`site`.`logistics_plan` ADD CONSTRAINT `fk_site_logistics_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= site --> compliance (7 constraint(s)) =========
-- Requires: site schema, compliance schema
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= site --> contract (5 constraint(s)) =========
-- Requires: site schema, contract schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= site --> design (7 constraint(s)) =========
-- Requires: site schema, design schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_design_scope_id` FOREIGN KEY (`design_scope_id`) REFERENCES `construction_ecm`.`design`.`design_scope`(`design_scope_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_design_submittal_id` FOREIGN KEY (`design_submittal_id`) REFERENCES `construction_ecm`.`design`.`design_submittal`(`design_submittal_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `construction_ecm`.`design`.`change_notice`(`change_notice_id`);

-- ========= site --> equipment (8 constraint(s)) =========
-- Requires: site schema, equipment schema
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `construction_ecm`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= site --> finance (8 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

-- ========= site --> hr (21 constraint(s)) =========
-- Requires: site schema, hr schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`logistics_plan` ADD CONSTRAINT `fk_site_logistics_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_quaternary_lift_approved_by_employee_id` FOREIGN KEY (`quaternary_lift_approved_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_tertiary_lift_rigger_in_charge_employee_id` FOREIGN KEY (`tertiary_lift_rigger_in_charge_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_tertiary_site_close_out_by_employee_id` FOREIGN KEY (`tertiary_site_close_out_by_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`site` ADD CONSTRAINT `fk_site_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`site` ADD CONSTRAINT `fk_site_site_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`site`.`site_location` ADD CONSTRAINT `fk_site_site_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= site --> procurement (7 constraint(s)) =========
-- Requires: site schema, procurement schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_procurement_framework_agreement_id` FOREIGN KEY (`procurement_framework_agreement_id`) REFERENCES `construction_ecm`.`procurement`.`procurement_framework_agreement`(`procurement_framework_agreement_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= site --> project (24 constraint(s)) =========
-- Requires: site schema, project schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`logistics_plan` ADD CONSTRAINT `fk_site_logistics_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`site` ADD CONSTRAINT `fk_site_site_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`site_location` ADD CONSTRAINT `fk_site_site_location_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= site --> quality (2 constraint(s)) =========
-- Requires: site schema, quality schema
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);

-- ========= site --> safety (5 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= site --> schedule (12 constraint(s)) =========
-- Requires: site schema, schedule schema
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= site --> workforce (5 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`site`.`lift_plan` ADD CONSTRAINT `fk_site_lift_plan_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front_assignment` ADD CONSTRAINT `fk_site_work_front_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= subcontractor --> contract (6 constraint(s)) =========
-- Requires: subcontractor schema, contract schema
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_eot_claim` ADD CONSTRAINT `fk_subcontractor_subcontractor_eot_claim_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`final_account` ADD CONSTRAINT `fk_subcontractor_final_account_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);

-- ========= subcontractor --> finance (2 constraint(s)) =========
-- Requires: subcontractor schema, finance schema
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

-- ========= subcontractor --> hr (4 constraint(s)) =========
-- Requires: subcontractor schema, hr schema
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_eot_claim` ADD CONSTRAINT `fk_subcontractor_subcontractor_eot_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`final_account` ADD CONSTRAINT `fk_subcontractor_final_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= subcontractor --> project (6 constraint(s)) =========
-- Requires: subcontractor schema, project schema
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_change_order` ADD CONSTRAINT `fk_subcontractor_subcontractor_change_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`back_charge` ADD CONSTRAINT `fk_subcontractor_back_charge_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `construction_ecm`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`subcontractor_eot_claim` ADD CONSTRAINT `fk_subcontractor_subcontractor_eot_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`subcontractor`.`final_account` ADD CONSTRAINT `fk_subcontractor_final_account_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= sustainability --> bid (1 constraint(s)) =========
-- Requires: sustainability schema, bid schema
ALTER TABLE `construction_ecm`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= sustainability --> client (12 constraint(s)) =========
-- Requires: sustainability schema, client schema
ALTER TABLE `construction_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`green_certification` ADD CONSTRAINT `fk_sustainability_green_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= sustainability --> compliance (7 constraint(s)) =========
-- Requires: sustainability schema, compliance schema
ALTER TABLE `construction_ecm`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_compliance_action_id` FOREIGN KEY (`compliance_action_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_action`(`compliance_action_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_iso_audit_id` FOREIGN KEY (`iso_audit_id`) REFERENCES `construction_ecm`.`compliance`.`iso_audit`(`iso_audit_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= sustainability --> contract (2 constraint(s)) =========
-- Requires: sustainability schema, contract schema
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= sustainability --> design (1 constraint(s)) =========
-- Requires: sustainability schema, design schema
ALTER TABLE `construction_ecm`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= sustainability --> equipment (10 constraint(s)) =========
-- Requires: sustainability schema, equipment schema
ALTER TABLE `construction_ecm`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_target` ADD CONSTRAINT `fk_sustainability_carbon_target_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`embodied_carbon_assessment` ADD CONSTRAINT `fk_sustainability_embodied_carbon_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= sustainability --> hr (13 constraint(s)) =========
-- Requires: sustainability schema, hr schema
ALTER TABLE `construction_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`green_credit` ADD CONSTRAINT `fk_sustainability_green_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_plan` ADD CONSTRAINT `fk_sustainability_sustainability_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= sustainability --> procurement (3 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= sustainability --> project (20 constraint(s)) =========
-- Requires: sustainability schema, project schema
ALTER TABLE `construction_ecm`.`sustainability`.`esg_disclosure_item` ADD CONSTRAINT `fk_sustainability_esg_disclosure_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_target` ADD CONSTRAINT `fk_sustainability_waste_target_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`green_certification` ADD CONSTRAINT `fk_sustainability_green_certification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`green_credit` ADD CONSTRAINT `fk_sustainability_green_credit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`embodied_carbon_assessment` ADD CONSTRAINT `fk_sustainability_embodied_carbon_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`climate_risk_item` ADD CONSTRAINT `fk_sustainability_climate_risk_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`social_value_record` ADD CONSTRAINT `fk_sustainability_social_value_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`supply_chain_carbon` ADD CONSTRAINT `fk_sustainability_supply_chain_carbon_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_reduction_initiative` ADD CONSTRAINT `fk_sustainability_carbon_reduction_initiative_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= sustainability --> schedule (5 constraint(s)) =========
-- Requires: sustainability schema, schedule schema
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= sustainability --> site (6 constraint(s)) =========
-- Requires: sustainability schema, site schema
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `construction_ecm`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `construction_ecm`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `construction_ecm`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `construction_ecm`.`site`.`site_mobilization`(`site_mobilization_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `construction_ecm`.`site`.`instruction`(`instruction_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `construction_ecm`.`site`.`site_mobilization`(`site_mobilization_id`);

-- ========= sustainability --> workforce (4 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `construction_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`sustainability_action` ADD CONSTRAINT `fk_sustainability_sustainability_action_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `construction_ecm`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `construction_ecm`.`sustainability`.`env_incident` ADD CONSTRAINT `fk_sustainability_env_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= workforce --> bid (7 constraint(s)) =========
-- Requires: workforce schema, bid schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_firm_profile_id` FOREIGN KEY (`firm_profile_id`) REFERENCES `construction_ecm`.`bid`.`firm_profile`(`firm_profile_id`);

-- ========= workforce --> client (4 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= workforce --> compliance (4 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= workforce --> contract (5 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= workforce --> equipment (2 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= workforce --> finance (12 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

-- ========= workforce --> hr (11 constraint(s)) =========
-- Requires: workforce schema, hr schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `construction_ecm`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `construction_ecm`.`hr`.`employee`(`employee_id`);

-- ========= workforce --> procurement (1 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= workforce --> project (21 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_primary_labor_construction_project_id` FOREIGN KEY (`primary_labor_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_site_construction_project_id` FOREIGN KEY (`site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= workforce --> schedule (2 constraint(s)) =========
-- Requires: workforce schema, schedule schema
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= workforce --> sustainability (1 constraint(s)) =========
-- Requires: workforce schema, sustainability schema
ALTER TABLE `construction_ecm`.`workforce`.`carbon_reduction_participation` ADD CONSTRAINT `fk_workforce_carbon_reduction_participation_carbon_reduction_initiative_id` FOREIGN KEY (`carbon_reduction_initiative_id`) REFERENCES `construction_ecm`.`sustainability`.`carbon_reduction_initiative`(`carbon_reduction_initiative_id`);

