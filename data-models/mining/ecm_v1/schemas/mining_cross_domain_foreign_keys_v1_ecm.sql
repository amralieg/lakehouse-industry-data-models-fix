-- Cross-Domain Foreign Keys for Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:43
-- Total cross-domain FK constraints: 1531
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: community, customer, equipment, exploration, finance, geology, hse, laboratory, maintenance, mine, processing, procurement, product, project, sales, tailings, tenement, workforce

-- ========= community --> equipment (5 constraint(s)) =========
-- Requires: community schema, equipment schema
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= community --> exploration (5 constraint(s)) =========
-- Requires: community schema, exploration schema
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ADD CONSTRAINT `fk_community_cultural_heritage_site_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);

-- ========= community --> finance (19 constraint(s)) =========
-- Requires: community schema, finance schema
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ADD CONSTRAINT `fk_community_engagement_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= community --> geology (7 constraint(s)) =========
-- Requires: community schema, geology schema
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= community --> hse (6 constraint(s)) =========
-- Requires: community schema, hse schema
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= community --> mine (20 constraint(s)) =========
-- Requires: community schema, mine schema
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ADD CONSTRAINT `fk_community_engagement_plan_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ADD CONSTRAINT `fk_community_social_licence_indicator_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ADD CONSTRAINT `fk_community_local_content_actual_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ADD CONSTRAINT `fk_community_cultural_heritage_site_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ADD CONSTRAINT `fk_community_commitment_evidence_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ADD CONSTRAINT `fk_community_stakeholder_consultation_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ADD CONSTRAINT `fk_community_beneficiary_trust_fund_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= community --> procurement (5 constraint(s)) =========
-- Requires: community schema, procurement schema
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);

-- ========= community --> product (3 constraint(s)) =========
-- Requires: community schema, product schema
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= community --> project (2 constraint(s)) =========
-- Requires: community schema, project schema
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= community --> sales (1 constraint(s)) =========
-- Requires: community schema, sales schema
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_performance_actual_id` FOREIGN KEY (`performance_actual_id`) REFERENCES `mining_ecm`.`sales`.`performance_actual`(`performance_actual_id`);

-- ========= community --> tenement (7 constraint(s)) =========
-- Requires: community schema, tenement schema
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ADD CONSTRAINT `fk_community_cultural_heritage_site_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= community --> workforce (23 constraint(s)) =========
-- Requires: community schema, workforce schema
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ADD CONSTRAINT `fk_community_engagement_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ADD CONSTRAINT `fk_community_social_licence_indicator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ADD CONSTRAINT `fk_community_local_content_actual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ADD CONSTRAINT `fk_community_cultural_heritage_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ADD CONSTRAINT `fk_community_commitment_evidence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ADD CONSTRAINT `fk_community_commitment_evidence_primary_commitment_employee_id` FOREIGN KEY (`primary_commitment_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ADD CONSTRAINT `fk_community_stakeholder_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> community (6 constraint(s)) =========
-- Requires: customer schema, community schema
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ADD CONSTRAINT `fk_customer_counterparty_contact_stakeholder_contact_id` FOREIGN KEY (`stakeholder_contact_id`) REFERENCES `mining_ecm`.`community`.`stakeholder_contact`(`stakeholder_contact_id`);
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_cultural_heritage_site_id` FOREIGN KEY (`cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_local_employment_commitment_id` FOREIGN KEY (`local_employment_commitment_id`) REFERENCES `mining_ecm`.`community`.`local_employment_commitment`(`local_employment_commitment_id`);
ALTER TABLE `mining_ecm`.`customer`.`commercial_interaction` ADD CONSTRAINT `fk_customer_commercial_interaction_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_document` ADD CONSTRAINT `fk_customer_counterparty_document_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);

-- ========= customer --> finance (6 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_document` ADD CONSTRAINT `fk_customer_counterparty_document_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`customer`.`customer_project_contract` ADD CONSTRAINT `fk_customer_customer_project_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= customer --> procurement (3 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_document` ADD CONSTRAINT `fk_customer_counterparty_document_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= customer --> project (1 constraint(s)) =========
-- Requires: customer schema, project schema
ALTER TABLE `mining_ecm`.`customer`.`customer_project_contract` ADD CONSTRAINT `fk_customer_customer_project_contract_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);

-- ========= customer --> workforce (8 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ADD CONSTRAINT `fk_customer_counterparty_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ADD CONSTRAINT `fk_customer_credit_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`commercial_interaction` ADD CONSTRAINT `fk_customer_commercial_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_preference` ADD CONSTRAINT `fk_customer_counterparty_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= equipment --> community (1 constraint(s)) =========
-- Requires: equipment schema, community schema
ALTER TABLE `mining_ecm`.`equipment`.`asset_stakeholder_concern` ADD CONSTRAINT `fk_equipment_asset_stakeholder_concern_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);

-- ========= equipment --> exploration (1 constraint(s)) =========
-- Requires: equipment schema, exploration schema
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);

-- ========= equipment --> finance (12 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= equipment --> hse (10 constraint(s)) =========
-- Requires: equipment schema, hse schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_ppe_issuance_id` FOREIGN KEY (`ppe_issuance_id`) REFERENCES `mining_ecm`.`hse`.`ppe_issuance`(`ppe_issuance_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `mining_ecm`.`hse`.`training_record`(`training_record_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= equipment --> maintenance (10 constraint(s)) =========
-- Requires: equipment schema, maintenance schema
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_load_location_id` FOREIGN KEY (`load_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`equipment_shutdown_scope` ADD CONSTRAINT `fk_equipment_equipment_shutdown_scope_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`equipment`.`equipment_shutdown_scope` ADD CONSTRAINT `fk_equipment_equipment_shutdown_scope_maintenance_shutdown_scope_id` FOREIGN KEY (`maintenance_shutdown_scope_id`) REFERENCES `mining_ecm`.`maintenance`.`maintenance_shutdown_scope`(`maintenance_shutdown_scope_id`);

-- ========= equipment --> mine (13 constraint(s)) =========
-- Requires: equipment schema, mine schema
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_mine_area_id` FOREIGN KEY (`mine_area_id`) REFERENCES `mining_ecm`.`mine`.`mine_area`(`mine_area_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_drill_pattern_id` FOREIGN KEY (`drill_pattern_id`) REFERENCES `mining_ecm`.`mine`.`drill_pattern`(`drill_pattern_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_previous_site_id` FOREIGN KEY (`previous_site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_haul_route_id` FOREIGN KEY (`haul_route_id`) REFERENCES `mining_ecm`.`mine`.`haul_route`(`haul_route_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= equipment --> procurement (6 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_contract_coverage` ADD CONSTRAINT `fk_equipment_asset_contract_coverage_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= equipment --> product (6 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= equipment --> project (8 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= equipment --> tailings (2 constraint(s)) =========
-- Requires: equipment schema, tailings schema
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);

-- ========= equipment --> tenement (5 constraint(s)) =========
-- Requires: equipment schema, tenement schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= equipment --> workforce (24 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_tertiary_downtime_approved_by_employee_id` FOREIGN KEY (`tertiary_downtime_approved_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`drill_activity` ADD CONSTRAINT `fk_equipment_drill_activity_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`dispatch_instruction` ADD CONSTRAINT `fk_equipment_dispatch_instruction_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`equipment_shutdown_scope` ADD CONSTRAINT `fk_equipment_equipment_shutdown_scope_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_crew_assignment` ADD CONSTRAINT `fk_equipment_asset_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);

-- ========= exploration --> community (4 constraint(s)) =========
-- Requires: exploration schema, community schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);

-- ========= exploration --> equipment (6 constraint(s)) =========
-- Requires: exploration schema, equipment schema
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geochemical_survey` ADD CONSTRAINT `fk_exploration_geochemical_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`deployment` ADD CONSTRAINT `fk_exploration_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= exploration --> finance (15 constraint(s)) =========
-- Requires: exploration schema, finance schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_exploration_expenditure_id` FOREIGN KEY (`exploration_expenditure_id`) REFERENCES `mining_ecm`.`finance`.`exploration_expenditure`(`exploration_expenditure_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geochemical_survey` ADD CONSTRAINT `fk_exploration_geochemical_survey_exploration_expenditure_id` FOREIGN KEY (`exploration_expenditure_id`) REFERENCES `mining_ecm`.`finance`.`exploration_expenditure`(`exploration_expenditure_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_exploration_expenditure_id` FOREIGN KEY (`exploration_expenditure_id`) REFERENCES `mining_ecm`.`finance`.`exploration_expenditure`(`exploration_expenditure_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_disclosure` ADD CONSTRAINT `fk_exploration_resource_disclosure_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_budget` ADD CONSTRAINT `fk_exploration_exploration_budget_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_budget` ADD CONSTRAINT `fk_exploration_exploration_budget_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);

-- ========= exploration --> geology (3 constraint(s)) =========
-- Requires: exploration schema, geology schema
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_disclosure` ADD CONSTRAINT `fk_exploration_resource_disclosure_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= exploration --> hse (10 constraint(s)) =========
-- Requires: exploration schema, hse schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geochemical_survey` ADD CONSTRAINT `fk_exploration_geochemical_survey_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `mining_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= exploration --> laboratory (1 constraint(s)) =========
-- Requires: exploration schema, laboratory schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect_laboratory_assignment` ADD CONSTRAINT `fk_exploration_prospect_laboratory_assignment_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);

-- ========= exploration --> processing (2 constraint(s)) =========
-- Requires: exploration schema, processing schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect_processing_campaign` ADD CONSTRAINT `fk_exploration_prospect_processing_campaign_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect_processing_route` ADD CONSTRAINT `fk_exploration_prospect_processing_route_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `mining_ecm`.`processing`.`circuit`(`circuit_id`);

-- ========= exploration --> procurement (8 constraint(s)) =========
-- Requires: exploration schema, procurement schema
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geochemical_survey` ADD CONSTRAINT `fk_exploration_geochemical_survey_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect_vendor_engagement` ADD CONSTRAINT `fk_exploration_prospect_vendor_engagement_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);

-- ========= exploration --> product (9 constraint(s)) =========
-- Requires: exploration schema, product schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geochemical_survey` ADD CONSTRAINT `fk_exploration_geochemical_survey_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= exploration --> sales (1 constraint(s)) =========
-- Requires: exploration schema, sales schema
ALTER TABLE `mining_ecm`.`exploration`.`resource_disclosure` ADD CONSTRAINT `fk_exploration_resource_disclosure_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= exploration --> tenement (5 constraint(s)) =========
-- Requires: exploration schema, tenement schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geochemical_survey` ADD CONSTRAINT `fk_exploration_geochemical_survey_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_budget` ADD CONSTRAINT `fk_exploration_exploration_budget_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= exploration --> workforce (11 constraint(s)) =========
-- Requires: exploration schema, workforce schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ADD CONSTRAINT `fk_exploration_drill_hole_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ADD CONSTRAINT `fk_exploration_geological_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ADD CONSTRAINT `fk_exploration_competent_person_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_budget` ADD CONSTRAINT `fk_exploration_exploration_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`exploration`.`mineralisation_intercept` ADD CONSTRAINT `fk_exploration_mineralisation_intercept_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `mining_ecm`.`finance`.`hedge_instrument` ADD CONSTRAINT `fk_finance_hedge_instrument_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= finance --> equipment (2 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);

-- ========= finance --> mine (4 constraint(s)) =========
-- Requires: finance schema, mine schema
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= finance --> processing (5 constraint(s)) =========
-- Requires: finance schema, processing schema
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= finance --> procurement (1 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);

-- ========= finance --> project (8 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`project_valuation` ADD CONSTRAINT `fk_finance_project_valuation_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`finance`.`project_cost_allocation` ADD CONSTRAINT `fk_finance_project_cost_allocation_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= finance --> tenement (2 constraint(s)) =========
-- Requires: finance schema, tenement schema
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ADD CONSTRAINT `fk_finance_royalty_obligation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ADD CONSTRAINT `fk_finance_exploration_expenditure_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= finance --> workforce (8 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `mining_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`exploration_expenditure` ADD CONSTRAINT `fk_finance_exploration_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`finance`.`business_unit` ADD CONSTRAINT `fk_finance_business_unit_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= geology --> equipment (2 constraint(s)) =========
-- Requires: geology schema, equipment schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= geology --> exploration (12 constraint(s)) =========
-- Requires: geology schema, exploration schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ADD CONSTRAINT `fk_geology_production_drillhole_survey_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ADD CONSTRAINT `fk_geology_structural_measurement_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ADD CONSTRAINT `fk_geology_geostatistical_run_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);

-- ========= geology --> finance (7 constraint(s)) =========
-- Requires: geology schema, finance schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= geology --> hse (1 constraint(s)) =========
-- Requires: geology schema, hse schema
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ADD CONSTRAINT `fk_geology_orebody_permit_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);

-- ========= geology --> laboratory (3 constraint(s)) =========
-- Requires: geology schema, laboratory schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);

-- ========= geology --> mine (5 constraint(s)) =========
-- Requires: geology schema, mine schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_blast_pattern_id` FOREIGN KEY (`blast_pattern_id`) REFERENCES `mining_ecm`.`mine`.`blast_pattern`(`blast_pattern_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ADD CONSTRAINT `fk_geology_survey_run_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= geology --> product (5 constraint(s)) =========
-- Requires: geology schema, product schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ADD CONSTRAINT `fk_geology_geological_unit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= geology --> project (4 constraint(s)) =========
-- Requires: geology schema, project schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= geology --> sales (1 constraint(s)) =========
-- Requires: geology schema, sales schema
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ADD CONSTRAINT `fk_geology_orebody_allocation_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= geology --> tenement (1 constraint(s)) =========
-- Requires: geology schema, tenement schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= geology --> workforce (10 constraint(s)) =========
-- Requires: geology schema, workforce schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ADD CONSTRAINT `fk_geology_production_drillhole_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ADD CONSTRAINT `fk_geology_structural_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ADD CONSTRAINT `fk_geology_geostatistical_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ADD CONSTRAINT `fk_geology_survey_run_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ADD CONSTRAINT `fk_geology_survey_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= hse --> community (5 constraint(s)) =========
-- Requires: hse schema, community schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);

-- ========= hse --> customer (6 constraint(s)) =========
-- Requires: hse schema, customer schema
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= hse --> equipment (2 constraint(s)) =========
-- Requires: hse schema, equipment schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= hse --> finance (16 constraint(s)) =========
-- Requires: hse schema, finance schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`ppe_issuance` ADD CONSTRAINT `fk_hse_ppe_issuance_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`hse`.`health_surveillance` ADD CONSTRAINT `fk_hse_health_surveillance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`legal_register` ADD CONSTRAINT `fk_hse_legal_register_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= hse --> geology (5 constraint(s)) =========
-- Requires: hse schema, geology schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= hse --> laboratory (2 constraint(s)) =========
-- Requires: hse schema, laboratory schema
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);

-- ========= hse --> mine (2 constraint(s)) =========
-- Requires: hse schema, mine schema
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);

-- ========= hse --> procurement (11 constraint(s)) =========
-- Requires: hse schema, procurement schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`hse`.`ppe_issuance` ADD CONSTRAINT `fk_hse_ppe_issuance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`ppe_issuance` ADD CONSTRAINT `fk_hse_ppe_issuance_supply_material_master_id` FOREIGN KEY (`supply_material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);

-- ========= hse --> product (12 constraint(s)) =========
-- Requires: hse schema, product schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);

-- ========= hse --> project (9 constraint(s)) =========
-- Requires: hse schema, project schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= hse --> sales (1 constraint(s)) =========
-- Requires: hse schema, sales schema
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);

-- ========= hse --> tenement (14 constraint(s)) =========
-- Requires: hse schema, tenement schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_programme_of_work_id` FOREIGN KEY (`programme_of_work_id`) REFERENCES `mining_ecm`.`tenement`.`programme_of_work`(`programme_of_work_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_application_id` FOREIGN KEY (`application_id`) REFERENCES `mining_ecm`.`tenement`.`application`(`application_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`legal_register` ADD CONSTRAINT `fk_hse_legal_register_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= hse --> workforce (20 constraint(s)) =========
-- Requires: hse schema, workforce schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_incident_injured_person_employee_id` FOREIGN KEY (`incident_injured_person_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_primary_risk_employee_id` FOREIGN KEY (`primary_risk_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_tertiary_safety_assigned_to_employee_id` FOREIGN KEY (`tertiary_safety_assigned_to_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`ppe_issuance` ADD CONSTRAINT `fk_hse_ppe_issuance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`health_surveillance` ADD CONSTRAINT `fk_hse_health_surveillance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `mining_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_primary_management_initiator_employee_id` FOREIGN KEY (`primary_management_initiator_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> community (5 constraint(s)) =========
-- Requires: laboratory schema, community schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_cultural_heritage_site_id` FOREIGN KEY (`cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);

-- ========= laboratory --> customer (5 constraint(s)) =========
-- Requires: laboratory schema, customer schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ADD CONSTRAINT `fk_laboratory_laboratory_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= laboratory --> equipment (5 constraint(s)) =========
-- Requires: laboratory schema, equipment schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ADD CONSTRAINT `fk_laboratory_program_equipment_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= laboratory --> exploration (11 constraint(s)) =========
-- Requires: laboratory schema, exploration schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_exploration_sample_id` FOREIGN KEY (`exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_exploration_sample_id` FOREIGN KEY (`exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_exploration_sample_id` FOREIGN KEY (`exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ADD CONSTRAINT `fk_laboratory_approval_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);

-- ========= laboratory --> finance (6 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= laboratory --> hse (12 constraint(s)) =========
-- Requires: laboratory schema, hse schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_legal_register_id` FOREIGN KEY (`legal_register_id`) REFERENCES `mining_ecm`.`hse`.`legal_register`(`legal_register_id`);

-- ========= laboratory --> maintenance (7 constraint(s)) =========
-- Requires: laboratory schema, maintenance schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_failure_report_id` FOREIGN KEY (`failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_failure_report_id` FOREIGN KEY (`failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_failure_report_id` FOREIGN KEY (`failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= laboratory --> mine (5 constraint(s)) =========
-- Requires: laboratory schema, mine schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_grade_control_block_id` FOREIGN KEY (`grade_control_block_id`) REFERENCES `mining_ecm`.`mine`.`grade_control_block`(`grade_control_block_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_mine_area_id` FOREIGN KEY (`mine_area_id`) REFERENCES `mining_ecm`.`mine`.`mine_area`(`mine_area_id`);

-- ========= laboratory --> processing (2 constraint(s)) =========
-- Requires: laboratory schema, processing schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);

-- ========= laboratory --> product (4 constraint(s)) =========
-- Requires: laboratory schema, product schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= laboratory --> project (8 constraint(s)) =========
-- Requires: laboratory schema, project schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_stage_gate_id` FOREIGN KEY (`stage_gate_id`) REFERENCES `mining_ecm`.`project`.`stage_gate`(`stage_gate_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ADD CONSTRAINT `fk_laboratory_service_agreement_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ADD CONSTRAINT `fk_laboratory_study_analytical_specification_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);

-- ========= laboratory --> sales (1 constraint(s)) =========
-- Requires: laboratory schema, sales schema
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= laboratory --> tenement (1 constraint(s)) =========
-- Requires: laboratory schema, tenement schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= laboratory --> workforce (13 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_tertiary_sample_competent_person_signoff_user_employee_id` FOREIGN KEY (`tertiary_sample_competent_person_signoff_user_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_primary_sample_employee_id` FOREIGN KEY (`primary_sample_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ADD CONSTRAINT `fk_laboratory_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ADD CONSTRAINT `fk_laboratory_service_agreement_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ADD CONSTRAINT `fk_laboratory_program_equipment_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= maintenance --> community (9 constraint(s)) =========
-- Requires: maintenance schema, community schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_engagement_plan_id` FOREIGN KEY (`engagement_plan_id`) REFERENCES `mining_ecm`.`community`.`engagement_plan`(`engagement_plan_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_cultural_heritage_site_id` FOREIGN KEY (`cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_cultural_heritage_site_id` FOREIGN KEY (`cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_local_employment_commitment_id` FOREIGN KEY (`local_employment_commitment_id`) REFERENCES `mining_ecm`.`community`.`local_employment_commitment`(`local_employment_commitment_id`);

-- ========= maintenance --> customer (4 constraint(s)) =========
-- Requires: maintenance schema, customer schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= maintenance --> equipment (23 constraint(s)) =========
-- Requires: maintenance schema, equipment schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_primary_component_asset_id` FOREIGN KEY (`primary_component_asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_downtime_event_id` FOREIGN KEY (`downtime_event_id`) REFERENCES `mining_ecm`.`equipment`.`downtime_event`(`downtime_event_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_component_register_id` FOREIGN KEY (`component_register_id`) REFERENCES `mining_ecm`.`equipment`.`component_register`(`component_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);

-- ========= maintenance --> finance (12 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= maintenance --> geology (4 constraint(s)) =========
-- Requires: maintenance schema, geology schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= maintenance --> hse (19 constraint(s)) =========
-- Requires: maintenance schema, hse schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `mining_ecm`.`hse`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `mining_ecm`.`hse`.`training_record`(`training_record_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `mining_ecm`.`hse`.`training_record`(`training_record_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);

-- ========= maintenance --> laboratory (1 constraint(s)) =========
-- Requires: maintenance schema, laboratory schema
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);

-- ========= maintenance --> mine (6 constraint(s)) =========
-- Requires: maintenance schema, mine schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` ADD CONSTRAINT `fk_maintenance_inspection_template_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);

-- ========= maintenance --> procurement (6 constraint(s)) =========
-- Requires: maintenance schema, procurement schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `mining_ecm`.`procurement`.`requisition`(`requisition_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);

-- ========= maintenance --> product (5 constraint(s)) =========
-- Requires: maintenance schema, product schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= maintenance --> project (21 constraint(s)) =========
-- Requires: maintenance schema, project schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_schedule_activity_id` FOREIGN KEY (`schedule_activity_id`) REFERENCES `mining_ecm`.`project`.`schedule_activity`(`schedule_activity_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `mining_ecm`.`project`.`calendar`(`calendar_id`);

-- ========= maintenance --> tailings (19 constraint(s)) =========
-- Requires: maintenance schema, tailings schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);

-- ========= maintenance --> tenement (6 constraint(s)) =========
-- Requires: maintenance schema, tenement schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_programme_of_work_id` FOREIGN KEY (`programme_of_work_id`) REFERENCES `mining_ecm`.`tenement`.`programme_of_work`(`programme_of_work_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= maintenance --> workforce (29 constraint(s)) =========
-- Requires: maintenance schema, workforce schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_quaternary_failure_last_modified_by_employee_id` FOREIGN KEY (`quaternary_failure_last_modified_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_tertiary_failure_created_by_employee_id` FOREIGN KEY (`tertiary_failure_created_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_quaternary_shutdown_last_modified_by_employee_id` FOREIGN KEY (`quaternary_shutdown_last_modified_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_tertiary_shutdown_created_by_employee_id` FOREIGN KEY (`tertiary_shutdown_created_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_permit_issuing_authority_employee_id` FOREIGN KEY (`permit_issuing_authority_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_permit_site_supervisor_employee_id` FOREIGN KEY (`permit_site_supervisor_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_strategy_employee_id` FOREIGN KEY (`strategy_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` ADD CONSTRAINT `fk_maintenance_inspection_template_department_id` FOREIGN KEY (`department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_department_id` FOREIGN KEY (`department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= mine --> community (10 constraint(s)) =========
-- Requires: mine schema, community schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_resettlement_plan_id` FOREIGN KEY (`resettlement_plan_id`) REFERENCES `mining_ecm`.`community`.`resettlement_plan`(`resettlement_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_cultural_heritage_site_id` FOREIGN KEY (`cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);

-- ========= mine --> equipment (7 constraint(s)) =========
-- Requires: mine schema, equipment schema
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_dispatch_instruction_id` FOREIGN KEY (`dispatch_instruction_id`) REFERENCES `mining_ecm`.`equipment`.`dispatch_instruction`(`dispatch_instruction_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ADD CONSTRAINT `fk_mine_equipment_schedule_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ADD CONSTRAINT `fk_mine_equipment_schedule_assignment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `mining_ecm`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);

-- ========= mine --> exploration (19 constraint(s)) =========
-- Requires: mine schema, exploration schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);

-- ========= mine --> finance (22 constraint(s)) =========
-- Requires: mine schema, finance schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `mining_ecm`.`finance`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `mining_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `mining_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);

-- ========= mine --> geology (31 constraint(s)) =========
-- Requires: mine schema, geology schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_block_model_cell_id` FOREIGN KEY (`block_model_cell_id`) REFERENCES `mining_ecm`.`geology`.`block_model_cell`(`block_model_cell_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);

-- ========= mine --> hse (16 constraint(s)) =========
-- Requires: mine schema, hse schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_legal_register_id` FOREIGN KEY (`legal_register_id`) REFERENCES `mining_ecm`.`hse`.`legal_register`(`legal_register_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `mining_ecm`.`hse`.`training_record`(`training_record_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `mining_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);

-- ========= mine --> laboratory (1 constraint(s)) =========
-- Requires: mine schema, laboratory schema
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);

-- ========= mine --> maintenance (12 constraint(s)) =========
-- Requires: mine schema, maintenance schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_primary_material_functional_location_id` FOREIGN KEY (`primary_material_functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_tertiary_haulage_functional_location_id` FOREIGN KEY (`tertiary_haulage_functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_location_id` FOREIGN KEY (`location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= mine --> processing (1 constraint(s)) =========
-- Requires: mine schema, processing schema
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ADD CONSTRAINT `fk_mine_stockpile_circuit_feed_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `mining_ecm`.`processing`.`circuit`(`circuit_id`);

-- ========= mine --> procurement (4 constraint(s)) =========
-- Requires: mine schema, procurement schema
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);

-- ========= mine --> product (4 constraint(s)) =========
-- Requires: mine schema, product schema
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ADD CONSTRAINT `fk_mine_stockpile_blend_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= mine --> project (5 constraint(s)) =========
-- Requires: mine schema, project schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= mine --> tenement (14 constraint(s)) =========
-- Requires: mine schema, tenement schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= mine --> workforce (19 constraint(s)) =========
-- Requires: mine schema, workforce schema
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ADD CONSTRAINT `fk_mine_equipment_schedule_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ADD CONSTRAINT `fk_mine_schedule_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ADD CONSTRAINT `fk_mine_schedule_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ADD CONSTRAINT `fk_mine_stockpile_blend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ADD CONSTRAINT `fk_mine_drill_pattern_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ADD CONSTRAINT `fk_mine_drill_pattern_designed_by_employee_id` FOREIGN KEY (`designed_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_designed_by_employee_id` FOREIGN KEY (`designed_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= processing --> community (5 constraint(s)) =========
-- Requires: processing schema, community schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_heritage_incident_id` FOREIGN KEY (`heritage_incident_id`) REFERENCES `mining_ecm`.`community`.`heritage_incident`(`heritage_incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_community_contribution` ADD CONSTRAINT `fk_processing_plant_community_contribution_investment_program_id` FOREIGN KEY (`investment_program_id`) REFERENCES `mining_ecm`.`community`.`investment_program`(`investment_program_id`);

-- ========= processing --> equipment (8 constraint(s)) =========
-- Requires: processing schema, equipment schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`slurry_measurement` ADD CONSTRAINT `fk_processing_slurry_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit_asset_assignment` ADD CONSTRAINT `fk_processing_circuit_asset_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`measurement_point` ADD CONSTRAINT `fk_processing_measurement_point_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`pipeline` ADD CONSTRAINT `fk_processing_pipeline_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= processing --> exploration (13 constraint(s)) =========
-- Requires: processing schema, exploration schema
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_water_balance` ADD CONSTRAINT `fk_processing_process_water_balance_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_exploration_sample_id` FOREIGN KEY (`exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);

-- ========= processing --> finance (8 constraint(s)) =========
-- Requires: processing schema, finance schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= processing --> geology (7 constraint(s)) =========
-- Requires: processing schema, geology schema
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= processing --> hse (11 constraint(s)) =========
-- Requires: processing schema, hse schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= processing --> laboratory (13 constraint(s)) =========
-- Requires: processing schema, laboratory schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit_analytical_protocol` ADD CONSTRAINT `fk_processing_circuit_analytical_protocol_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);

-- ========= processing --> maintenance (14 constraint(s)) =========
-- Requires: processing schema, maintenance schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_water_balance` ADD CONSTRAINT `fk_processing_process_water_balance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_deviation` ADD CONSTRAINT `fk_processing_process_deviation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);

-- ========= processing --> mine (47 constraint(s)) =========
-- Requires: processing schema, mine schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`slurry_measurement` ADD CONSTRAINT `fk_processing_slurry_measurement_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_water_balance` ADD CONSTRAINT `fk_processing_process_water_balance_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_water_balance` ADD CONSTRAINT `fk_processing_process_water_balance_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_grade_control_block_id` FOREIGN KEY (`grade_control_block_id`) REFERENCES `mining_ecm`.`mine`.`grade_control_block`(`grade_control_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_deviation` ADD CONSTRAINT `fk_processing_process_deviation_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);

-- ========= processing --> procurement (2 constraint(s)) =========
-- Requires: processing schema, procurement schema
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);

-- ========= processing --> product (19 constraint(s)) =========
-- Requires: processing schema, product schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit_product_configuration` ADD CONSTRAINT `fk_processing_circuit_product_configuration_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_product_campaign` ADD CONSTRAINT `fk_processing_plant_product_campaign_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= processing --> project (5 constraint(s)) =========
-- Requires: processing schema, project schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `mining_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit_delivery` ADD CONSTRAINT `fk_processing_circuit_delivery_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= processing --> sales (5 constraint(s)) =========
-- Requires: processing schema, sales schema
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`processing`.`processing_recovery_target` ADD CONSTRAINT `fk_processing_processing_recovery_target_revenue_forecast_id` FOREIGN KEY (`revenue_forecast_id`) REFERENCES `mining_ecm`.`sales`.`revenue_forecast`(`revenue_forecast_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_shipment_nomination_id` FOREIGN KEY (`shipment_nomination_id`) REFERENCES `mining_ecm`.`sales`.`shipment_nomination`(`shipment_nomination_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_quality_certificate_id` FOREIGN KEY (`quality_certificate_id`) REFERENCES `mining_ecm`.`sales`.`quality_certificate`(`quality_certificate_id`);

-- ========= processing --> tailings (12 constraint(s)) =========
-- Requires: processing schema, tailings schema
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_water_balance` ADD CONSTRAINT `fk_processing_process_water_balance_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit_tailings_routing` ADD CONSTRAINT `fk_processing_circuit_tailings_routing_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`tailings_routing` ADD CONSTRAINT `fk_processing_tailings_routing_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);

-- ========= processing --> tenement (7 constraint(s)) =========
-- Requires: processing schema, tenement schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`stockpile_tenement_contribution` ADD CONSTRAINT `fk_processing_stockpile_tenement_contribution_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= processing --> workforce (16 constraint(s)) =========
-- Requires: processing schema, workforce schema
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`slurry_measurement` ADD CONSTRAINT `fk_processing_slurry_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`dms_event` ADD CONSTRAINT `fk_processing_dms_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_deviation` ADD CONSTRAINT `fk_processing_process_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`beneficiation_test` ADD CONSTRAINT `fk_processing_beneficiation_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_contractor_engagement` ADD CONSTRAINT `fk_processing_plant_contractor_engagement_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_contractor_engagement` ADD CONSTRAINT `fk_processing_plant_contractor_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> customer (2 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= procurement --> equipment (2 constraint(s)) =========
-- Requires: procurement schema, equipment schema
ALTER TABLE `mining_ecm`.`procurement`.`port_stockpile` ADD CONSTRAINT `fk_procurement_port_stockpile_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stockpile_movement` ADD CONSTRAINT `fk_procurement_stockpile_movement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= procurement --> finance (25 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `mining_ecm`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ADD CONSTRAINT `fk_procurement_warehouse_location_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ADD CONSTRAINT `fk_procurement_framework_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`hazmat_register` ADD CONSTRAINT `fk_procurement_hazmat_register_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract_amendment` ADD CONSTRAINT `fk_procurement_contract_amendment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract_amendment` ADD CONSTRAINT `fk_procurement_contract_amendment_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract_amendment` ADD CONSTRAINT `fk_procurement_contract_amendment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`vendor_cost_centre_spend` ADD CONSTRAINT `fk_procurement_vendor_cost_centre_spend_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= procurement --> laboratory (6 constraint(s)) =========
-- Requires: procurement schema, laboratory schema
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`procurement`.`port_stockpile` ADD CONSTRAINT `fk_procurement_port_stockpile_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stockpile_movement` ADD CONSTRAINT `fk_procurement_stockpile_movement_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`procurement`.`hazmat_register` ADD CONSTRAINT `fk_procurement_hazmat_register_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);

-- ========= procurement --> mine (2 constraint(s)) =========
-- Requires: procurement schema, mine schema
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ADD CONSTRAINT `fk_procurement_warehouse_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stockpile_movement` ADD CONSTRAINT `fk_procurement_stockpile_movement_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);

-- ========= procurement --> processing (4 constraint(s)) =========
-- Requires: procurement schema, processing schema
ALTER TABLE `mining_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ADD CONSTRAINT `fk_procurement_inventory_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_sending_plant_id` FOREIGN KEY (`sending_plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= procurement --> product (7 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`port_stockpile` ADD CONSTRAINT `fk_procurement_port_stockpile_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stockpile_movement` ADD CONSTRAINT `fk_procurement_stockpile_movement_blend_id` FOREIGN KEY (`blend_id`) REFERENCES `mining_ecm`.`product`.`blend`(`blend_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= procurement --> sales (1 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `mining_ecm`.`procurement`.`port_stockpile` ADD CONSTRAINT `fk_procurement_port_stockpile_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);

-- ========= procurement --> tenement (1 constraint(s)) =========
-- Requires: procurement schema, tenement schema
ALTER TABLE `mining_ecm`.`procurement`.`vendor_site_access` ADD CONSTRAINT `fk_procurement_vendor_site_access_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= procurement --> workforce (6 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `mining_ecm`.`procurement`.`port_stockpile` ADD CONSTRAINT `fk_procurement_port_stockpile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stockpile_movement` ADD CONSTRAINT `fk_procurement_stockpile_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ADD CONSTRAINT `fk_procurement_framework_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> customer (6 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ADD CONSTRAINT `fk_product_pricing_basis_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= product --> finance (5 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `mining_ecm`.`product`.`commodity` ADD CONSTRAINT `fk_product_commodity_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= product --> geology (3 constraint(s)) =========
-- Requires: product schema, geology schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= product --> laboratory (3 constraint(s)) =========
-- Requires: product schema, laboratory schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`product`.`test_specification` ADD CONSTRAINT `fk_product_test_specification_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);

-- ========= product --> processing (1 constraint(s)) =========
-- Requires: product schema, processing schema
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= product --> procurement (2 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `mining_ecm`.`product`.`product_approved_vendor_material` ADD CONSTRAINT `fk_product_product_approved_vendor_material_procurement_approved_vendor_material_id` FOREIGN KEY (`procurement_approved_vendor_material_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_approved_vendor_material`(`procurement_approved_vendor_material_id`);
ALTER TABLE `mining_ecm`.`product`.`product_approved_vendor_material` ADD CONSTRAINT `fk_product_product_approved_vendor_material_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);

-- ========= product --> project (2 constraint(s)) =========
-- Requires: product schema, project schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= product --> tenement (2 constraint(s)) =========
-- Requires: product schema, tenement schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= project --> customer (2 constraint(s)) =========
-- Requires: project schema, customer schema
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= project --> exploration (10 constraint(s)) =========
-- Requires: project schema, exploration schema
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ADD CONSTRAINT `fk_project_lessons_learned_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);

-- ========= project --> finance (15 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `mining_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ADD CONSTRAINT `fk_project_schedule_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= project --> laboratory (1 constraint(s)) =========
-- Requires: project schema, laboratory schema
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);

-- ========= project --> processing (2 constraint(s)) =========
-- Requires: project schema, processing schema
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `mining_ecm`.`processing`.`circuit`(`circuit_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= project --> procurement (13 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `mining_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_item` ADD CONSTRAINT `fk_project_risk_item_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);

-- ========= project --> product (2 constraint(s)) =========
-- Requires: project schema, product schema
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= project --> tenement (7 constraint(s)) =========
-- Requires: project schema, tenement schema
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= project --> workforce (17 constraint(s)) =========
-- Requires: project schema, workforce schema
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_capital_sponsor_employee_id` FOREIGN KEY (`capital_sponsor_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_primary_risk_employee_id` FOREIGN KEY (`primary_risk_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_item` ADD CONSTRAINT `fk_project_risk_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_project_contract_employee_id` FOREIGN KEY (`project_contract_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_tertiary_team_functional_manager_employee_id` FOREIGN KEY (`tertiary_team_functional_manager_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> community (1 constraint(s)) =========
-- Requires: sales schema, community schema
ALTER TABLE `mining_ecm`.`sales`.`agreement_stakeholder_consultation` ADD CONSTRAINT `fk_sales_agreement_stakeholder_consultation_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);

-- ========= sales --> customer (15 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `mining_ecm`.`customer`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`spot_trade` ADD CONSTRAINT `fk_sales_spot_trade_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`performance_actual` ADD CONSTRAINT `fk_sales_performance_actual_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`freight_contract` ADD CONSTRAINT `fk_sales_freight_contract_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`demurrage_claim` ADD CONSTRAINT `fk_sales_demurrage_claim_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= sales --> exploration (4 constraint(s)) =========
-- Requires: sales schema, exploration schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);

-- ========= sales --> finance (23 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`spot_trade` ADD CONSTRAINT `fk_sales_spot_trade_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`spot_trade` ADD CONSTRAINT `fk_sales_spot_trade_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`performance_actual` ADD CONSTRAINT `fk_sales_performance_actual_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`freight_contract` ADD CONSTRAINT `fk_sales_freight_contract_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`demurrage_claim` ADD CONSTRAINT `fk_sales_demurrage_claim_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= sales --> geology (6 constraint(s)) =========
-- Requires: sales schema, geology schema
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`sales`.`performance_actual` ADD CONSTRAINT `fk_sales_performance_actual_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= sales --> laboratory (1 constraint(s)) =========
-- Requires: sales schema, laboratory schema
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);

-- ========= sales --> mine (8 constraint(s)) =========
-- Requires: sales schema, mine schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_plan_scenario_id` FOREIGN KEY (`plan_scenario_id`) REFERENCES `mining_ecm`.`mine`.`plan_scenario`(`plan_scenario_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);

-- ========= sales --> procurement (1 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= sales --> product (11 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`spot_trade` ADD CONSTRAINT `fk_sales_spot_trade_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`performance_actual` ADD CONSTRAINT `fk_sales_performance_actual_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= sales --> project (5 constraint(s)) =========
-- Requires: sales schema, project schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);

-- ========= sales --> tenement (2 constraint(s)) =========
-- Requires: sales schema, tenement schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= sales --> workforce (13 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_revenue_prepared_by_user_employee_id` FOREIGN KEY (`revenue_prepared_by_user_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`spot_trade` ADD CONSTRAINT `fk_sales_spot_trade_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`performance_actual` ADD CONSTRAINT `fk_sales_performance_actual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`freight_contract` ADD CONSTRAINT `fk_sales_freight_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`sales`.`demurrage_claim` ADD CONSTRAINT `fk_sales_demurrage_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= tailings --> community (16 constraint(s)) =========
-- Requires: tailings schema, community schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ADD CONSTRAINT `fk_tailings_emergency_action_plan_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ADD CONSTRAINT `fk_tailings_emergency_action_plan_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);

-- ========= tailings --> equipment (3 constraint(s)) =========
-- Requires: tailings schema, equipment schema
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= tailings --> exploration (4 constraint(s)) =========
-- Requires: tailings schema, exploration schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_exploration_sample_id` FOREIGN KEY (`exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);

-- ========= tailings --> finance (27 constraint(s)) =========
-- Requires: tailings schema, finance schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ADD CONSTRAINT `fk_tailings_stability_analysis_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ADD CONSTRAINT `fk_tailings_stability_analysis_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ADD CONSTRAINT `fk_tailings_emergency_action_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= tailings --> geology (4 constraint(s)) =========
-- Requires: tailings schema, geology schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= tailings --> hse (15 constraint(s)) =========
-- Requires: tailings schema, hse schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `mining_ecm`.`hse`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_legal_register_id` FOREIGN KEY (`legal_register_id`) REFERENCES `mining_ecm`.`hse`.`legal_register`(`legal_register_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ADD CONSTRAINT `fk_tailings_emergency_action_plan_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ADD CONSTRAINT `fk_tailings_destination_facility_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= tailings --> laboratory (5 constraint(s)) =========
-- Requires: tailings schema, laboratory schema
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);

-- ========= tailings --> mine (11 constraint(s)) =========
-- Requires: tailings schema, mine schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ADD CONSTRAINT `fk_tailings_destination_facility_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);

-- ========= tailings --> processing (5 constraint(s)) =========
-- Requires: tailings schema, processing schema
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= tailings --> procurement (10 constraint(s)) =========
-- Requires: tailings schema, procurement schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);

-- ========= tailings --> product (4 constraint(s)) =========
-- Requires: tailings schema, product schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= tailings --> project (10 constraint(s)) =========
-- Requires: tailings schema, project schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ADD CONSTRAINT `fk_tailings_stability_analysis_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_stage_gate_id` FOREIGN KEY (`stage_gate_id`) REFERENCES `mining_ecm`.`project`.`stage_gate`(`stage_gate_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ADD CONSTRAINT `fk_tailings_deposition_plan_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `mining_ecm`.`project`.`schedule`(`schedule_id`);

-- ========= tailings --> tenement (5 constraint(s)) =========
-- Requires: tailings schema, tenement schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= tailings --> workforce (20 constraint(s)) =========
-- Requires: tailings schema, workforce schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_deposition_employee_id` FOREIGN KEY (`deposition_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_primary_waste_employee_id` FOREIGN KEY (`primary_waste_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ADD CONSTRAINT `fk_tailings_stability_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ADD CONSTRAINT `fk_tailings_destination_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= tenement --> community (1 constraint(s)) =========
-- Requires: tenement schema, community schema
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ADD CONSTRAINT `fk_tenement_native_title_agreement_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);

-- ========= tenement --> customer (6 constraint(s)) =========
-- Requires: tenement schema, customer schema
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ADD CONSTRAINT `fk_tenement_native_title_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`application` ADD CONSTRAINT `fk_tenement_application_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ADD CONSTRAINT `fk_tenement_transfer_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ADD CONSTRAINT `fk_tenement_transfer_transfer_counterparty_id` FOREIGN KEY (`transfer_counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`holder` ADD CONSTRAINT `fk_tenement_holder_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= tenement --> finance (9 constraint(s)) =========
-- Requires: tenement schema, finance schema
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ADD CONSTRAINT `fk_tenement_programme_of_work_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ADD CONSTRAINT `fk_tenement_programme_of_work_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= tenement --> geology (2 constraint(s)) =========
-- Requires: tenement schema, geology schema
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ADD CONSTRAINT `fk_tenement_programme_of_work_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= tenement --> hse (1 constraint(s)) =========
-- Requires: tenement schema, hse schema
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= tenement --> processing (1 constraint(s)) =========
-- Requires: tenement schema, processing schema
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ADD CONSTRAINT `fk_tenement_tenement_recovery_target_processing_recovery_target_id` FOREIGN KEY (`processing_recovery_target_id`) REFERENCES `mining_ecm`.`processing`.`processing_recovery_target`(`processing_recovery_target_id`);

-- ========= tenement --> procurement (6 constraint(s)) =========
-- Requires: tenement schema, procurement schema
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ADD CONSTRAINT `fk_tenement_boundary_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ADD CONSTRAINT `fk_tenement_programme_of_work_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ADD CONSTRAINT `fk_tenement_contract_allocation_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= tenement --> workforce (8 constraint(s)) =========
-- Requires: tenement schema, workforce schema
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ADD CONSTRAINT `fk_tenement_renewal_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ADD CONSTRAINT `fk_tenement_regulatory_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ADD CONSTRAINT `fk_tenement_programme_of_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> exploration (1 constraint(s)) =========
-- Requires: workforce schema, exploration schema
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);

-- ========= workforce --> finance (6 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `mining_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ADD CONSTRAINT `fk_workforce_mobilisation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= workforce --> hse (2 constraint(s)) =========
-- Requires: workforce schema, hse schema
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ADD CONSTRAINT `fk_workforce_fatigue_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ADD CONSTRAINT `fk_workforce_labour_case_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= workforce --> mine (2 constraint(s)) =========
-- Requires: workforce schema, mine schema
ALTER TABLE `mining_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ADD CONSTRAINT `fk_workforce_accommodation_allocation_site_id` FOREIGN KEY (`site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);

-- ========= workforce --> processing (1 constraint(s)) =========
-- Requires: workforce schema, processing schema
ALTER TABLE `mining_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= workforce --> procurement (1 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `mining_ecm`.`procurement`.`procurement_vendor`(`procurement_vendor_id`);

-- ========= workforce --> project (2 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ADD CONSTRAINT `fk_workforce_workforce_project_contract_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ADD CONSTRAINT `fk_workforce_workforce_project_contract_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);

-- ========= workforce --> tenement (11 constraint(s)) =========
-- Requires: workforce schema, tenement schema
ALTER TABLE `mining_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`roster` ADD CONSTRAINT `fk_workforce_roster_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ADD CONSTRAINT `fk_workforce_training_enrolment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ADD CONSTRAINT `fk_workforce_medical_fitness_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ADD CONSTRAINT `fk_workforce_employment_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ADD CONSTRAINT `fk_workforce_labour_case_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ADD CONSTRAINT `fk_workforce_mobilisation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ADD CONSTRAINT `fk_workforce_contractor_tenement_engagement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

