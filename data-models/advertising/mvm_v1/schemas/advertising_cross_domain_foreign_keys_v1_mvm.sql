-- Cross-Domain Foreign Keys for Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:19
-- Total cross-domain FK constraints: 579
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: audience, campaign, client, contract, creative, finance, media, performance, project, vendor

-- ========= audience --> campaign (6 constraint(s)) =========
-- Requires: audience schema, campaign schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);

-- ========= audience --> client (5 constraint(s)) =========
-- Requires: audience schema, client schema
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= audience --> contract (7 constraint(s)) =========
-- Requires: audience schema, contract schema
ALTER TABLE `advertising_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= audience --> creative (2 constraint(s)) =========
-- Requires: audience schema, creative schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);

-- ========= audience --> finance (6 constraint(s)) =========
-- Requires: audience schema, finance schema
ALTER TABLE `advertising_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= audience --> project (4 constraint(s)) =========
-- Requires: audience schema, project schema
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= audience --> vendor (11 constraint(s)) =========
-- Requires: audience schema, vendor schema
ALTER TABLE `advertising_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ADD CONSTRAINT `fk_audience_demographic_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);

-- ========= campaign --> audience (3 constraint(s)) =========
-- Requires: campaign schema, audience schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ADD CONSTRAINT `fk_campaign_targeting_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);

-- ========= campaign --> client (3 constraint(s)) =========
-- Requires: campaign schema, client schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= campaign --> contract (6 constraint(s)) =========
-- Requires: campaign schema, contract schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);

-- ========= campaign --> creative (6 constraint(s)) =========
-- Requires: campaign schema, creative schema
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);

-- ========= campaign --> finance (4 constraint(s)) =========
-- Requires: campaign schema, finance schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= campaign --> media (8 constraint(s)) =========
-- Requires: campaign schema, media schema
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);

-- ========= campaign --> performance (1 constraint(s)) =========
-- Requires: campaign schema, performance schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `advertising_ecm`.`performance`.`attribution_model`(`attribution_model_id`);

-- ========= campaign --> project (5 constraint(s)) =========
-- Requires: campaign schema, project schema
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_deliverable_tracker_id` FOREIGN KEY (`deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);

-- ========= campaign --> vendor (8 constraint(s)) =========
-- Requires: campaign schema, vendor schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);

-- ========= client --> audience (3 constraint(s)) =========
-- Requires: client schema, audience schema
ALTER TABLE `advertising_ecm`.`client`.`advertiser` ADD CONSTRAINT `fk_client_advertiser_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);

-- ========= client --> contract (3 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ADD CONSTRAINT `fk_client_agency_relationship_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= client --> finance (5 constraint(s)) =========
-- Requires: client schema, finance schema
ALTER TABLE `advertising_ecm`.`client`.`advertiser_hierarchy` ADD CONSTRAINT `fk_client_advertiser_hierarchy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`client`.`brand` ADD CONSTRAINT `fk_client_brand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= client --> performance (1 constraint(s)) =========
-- Requires: client schema, performance schema
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `advertising_ecm`.`performance`.`attribution_model`(`attribution_model_id`);

-- ========= client --> project (2 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= client --> vendor (3 constraint(s)) =========
-- Requires: client schema, vendor schema
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ADD CONSTRAINT `fk_client_agency_relationship_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= contract --> campaign (3 constraint(s)) =========
-- Requires: contract schema, campaign schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= contract --> client (14 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_sow_client_advertiser_id` FOREIGN KEY (`sow_client_advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);

-- ========= contract --> creative (1 constraint(s)) =========
-- Requires: contract schema, creative schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);

-- ========= contract --> finance (7 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= contract --> media (4 constraint(s)) =========
-- Requires: contract schema, media schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ADD CONSTRAINT `fk_contract_rate_card_line_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ADD CONSTRAINT `fk_contract_rate_card_line_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);

-- ========= contract --> project (1 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= contract --> vendor (6 constraint(s)) =========
-- Requires: contract schema, vendor schema
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= creative --> audience (6 constraint(s)) =========
-- Requires: creative schema, audience schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);

-- ========= creative --> campaign (4 constraint(s)) =========
-- Requires: creative schema, campaign schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= creative --> client (9 constraint(s)) =========
-- Requires: creative schema, client schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ADD CONSTRAINT `fk_creative_brand_guideline_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= creative --> contract (10 constraint(s)) =========
-- Requires: creative schema, contract schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `advertising_ecm`.`contract`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `advertising_ecm`.`contract`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= creative --> finance (5 constraint(s)) =========
-- Requires: creative schema, finance schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= creative --> media (5 constraint(s)) =========
-- Requires: creative schema, media schema
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`creative`.`spec` ADD CONSTRAINT `fk_creative_spec_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= creative --> project (27 constraint(s)) =========
-- Requires: creative schema, project schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_project_brief_id` FOREIGN KEY (`project_brief_id`) REFERENCES `advertising_ecm`.`project`.`project_brief`(`project_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_deliverable_tracker_id` FOREIGN KEY (`deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_project_brief_id` FOREIGN KEY (`project_brief_id`) REFERENCES `advertising_ecm`.`project`.`project_brief`(`project_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_deliverable_tracker_id` FOREIGN KEY (`deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_deliverable_tracker_id` FOREIGN KEY (`deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);

-- ========= creative --> vendor (7 constraint(s)) =========
-- Requires: creative schema, vendor schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset` ADD CONSTRAINT `fk_creative_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`spec` ADD CONSTRAINT `fk_creative_spec_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= finance --> campaign (10 constraint(s)) =========
-- Requires: finance schema, campaign schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);

-- ========= finance --> client (11 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_client_brief_id` FOREIGN KEY (`client_brief_id`) REFERENCES `advertising_ecm`.`client`.`client_brief`(`client_brief_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= finance --> contract (9 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `advertising_ecm`.`contract`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= finance --> creative (2 constraint(s)) =========
-- Requires: finance schema, creative schema
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);

-- ========= finance --> media (22 constraint(s)) =========
-- Requires: finance schema, media schema
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `advertising_ecm`.`media`.`schedule`(`schedule_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `advertising_ecm`.`media`.`schedule`(`schedule_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);

-- ========= finance --> performance (18 constraint(s)) =========
-- Requires: finance schema, performance schema
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_delivery_pacing_id` FOREIGN KEY (`delivery_pacing_id`) REFERENCES `advertising_ecm`.`performance`.`delivery_pacing`(`delivery_pacing_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_delivery_pacing_id` FOREIGN KEY (`delivery_pacing_id`) REFERENCES `advertising_ecm`.`performance`.`delivery_pacing`(`delivery_pacing_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_viewability_measurement_id` FOREIGN KEY (`viewability_measurement_id`) REFERENCES `advertising_ecm`.`performance`.`viewability_measurement`(`viewability_measurement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_delivery_pacing_id` FOREIGN KEY (`delivery_pacing_id`) REFERENCES `advertising_ecm`.`performance`.`delivery_pacing`(`delivery_pacing_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_video_completion_event_id` FOREIGN KEY (`video_completion_event_id`) REFERENCES `advertising_ecm`.`performance`.`video_completion_event`(`video_completion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_viewability_measurement_id` FOREIGN KEY (`viewability_measurement_id`) REFERENCES `advertising_ecm`.`performance`.`viewability_measurement`(`viewability_measurement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_delivery_pacing_id` FOREIGN KEY (`delivery_pacing_id`) REFERENCES `advertising_ecm`.`performance`.`delivery_pacing`(`delivery_pacing_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `advertising_ecm`.`performance`.`conversion_event`(`conversion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_delivery_pacing_id` FOREIGN KEY (`delivery_pacing_id`) REFERENCES `advertising_ecm`.`performance`.`delivery_pacing`(`delivery_pacing_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_video_completion_event_id` FOREIGN KEY (`video_completion_event_id`) REFERENCES `advertising_ecm`.`performance`.`video_completion_event`(`video_completion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_viewability_measurement_id` FOREIGN KEY (`viewability_measurement_id`) REFERENCES `advertising_ecm`.`performance`.`viewability_measurement`(`viewability_measurement_id`);

-- ========= finance --> project (6 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_deliverable_tracker_id` FOREIGN KEY (`deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);

-- ========= finance --> vendor (16 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `advertising_ecm`.`vendor`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `advertising_ecm`.`vendor`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `advertising_ecm`.`vendor`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `advertising_ecm`.`vendor`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);

-- ========= media --> audience (12 constraint(s)) =========
-- Requires: media schema, audience schema
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_suppression_list_id` FOREIGN KEY (`suppression_list_id`) REFERENCES `advertising_ecm`.`audience`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ADD CONSTRAINT `fk_media_ad_channel_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ADD CONSTRAINT `fk_media_publisher_property_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ADD CONSTRAINT `fk_media_publisher_property_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);

-- ========= media --> campaign (6 constraint(s)) =========
-- Requires: media schema, campaign schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= media --> client (8 constraint(s)) =========
-- Requires: media schema, client schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= media --> contract (10 constraint(s)) =========
-- Requires: media schema, contract schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= media --> creative (11 constraint(s)) =========
-- Requires: media schema, creative schema
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);

-- ========= media --> finance (20 constraint(s)) =========
-- Requires: media schema, finance schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ADD CONSTRAINT `fk_media_ad_channel_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= media --> project (4 constraint(s)) =========
-- Requires: media schema, project schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= media --> vendor (14 constraint(s)) =========
-- Requires: media schema, vendor schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ADD CONSTRAINT `fk_media_ad_channel_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ADD CONSTRAINT `fk_media_publisher_property_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);

-- ========= performance --> audience (11 constraint(s)) =========
-- Requires: performance schema, audience schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `advertising_ecm`.`audience`.`activation`(`activation_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_lookalike_model_id` FOREIGN KEY (`lookalike_model_id`) REFERENCES `advertising_ecm`.`audience`.`lookalike_model`(`lookalike_model_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_suppression_list_id` FOREIGN KEY (`suppression_list_id`) REFERENCES `advertising_ecm`.`audience`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_lookalike_model_id` FOREIGN KEY (`lookalike_model_id`) REFERENCES `advertising_ecm`.`audience`.`lookalike_model`(`lookalike_model_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `advertising_ecm`.`audience`.`activation`(`activation_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);

-- ========= performance --> campaign (32 constraint(s)) =========
-- Requires: performance schema, campaign schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_pacing_rule_id` FOREIGN KEY (`pacing_rule_id`) REFERENCES `advertising_ecm`.`campaign`.`pacing_rule`(`pacing_rule_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_campaign_kpi_target_id` FOREIGN KEY (`campaign_kpi_target_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign_kpi_target`(`campaign_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);

-- ========= performance --> client (12 constraint(s)) =========
-- Requires: performance schema, client schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ADD CONSTRAINT `fk_performance_attribution_model_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ADD CONSTRAINT `fk_performance_attribution_model_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ADD CONSTRAINT `fk_performance_attribution_model_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_revenue_target_id` FOREIGN KEY (`revenue_target_id`) REFERENCES `advertising_ecm`.`client`.`revenue_target`(`revenue_target_id`);

-- ========= performance --> contract (8 constraint(s)) =========
-- Requires: performance schema, contract schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);

-- ========= performance --> creative (11 constraint(s)) =========
-- Requires: performance schema, creative schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `advertising_ecm`.`creative`.`asset`(`asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);

-- ========= performance --> media (22 constraint(s)) =========
-- Requires: performance schema, media schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);

-- ========= performance --> project (1 constraint(s)) =========
-- Requires: performance schema, project schema
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_deliverable_tracker_id` FOREIGN KEY (`deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);

-- ========= performance --> vendor (10 constraint(s)) =========
-- Requires: performance schema, vendor schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ADD CONSTRAINT `fk_performance_attribution_model_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);

-- ========= project --> audience (3 constraint(s)) =========
-- Requires: project schema, audience schema
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);

-- ========= project --> campaign (3 constraint(s)) =========
-- Requires: project schema, campaign schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= project --> client (7 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_client_brief_id` FOREIGN KEY (`client_brief_id`) REFERENCES `advertising_ecm`.`client`.`client_brief`(`client_brief_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= project --> contract (17 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `advertising_ecm`.`contract`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `advertising_ecm`.`contract`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_rate_card_line_id` FOREIGN KEY (`rate_card_line_id`) REFERENCES `advertising_ecm`.`contract`.`rate_card_line`(`rate_card_line_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= project --> finance (9 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= project --> media (3 constraint(s)) =========
-- Requires: project schema, media schema
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= project --> performance (1 constraint(s)) =========
-- Requires: project schema, performance schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `advertising_ecm`.`performance`.`attribution_model`(`attribution_model_id`);

-- ========= project --> vendor (6 constraint(s)) =========
-- Requires: project schema, vendor schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);

-- ========= vendor --> campaign (10 constraint(s)) =========
-- Requires: vendor schema, campaign schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= vendor --> client (6 constraint(s)) =========
-- Requires: vendor schema, client schema
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `advertising_ecm`.`client`.`brand`(`brand_id`);

-- ========= vendor --> contract (7 constraint(s)) =========
-- Requires: vendor schema, contract schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= vendor --> creative (3 constraint(s)) =========
-- Requires: vendor schema, creative schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `advertising_ecm`.`creative`.`spec`(`spec_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);

-- ========= vendor --> media (3 constraint(s)) =========
-- Requires: vendor schema, media schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);

-- ========= vendor --> project (4 constraint(s)) =========
-- Requires: vendor schema, project schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

