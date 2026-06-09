-- Cross-Domain Foreign Keys for Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:08
-- Total cross-domain FK constraints: 1429
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: bid, client, compliance, contract, design, equipment, finance, material, procurement, project, quality, safety, schedule, site, workforce

-- ========= bid --> client (7 constraint(s)) =========
-- Requires: bid schema, client schema
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);

-- ========= bid --> compliance (10 constraint(s)) =========
-- Requires: bid schema, compliance schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`bid`.`risk` ADD CONSTRAINT `fk_bid_risk_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`bid`.`risk` ADD CONSTRAINT `fk_bid_risk_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);

-- ========= bid --> contract (1 constraint(s)) =========
-- Requires: bid schema, contract schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= bid --> design (12 constraint(s)) =========
-- Requires: bid schema, design schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= bid --> equipment (3 constraint(s)) =========
-- Requires: bid schema, equipment schema
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= bid --> finance (25 constraint(s)) =========
-- Requires: bid schema, finance schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ADD CONSTRAINT `fk_bid_bid_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `construction_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `construction_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `construction_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `construction_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`bid`.`risk` ADD CONSTRAINT `fk_bid_risk_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `construction_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= bid --> material (1 constraint(s)) =========
-- Requires: bid schema, material schema
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= bid --> project (13 constraint(s)) =========
-- Requires: bid schema, project schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`bid`.`risk` ADD CONSTRAINT `fk_bid_risk_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= bid --> quality (1 constraint(s)) =========
-- Requires: bid schema, quality schema
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `construction_ecm`.`quality`.`plan`(`plan_id`);

-- ========= bid --> schedule (5 constraint(s)) =========
-- Requires: bid schema, schedule schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `construction_ecm`.`schedule`.`resource`(`resource_id`);

-- ========= bid --> workforce (6 constraint(s)) =========
-- Requires: bid schema, workforce schema
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ADD CONSTRAINT `fk_bid_trade_package_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);

-- ========= client --> bid (2 constraint(s)) =========
-- Requires: client schema, bid schema
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ADD CONSTRAINT `fk_client_client_opportunity_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);

-- ========= client --> contract (2 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= client --> project (2 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= compliance --> client (7 constraint(s)) =========
-- Requires: compliance schema, client schema
ALTER TABLE `construction_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= compliance --> design (4 constraint(s)) =========
-- Requires: compliance schema, design schema
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= compliance --> equipment (1 constraint(s)) =========
-- Requires: compliance schema, equipment schema
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `construction_ecm`.`equipment`.`inspection_record`(`inspection_record_id`);

-- ========= compliance --> finance (14 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= compliance --> procurement (2 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `construction_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> project (16 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `construction_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ADD CONSTRAINT `fk_compliance_env_impact_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= compliance --> quality (2 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `construction_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= compliance --> site (7 constraint(s)) =========
-- Requires: compliance schema, site schema
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `construction_ecm`.`site`.`shift_report`(`shift_report_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);

-- ========= contract --> bid (6 constraint(s)) =========
-- Requires: contract schema, bid schema
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `construction_ecm`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_bond_id` FOREIGN KEY (`bond_id`) REFERENCES `construction_ecm`.`bid`.`bond`(`bond_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= contract --> client (7 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_jv_structure_id` FOREIGN KEY (`jv_structure_id`) REFERENCES `construction_ecm`.`client`.`jv_structure`(`jv_structure_id`);

-- ========= contract --> compliance (9 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);

-- ========= contract --> design (5 constraint(s)) =========
-- Requires: contract schema, design schema
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_handover_package_id` FOREIGN KEY (`handover_package_id`) REFERENCES `construction_ecm`.`design`.`handover_package`(`handover_package_id`);

-- ========= contract --> equipment (2 constraint(s)) =========
-- Requires: contract schema, equipment schema
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `construction_ecm`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `construction_ecm`.`equipment`.`maintenance_order`(`maintenance_order_id`);

-- ========= contract --> finance (3 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= contract --> material (1 constraint(s)) =========
-- Requires: contract schema, material schema
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= contract --> procurement (11 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `construction_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);

-- ========= contract --> project (12 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `construction_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_progress_measurement_id` FOREIGN KEY (`progress_measurement_id`) REFERENCES `construction_ecm`.`project`.`progress_measurement`(`progress_measurement_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ADD CONSTRAINT `fk_contract_ld_assessment_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= contract --> quality (3 constraint(s)) =========
-- Requires: contract schema, quality schema
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `construction_ecm`.`quality`.`plan`(`plan_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_punch_list_id` FOREIGN KEY (`punch_list_id`) REFERENCES `construction_ecm`.`quality`.`punch_list`(`punch_list_id`);

-- ========= contract --> safety (4 constraint(s)) =========
-- Requires: contract schema, safety schema
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= contract --> schedule (5 constraint(s)) =========
-- Requires: contract schema, schedule schema
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `construction_ecm`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `construction_ecm`.`schedule`.`delay_event`(`delay_event_id`);
ALTER TABLE `construction_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= contract --> site (7 constraint(s)) =========
-- Requires: contract schema, site schema
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);

-- ========= design --> bid (3 constraint(s)) =========
-- Requires: design schema, bid schema
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= design --> client (12 constraint(s)) =========
-- Requires: design schema, client schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= design --> compliance (26 constraint(s)) =========
-- Requires: design schema, compliance schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= design --> contract (16 constraint(s)) =========
-- Requires: design schema, contract schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);

-- ========= design --> equipment (7 constraint(s)) =========
-- Requires: design schema, equipment schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `construction_ecm`.`equipment`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `construction_ecm`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= design --> finance (11 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);

-- ========= design --> material (7 constraint(s)) =========
-- Requires: design schema, material schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);

-- ========= design --> project (39 constraint(s)) =========
-- Requires: design schema, project schema
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`correspondence` ADD CONSTRAINT `fk_design_correspondence_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_handover_certificate_id` FOREIGN KEY (`handover_certificate_id`) REFERENCES `construction_ecm`.`project`.`handover_certificate`(`handover_certificate_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_handover_certificate_id` FOREIGN KEY (`handover_certificate_id`) REFERENCES `construction_ecm`.`project`.`handover_certificate`(`handover_certificate_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= design --> quality (1 constraint(s)) =========
-- Requires: design schema, quality schema
ALTER TABLE `construction_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= design --> safety (2 constraint(s)) =========
-- Requires: design schema, safety schema
ALTER TABLE `construction_ecm`.`design`.`package` ADD CONSTRAINT `fk_design_package_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= design --> site (5 constraint(s)) =========
-- Requires: design schema, site schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_package` ADD CONSTRAINT `fk_design_handover_package_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);

-- ========= design --> workforce (6 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `construction_ecm`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`handover_item` ADD CONSTRAINT `fk_design_handover_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`design`.`change_notice` ADD CONSTRAINT `fk_design_change_notice_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= equipment --> bid (4 constraint(s)) =========
-- Requires: equipment schema, bid schema
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `construction_ecm`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);

-- ========= equipment --> client (1 constraint(s)) =========
-- Requires: equipment schema, client schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= equipment --> compliance (7 constraint(s)) =========
-- Requires: equipment schema, compliance schema
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= equipment --> contract (10 constraint(s)) =========
-- Requires: equipment schema, contract schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= equipment --> design (1 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `construction_ecm`.`design`.`document_register`(`document_register_id`);

-- ========= equipment --> finance (28 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `construction_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);

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

-- ========= equipment --> project (20 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_asset_current_location_site_construction_project_id` FOREIGN KEY (`asset_current_location_site_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= equipment --> quality (8 constraint(s)) =========
-- Requires: equipment schema, quality schema
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);

-- ========= equipment --> safety (13 constraint(s)) =========
-- Requires: equipment schema, safety schema
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_training_id` FOREIGN KEY (`training_id`) REFERENCES `construction_ecm`.`safety`.`training`(`training_id`);

-- ========= equipment --> schedule (4 constraint(s)) =========
-- Requires: equipment schema, schedule schema
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= equipment --> site (3 constraint(s)) =========
-- Requires: equipment schema, site schema
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);

-- ========= equipment --> workforce (11 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= finance --> bid (3 constraint(s)) =========
-- Requires: finance schema, bid schema
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= finance --> client (5 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `construction_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= finance --> compliance (8 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= finance --> contract (19 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_closeout_id` FOREIGN KEY (`closeout_id`) REFERENCES `construction_ecm`.`contract`.`closeout`(`closeout_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ld_assessment_id` FOREIGN KEY (`ld_assessment_id`) REFERENCES `construction_ecm`.`contract`.`ld_assessment`(`ld_assessment_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_retention_ledger_id` FOREIGN KEY (`retention_ledger_id`) REFERENCES `construction_ecm`.`contract`.`retention_ledger`(`retention_ledger_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_closeout_id` FOREIGN KEY (`closeout_id`) REFERENCES `construction_ecm`.`contract`.`closeout`(`closeout_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_bond_guarantee_id` FOREIGN KEY (`bond_guarantee_id`) REFERENCES `construction_ecm`.`contract`.`bond_guarantee`(`bond_guarantee_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_subcontract_payment_id` FOREIGN KEY (`subcontract_payment_id`) REFERENCES `construction_ecm`.`contract`.`subcontract_payment`(`subcontract_payment_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `construction_ecm`.`contract`.`payment_schedule`(`payment_schedule_id`);

-- ========= finance --> equipment (1 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= finance --> procurement (11 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `construction_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);

-- ========= finance --> project (20 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `construction_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_progress_measurement_id` FOREIGN KEY (`progress_measurement_id`) REFERENCES `construction_ecm`.`project`.`progress_measurement`(`progress_measurement_id`);
ALTER TABLE `construction_ecm`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`revenue_recognition_entry` ADD CONSTRAINT `fk_finance_revenue_recognition_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_handover_certificate_id` FOREIGN KEY (`handover_certificate_id`) REFERENCES `construction_ecm`.`project`.`handover_certificate`(`handover_certificate_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= material --> bid (4 constraint(s)) =========
-- Requires: material schema, bid schema
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `construction_ecm`.`bid`.`estimate_line`(`estimate_line_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);

-- ========= material --> client (7 constraint(s)) =========
-- Requires: material schema, client schema
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= material --> compliance (9 constraint(s)) =========
-- Requires: material schema, compliance schema
ALTER TABLE `construction_ecm`.`material`.`master` ADD CONSTRAINT `fk_material_master_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= material --> contract (2 constraint(s)) =========
-- Requires: material schema, contract schema
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= material --> design (5 constraint(s)) =========
-- Requires: material schema, design schema
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= material --> equipment (2 constraint(s)) =========
-- Requires: material schema, equipment schema
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= material --> finance (22 constraint(s)) =========
-- Requires: material schema, finance schema
ALTER TABLE `construction_ecm`.`material`.`master` ADD CONSTRAINT `fk_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

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
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= material --> quality (4 constraint(s)) =========
-- Requires: material schema, quality schema
ALTER TABLE `construction_ecm`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_test_certificate_id` FOREIGN KEY (`test_certificate_id`) REFERENCES `construction_ecm`.`quality`.`test_certificate`(`test_certificate_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);

-- ========= material --> safety (6 constraint(s)) =========
-- Requires: material schema, safety schema
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);

-- ========= material --> schedule (9 constraint(s)) =========
-- Requires: material schema, schedule schema
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);

-- ========= material --> site (9 constraint(s)) =========
-- Requires: material schema, site schema
ALTER TABLE `construction_ecm`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `construction_ecm`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_field_progress_id` FOREIGN KEY (`field_progress_id`) REFERENCES `construction_ecm`.`site`.`field_progress`(`field_progress_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `construction_ecm`.`site`.`shift_report`(`shift_report_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);

-- ========= material --> workforce (6 constraint(s)) =========
-- Requires: material schema, workforce schema
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= procurement --> bid (8 constraint(s)) =========
-- Requires: procurement schema, bid schema
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_bid_boq_line_id` FOREIGN KEY (`bid_boq_line_id`) REFERENCES `construction_ecm`.`bid`.`bid_boq_line`(`bid_boq_line_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `construction_ecm`.`bid`.`estimate`(`estimate_id`);

-- ========= procurement --> client (7 constraint(s)) =========
-- Requires: procurement schema, client schema
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= procurement --> compliance (8 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `construction_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= procurement --> contract (3 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);

-- ========= procurement --> design (7 constraint(s)) =========
-- Requires: procurement schema, design schema
ALTER TABLE `construction_ecm`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= procurement --> equipment (4 constraint(s)) =========
-- Requires: procurement schema, equipment schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= procurement --> finance (10 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> material (11 constraint(s)) =========
-- Requires: procurement schema, material schema
ALTER TABLE `construction_ecm`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `construction_ecm`.`material`.`mto_line`(`mto_line_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_material_boq_line_id` FOREIGN KEY (`material_boq_line_id`) REFERENCES `construction_ecm`.`material`.`material_boq_line`(`material_boq_line_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `construction_ecm`.`material`.`mto_line`(`mto_line_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `construction_ecm`.`material`.`mto_line`(`mto_line_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `construction_ecm`.`material`.`specification`(`specification_id`);

-- ========= procurement --> project (16 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= procurement --> quality (2 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_test_certificate_id` FOREIGN KEY (`test_certificate_id`) REFERENCES `construction_ecm`.`quality`.`test_certificate`(`test_certificate_id`);

-- ========= procurement --> schedule (11 constraint(s)) =========
-- Requires: procurement schema, schedule schema
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`procurement`.`inspection_release` ADD CONSTRAINT `fk_procurement_inspection_release_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= procurement --> site (5 constraint(s)) =========
-- Requires: procurement schema, site schema
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_evaluation` ADD CONSTRAINT `fk_procurement_vendor_evaluation_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);

-- ========= procurement --> workforce (6 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `construction_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`procurement`.`sourcing_plan` ADD CONSTRAINT `fk_procurement_sourcing_plan_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `construction_ecm`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `construction_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `construction_ecm`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `construction_ecm`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);

-- ========= project --> bid (4 constraint(s)) =========
-- Requires: project schema, bid schema
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `construction_ecm`.`bid`.`risk`(`risk_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= project --> client (11 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `construction_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= project --> compliance (6 constraint(s)) =========
-- Requires: project schema, compliance schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= project --> contract (8 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `construction_ecm`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= project --> design (7 constraint(s)) =========
-- Requires: project schema, design schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `construction_ecm`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `construction_ecm`.`design`.`transmittal`(`transmittal_id`);

-- ========= project --> finance (6 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `construction_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= project --> material (3 constraint(s)) =========
-- Requires: project schema, material schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= project --> procurement (3 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `construction_ecm`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_inspection_release_id` FOREIGN KEY (`inspection_release_id`) REFERENCES `construction_ecm`.`procurement`.`inspection_release`(`inspection_release_id`);

-- ========= project --> quality (2 constraint(s)) =========
-- Requires: project schema, quality schema
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);

-- ========= project --> safety (4 constraint(s)) =========
-- Requires: project schema, safety schema
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `construction_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= project --> schedule (9 constraint(s)) =========
-- Requires: project schema, schedule schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `construction_ecm`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);
ALTER TABLE `construction_ecm`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_schedule_calendar_id` FOREIGN KEY (`schedule_calendar_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_calendar`(`schedule_calendar_id`);

-- ========= project --> site (10 constraint(s)) =========
-- Requires: project schema, site schema
ALTER TABLE `construction_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);

-- ========= quality --> bid (6 constraint(s)) =========
-- Requires: quality schema, bid schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= quality --> client (10 constraint(s)) =========
-- Requires: quality schema, client schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);

-- ========= quality --> compliance (12 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= quality --> contract (19 constraint(s)) =========
-- Requires: quality schema, contract schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_closeout_id` FOREIGN KEY (`closeout_id`) REFERENCES `construction_ecm`.`contract`.`closeout`(`closeout_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= quality --> design (23 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `construction_ecm`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `construction_ecm`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `construction_ecm`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `construction_ecm`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_handover_package_id` FOREIGN KEY (`handover_package_id`) REFERENCES `construction_ecm`.`design`.`handover_package`(`handover_package_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `construction_ecm`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);

-- ========= quality --> equipment (5 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (8 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `construction_ecm`.`finance`.`progress_billing`(`progress_billing_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);

-- ========= quality --> procurement (10 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `construction_ecm`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_inspection_release_id` FOREIGN KEY (`inspection_release_id`) REFERENCES `construction_ecm`.`procurement`.`inspection_release`(`inspection_release_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `construction_ecm`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= quality --> project (34 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);

-- ========= quality --> safety (26 constraint(s)) =========
-- Requires: quality schema, safety schema
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= quality --> schedule (5 constraint(s)) =========
-- Requires: quality schema, schedule schema
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> site (13 constraint(s)) =========
-- Requires: quality schema, site schema
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_field_progress_id` FOREIGN KEY (`field_progress_id`) REFERENCES `construction_ecm`.`site`.`field_progress`(`field_progress_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `construction_ecm`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_production_entry_id` FOREIGN KEY (`production_entry_id`) REFERENCES `construction_ecm`.`site`.`production_entry`(`production_entry_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `construction_ecm`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_production_entry_id` FOREIGN KEY (`production_entry_id`) REFERENCES `construction_ecm`.`site`.`production_entry`(`production_entry_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `construction_ecm`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);

-- ========= quality --> workforce (13 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);

-- ========= safety --> bid (8 constraint(s)) =========
-- Requires: safety schema, bid schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `construction_ecm`.`bid`.`risk`(`risk_id`);

-- ========= safety --> client (12 constraint(s)) =========
-- Requires: safety schema, client schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_jv_structure_id` FOREIGN KEY (`jv_structure_id`) REFERENCES `construction_ecm`.`client`.`jv_structure`(`jv_structure_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= safety --> compliance (22 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_action_id` FOREIGN KEY (`action_id`) REFERENCES `construction_ecm`.`compliance`.`action`(`action_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `construction_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_action_id` FOREIGN KEY (`action_id`) REFERENCES `construction_ecm`.`compliance`.`action`(`action_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_action_id` FOREIGN KEY (`action_id`) REFERENCES `construction_ecm`.`compliance`.`action`(`action_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= safety --> contract (10 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);

-- ========= safety --> design (3 constraint(s)) =========
-- Requires: safety schema, design schema
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);

-- ========= safety --> equipment (6 constraint(s)) =========
-- Requires: safety schema, equipment schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= safety --> finance (17 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `construction_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);

-- ========= safety --> material (3 constraint(s)) =========
-- Requires: safety schema, material schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= safety --> procurement (7 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `construction_ecm`.`procurement`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> project (19 constraint(s)) =========
-- Requires: safety schema, project schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= safety --> quality (6 constraint(s)) =========
-- Requires: safety schema, quality schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `construction_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= safety --> schedule (4 constraint(s)) =========
-- Requires: safety schema, schedule schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);

-- ========= safety --> site (14 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);

-- ========= safety --> workforce (13 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);

-- ========= schedule --> bid (3 constraint(s)) =========
-- Requires: schedule schema, bid schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= schedule --> client (4 constraint(s)) =========
-- Requires: schedule schema, client schema
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);

-- ========= schedule --> compliance (14 constraint(s)) =========
-- Requires: schedule schema, compliance schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= schedule --> contract (8 constraint(s)) =========
-- Requires: schedule schema, contract schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= schedule --> design (5 constraint(s)) =========
-- Requires: schedule schema, design schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `construction_ecm`.`design`.`change_notice`(`change_notice_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);

-- ========= schedule --> equipment (2 constraint(s)) =========
-- Requires: schedule schema, equipment schema
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= schedule --> finance (9 constraint(s)) =========
-- Requires: schedule schema, finance schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `construction_ecm`.`finance`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);

-- ========= schedule --> material (1 constraint(s)) =========
-- Requires: schedule schema, material schema
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= schedule --> procurement (2 constraint(s)) =========
-- Requires: schedule schema, procurement schema
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= schedule --> project (8 constraint(s)) =========
-- Requires: schedule schema, project schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `construction_ecm`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= schedule --> quality (3 constraint(s)) =========
-- Requires: schedule schema, quality schema
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `construction_ecm`.`quality`.`plan`(`plan_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= schedule --> safety (5 constraint(s)) =========
-- Requires: schedule schema, safety schema
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_hse_inspection_id` FOREIGN KEY (`hse_inspection_id`) REFERENCES `construction_ecm`.`safety`.`hse_inspection`(`hse_inspection_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);

-- ========= schedule --> site (3 constraint(s)) =========
-- Requires: schedule schema, site schema
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `construction_ecm`.`site`.`instruction`(`instruction_id`);

-- ========= schedule --> workforce (4 constraint(s)) =========
-- Requires: schedule schema, workforce schema
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= site --> bid (7 constraint(s)) =========
-- Requires: site schema, bid schema
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `construction_ecm`.`bid`.`estimate_line`(`estimate_line_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_bid_boq_line_id` FOREIGN KEY (`bid_boq_line_id`) REFERENCES `construction_ecm`.`bid`.`bid_boq_line`(`bid_boq_line_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `construction_ecm`.`bid`.`submission`(`submission_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_estimate_line_id` FOREIGN KEY (`estimate_line_id`) REFERENCES `construction_ecm`.`bid`.`estimate_line`(`estimate_line_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_bid_boq_line_id` FOREIGN KEY (`bid_boq_line_id`) REFERENCES `construction_ecm`.`bid`.`bid_boq_line`(`bid_boq_line_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= site --> client (5 constraint(s)) =========
-- Requires: site schema, client schema
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`site`.`site_site` ADD CONSTRAINT `fk_site_site_site_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);

-- ========= site --> compliance (9 constraint(s)) =========
-- Requires: site schema, compliance schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= site --> contract (6 constraint(s)) =========
-- Requires: site schema, contract schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= site --> design (16 constraint(s)) =========
-- Requires: site schema, design schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_package_id` FOREIGN KEY (`package_id`) REFERENCES `construction_ecm`.`design`.`package`(`package_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `construction_ecm`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_change_notice_id` FOREIGN KEY (`change_notice_id`) REFERENCES `construction_ecm`.`design`.`change_notice`(`change_notice_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `construction_ecm`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `construction_ecm`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `construction_ecm`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= site --> equipment (12 constraint(s)) =========
-- Requires: site schema, equipment schema
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `construction_ecm`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_equipment_mobilization_id` FOREIGN KEY (`equipment_mobilization_id`) REFERENCES `construction_ecm`.`equipment`.`equipment_mobilization`(`equipment_mobilization_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `construction_ecm`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `construction_ecm`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `construction_ecm`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_operator_certification_id` FOREIGN KEY (`operator_certification_id`) REFERENCES `construction_ecm`.`equipment`.`operator_certification`(`operator_certification_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `construction_ecm`.`equipment`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= site --> finance (12 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`site`.`site_site` ADD CONSTRAINT `fk_site_site_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= site --> material (2 constraint(s)) =========
-- Requires: site schema, material schema
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `construction_ecm`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= site --> procurement (14 constraint(s)) =========
-- Requires: site schema, procurement schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `construction_ecm`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `construction_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `construction_ecm`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `construction_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `construction_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);

-- ========= site --> project (16 constraint(s)) =========
-- Requires: site schema, project schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `construction_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_project_change_order_id` FOREIGN KEY (`project_change_order_id`) REFERENCES `construction_ecm`.`project`.`project_change_order`(`project_change_order_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`site`.`site_site` ADD CONSTRAINT `fk_site_site_site_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= site --> quality (3 constraint(s)) =========
-- Requires: site schema, quality schema
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `construction_ecm`.`quality`.`plan`(`plan_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= site --> safety (16 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `construction_ecm`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `construction_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `construction_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `construction_ecm`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);

-- ========= site --> schedule (16 constraint(s)) =========
-- Requires: site schema, schedule schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);

-- ========= site --> workforce (7 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= workforce --> bid (2 constraint(s)) =========
-- Requires: workforce schema, bid schema
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_trade_package_id` FOREIGN KEY (`trade_package_id`) REFERENCES `construction_ecm`.`bid`.`trade_package`(`trade_package_id`);

-- ========= workforce --> client (6 constraint(s)) =========
-- Requires: workforce schema, client schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `construction_ecm`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);

-- ========= workforce --> compliance (11 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ADD CONSTRAINT `fk_workforce_skill_trade_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= workforce --> contract (8 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);

-- ========= workforce --> equipment (1 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= workforce --> finance (16 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `construction_ecm`.`finance`.`progress_billing`(`progress_billing_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `construction_ecm`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `construction_ecm`.`finance`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `construction_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `construction_ecm`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `construction_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `construction_ecm`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `construction_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= workforce --> procurement (1 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `construction_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= workforce --> project (18 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_primary_labor_construction_project_id` FOREIGN KEY (`primary_labor_construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `construction_ecm`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `construction_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `construction_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `construction_ecm`.`project`.`construction_project`(`construction_project_id`);

-- ========= workforce --> quality (4 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);

-- ========= workforce --> safety (5 constraint(s)) =========
-- Requires: workforce schema, safety schema
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `construction_ecm`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `construction_ecm`.`safety`.`swms`(`swms_id`);
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_training_id` FOREIGN KEY (`training_id`) REFERENCES `construction_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `construction_ecm`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= workforce --> schedule (6 constraint(s)) =========
-- Requires: workforce schema, schedule schema
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `construction_ecm`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);

-- ========= workforce --> site (1 constraint(s)) =========
-- Requires: workforce schema, site schema
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_site_mobilization_id` FOREIGN KEY (`site_mobilization_id`) REFERENCES `construction_ecm`.`site`.`site_mobilization`(`site_mobilization_id`);

