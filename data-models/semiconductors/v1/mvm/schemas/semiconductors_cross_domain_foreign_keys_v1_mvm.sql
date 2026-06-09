-- Cross-Domain Foreign Keys for Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:07
-- Total cross-domain FK constraints: 1380
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: compliance, customer, design, equipment, fabrication, finance, inventory, order, process, product, quality, sales, supply, test

-- ========= compliance --> customer (4 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`export_license` ADD CONSTRAINT `fk_compliance_export_license_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`restricted_party_screening` ADD CONSTRAINT `fk_compliance_restricted_party_screening_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= compliance --> fabrication (3 constraint(s)) =========
-- Requires: compliance schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);

-- ========= compliance --> order (6 constraint(s)) =========
-- Requires: compliance schema, order schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`export_license_usage` ADD CONSTRAINT `fk_compliance_export_license_usage_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `semiconductors_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`compliance`.`trade_compliance_hold` ADD CONSTRAINT `fk_compliance_trade_compliance_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `semiconductors_ecm`.`order`.`shipment`(`shipment_id`);

-- ========= compliance --> product (1 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`technology_control_plan` ADD CONSTRAINT `fk_compliance_technology_control_plan_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);

-- ========= compliance --> sales (1 constraint(s)) =========
-- Requires: compliance schema, sales schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`restricted_party_screening` ADD CONSTRAINT `fk_compliance_restricted_party_screening_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);

-- ========= compliance --> supply (1 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`substance_inventory` ADD CONSTRAINT `fk_compliance_substance_inventory_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= compliance --> test (1 constraint(s)) =========
-- Requires: compliance schema, test schema
ALTER TABLE `semiconductors_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= customer --> compliance (6 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);

-- ========= customer --> equipment (4 constraint(s)) =========
-- Requires: customer schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= customer --> finance (18 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `semiconductors_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`distributor_agreement` ADD CONSTRAINT `fk_customer_distributor_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> inventory (2 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);

-- ========= customer --> process (4 constraint(s)) =========
-- Requires: customer schema, process schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);

-- ========= customer --> product (6 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);

-- ========= customer --> quality (2 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= customer --> sales (5 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `semiconductors_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`distributor_agreement` ADD CONSTRAINT `fk_customer_distributor_agreement_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `semiconductors_ecm`.`sales`.`quote`(`quote_id`);

-- ========= customer --> supply (7 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`sample_request` ADD CONSTRAINT `fk_customer_sample_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= customer --> test (3 constraint(s)) =========
-- Requires: customer schema, test schema
ALTER TABLE `semiconductors_ecm`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_reliability_test_run_id` FOREIGN KEY (`reliability_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`reliability_test_run`(`reliability_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= design --> compliance (14 constraint(s)) =========
-- Requires: design schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`eda_tool` ADD CONSTRAINT `fk_design_eda_tool_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`rule_set` ADD CONSTRAINT `fk_design_rule_set_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= design --> customer (6 constraint(s)) =========
-- Requires: design schema, customer schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_qualification_status_id` FOREIGN KEY (`qualification_status_id`) REFERENCES `semiconductors_ecm`.`customer`.`qualification_status`(`qualification_status_id`);

-- ========= design --> equipment (5 constraint(s)) =========
-- Requires: design schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_equipment_process_recipe_id` FOREIGN KEY (`equipment_process_recipe_id`) REFERENCES `semiconductors_ecm`.`equipment`.`equipment_process_recipe`(`equipment_process_recipe_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= design --> fabrication (5 constraint(s)) =========
-- Requires: design schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= design --> finance (21 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`eda_tool` ADD CONSTRAINT `fk_design_eda_tool_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`eda_tool` ADD CONSTRAINT `fk_design_eda_tool_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `semiconductors_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= design --> process (12 constraint(s)) =========
-- Requires: design schema, process schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `semiconductors_ecm`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `semiconductors_ecm`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `semiconductors_ecm`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);

-- ========= design --> product (17 constraint(s)) =========
-- Requires: design schema, product schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`netlist` ADD CONSTRAINT `fk_design_netlist_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`simulation_run` ADD CONSTRAINT `fk_design_simulation_run_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);

-- ========= design --> quality (1 constraint(s)) =========
-- Requires: design schema, quality schema
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `semiconductors_ecm`.`quality`.`test_plan`(`test_plan_id`);

-- ========= design --> supply (10 constraint(s)) =========
-- Requires: design schema, supply schema
ALTER TABLE `semiconductors_ecm`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`design_ip_core` ADD CONSTRAINT `fk_design_design_ip_core_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`physical_layout` ADD CONSTRAINT `fk_design_physical_layout_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`mpw_shuttle` ADD CONSTRAINT `fk_design_mpw_shuttle_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`design`.`eda_tool` ADD CONSTRAINT `fk_design_eda_tool_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= design --> test (1 constraint(s)) =========
-- Requires: design schema, test schema
ALTER TABLE `semiconductors_ecm`.`design`.`verification_plan` ADD CONSTRAINT `fk_design_verification_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= equipment --> compliance (14 constraint(s)) =========
-- Requires: equipment schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `semiconductors_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `semiconductors_ecm`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);

-- ========= equipment --> design (3 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= equipment --> fabrication (9 constraint(s)) =========
-- Requires: equipment schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);

-- ========= equipment --> finance (10 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= equipment --> inventory (2 constraint(s)) =========
-- Requires: equipment schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= equipment --> process (7 constraint(s)) =========
-- Requires: equipment schema, process schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_change_notification_id` FOREIGN KEY (`change_notification_id`) REFERENCES `semiconductors_ecm`.`process`.`change_notification`(`change_notification_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);

-- ========= equipment --> supply (8 constraint(s)) =========
-- Requires: equipment schema, supply schema
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= fabrication --> compliance (6 constraint(s)) =========
-- Requires: fabrication schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);

-- ========= fabrication --> customer (11 constraint(s)) =========
-- Requires: fabrication schema, customer schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= fabrication --> design (22 constraint(s)) =========
-- Requires: fabrication schema, design schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_rule_set_id` FOREIGN KEY (`rule_set_id`) REFERENCES `semiconductors_ecm`.`design`.`rule_set`(`rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_rule_set_id` FOREIGN KEY (`rule_set_id`) REFERENCES `semiconductors_ecm`.`design`.`rule_set`(`rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `semiconductors_ecm`.`design`.`revision`(`revision_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);

-- ========= fabrication --> equipment (9 constraint(s)) =========
-- Requires: fabrication schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= fabrication --> finance (23 constraint(s)) =========
-- Requires: fabrication schema, finance schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ADD CONSTRAINT `fk_fabrication_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= fabrication --> order (13 constraint(s)) =========
-- Requires: fabrication schema, order schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_mpw_order_id` FOREIGN KEY (`mpw_order_id`) REFERENCES `semiconductors_ecm`.`order`.`mpw_order`(`mpw_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_wafer_start_authorization_id` FOREIGN KEY (`wafer_start_authorization_id`) REFERENCES `semiconductors_ecm`.`order`.`wafer_start_authorization`(`wafer_start_authorization_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_mpw_order_id` FOREIGN KEY (`mpw_order_id`) REFERENCES `semiconductors_ecm`.`order`.`mpw_order`(`mpw_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_wafer_start_authorization_id` FOREIGN KEY (`wafer_start_authorization_id`) REFERENCES `semiconductors_ecm`.`order`.`wafer_start_authorization`(`wafer_start_authorization_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_nre_order_id` FOREIGN KEY (`nre_order_id`) REFERENCES `semiconductors_ecm`.`order`.`nre_order`(`nre_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_wafer_start_authorization_id` FOREIGN KEY (`wafer_start_authorization_id`) REFERENCES `semiconductors_ecm`.`order`.`wafer_start_authorization`(`wafer_start_authorization_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);

-- ========= fabrication --> process (29 constraint(s)) =========
-- Requires: fabrication schema, process schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_process_rework_target_step_id` FOREIGN KEY (`process_rework_target_step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_excursion_id` FOREIGN KEY (`excursion_id`) REFERENCES `semiconductors_ecm`.`process`.`excursion`(`excursion_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_yield_loss_event_id` FOREIGN KEY (`yield_loss_event_id`) REFERENCES `semiconductors_ecm`.`process`.`yield_loss_event`(`yield_loss_event_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);

-- ========= fabrication --> product (16 constraint(s)) =========
-- Requires: fabrication schema, product schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= fabrication --> quality (14 constraint(s)) =========
-- Requires: fabrication schema, quality schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `semiconductors_ecm`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `semiconductors_ecm`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `semiconductors_ecm`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`yield_record`(`yield_record_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);

-- ========= fabrication --> supply (13 constraint(s)) =========
-- Requires: fabrication schema, supply schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ADD CONSTRAINT `fk_fabrication_fabrication_process_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `semiconductors_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= fabrication --> test (4 constraint(s)) =========
-- Requires: fabrication schema, test schema
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `semiconductors_ecm`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);

-- ========= finance --> compliance (9 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);

-- ========= finance --> customer (2 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= finance --> design (1 constraint(s)) =========
-- Requires: finance schema, design schema
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= finance --> equipment (2 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= finance --> fabrication (13 constraint(s)) =========
-- Requires: finance schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);

-- ========= finance --> order (4 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wafer_start_authorization_id` FOREIGN KEY (`wafer_start_authorization_id`) REFERENCES `semiconductors_ecm`.`order`.`wafer_start_authorization`(`wafer_start_authorization_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `semiconductors_ecm`.`sales`.`booking`(`booking_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);

-- ========= finance --> supply (2 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= inventory --> compliance (17 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `semiconductors_ecm`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_conflict_minerals_declaration_id` FOREIGN KEY (`conflict_minerals_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`conflict_minerals_declaration`(`conflict_minerals_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_export_license_usage_id` FOREIGN KEY (`export_license_usage_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license_usage`(`export_license_usage_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_restricted_party_screening_id` FOREIGN KEY (`restricted_party_screening_id`) REFERENCES `semiconductors_ecm`.`compliance`.`restricted_party_screening`(`restricted_party_screening_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_trade_compliance_hold_id` FOREIGN KEY (`trade_compliance_hold_id`) REFERENCES `semiconductors_ecm`.`compliance`.`trade_compliance_hold`(`trade_compliance_hold_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);

-- ========= inventory --> customer (6 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= inventory --> design (13 constraint(s)) =========
-- Requires: inventory schema, design schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= inventory --> equipment (2 constraint(s)) =========
-- Requires: inventory schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= inventory --> fabrication (10 constraint(s)) =========
-- Requires: inventory schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);

-- ========= inventory --> finance (26 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= inventory --> order (4 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_wafer_start_authorization_id` FOREIGN KEY (`wafer_start_authorization_id`) REFERENCES `semiconductors_ecm`.`order`.`wafer_start_authorization`(`wafer_start_authorization_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);

-- ========= inventory --> product (51 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_compliance_cert_id` FOREIGN KEY (`compliance_cert_id`) REFERENCES `semiconductors_ecm`.`product`.`compliance_cert`(`compliance_cert_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_errata_id` FOREIGN KEY (`errata_id`) REFERENCES `semiconductors_ecm`.`product`.`errata`(`errata_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ltb_notification_id` FOREIGN KEY (`ltb_notification_id`) REFERENCES `semiconductors_ecm`.`product`.`ltb_notification`(`ltb_notification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_compliance_cert_id` FOREIGN KEY (`compliance_cert_id`) REFERENCES `semiconductors_ecm`.`product`.`compliance_cert`(`compliance_cert_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_configuration_rule_id` FOREIGN KEY (`configuration_rule_id`) REFERENCES `semiconductors_ecm`.`product`.`configuration_rule`(`configuration_rule_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_compliance_cert_id` FOREIGN KEY (`compliance_cert_id`) REFERENCES `semiconductors_ecm`.`product`.`compliance_cert`(`compliance_cert_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_configuration_rule_id` FOREIGN KEY (`configuration_rule_id`) REFERENCES `semiconductors_ecm`.`product`.`configuration_rule`(`configuration_rule_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ltb_notification_id` FOREIGN KEY (`ltb_notification_id`) REFERENCES `semiconductors_ecm`.`product`.`ltb_notification`(`ltb_notification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_configuration_rule_id` FOREIGN KEY (`configuration_rule_id`) REFERENCES `semiconductors_ecm`.`product`.`configuration_rule`(`configuration_rule_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_ltb_notification_id` FOREIGN KEY (`ltb_notification_id`) REFERENCES `semiconductors_ecm`.`product`.`ltb_notification`(`ltb_notification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_compliance_cert_id` FOREIGN KEY (`compliance_cert_id`) REFERENCES `semiconductors_ecm`.`product`.`compliance_cert`(`compliance_cert_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_errata_id` FOREIGN KEY (`errata_id`) REFERENCES `semiconductors_ecm`.`product`.`errata`(`errata_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_ltb_notification_id` FOREIGN KEY (`ltb_notification_id`) REFERENCES `semiconductors_ecm`.`product`.`ltb_notification`(`ltb_notification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_compliance_cert_id` FOREIGN KEY (`compliance_cert_id`) REFERENCES `semiconductors_ecm`.`product`.`compliance_cert`(`compliance_cert_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_errata_id` FOREIGN KEY (`errata_id`) REFERENCES `semiconductors_ecm`.`product`.`errata`(`errata_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_ltb_notification_id` FOREIGN KEY (`ltb_notification_id`) REFERENCES `semiconductors_ecm`.`product`.`ltb_notification`(`ltb_notification_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> quality (3 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);

-- ========= inventory --> supply (14 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`photomask_asset` ADD CONSTRAINT `fk_inventory_photomask_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `semiconductors_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`inventory_lot_hold` ADD CONSTRAINT `fk_inventory_inventory_lot_hold_supplier_corrective_action_id` FOREIGN KEY (`supplier_corrective_action_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier_corrective_action`(`supplier_corrective_action_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= inventory --> test (1 constraint(s)) =========
-- Requires: inventory schema, test schema
ALTER TABLE `semiconductors_ecm`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `semiconductors_ecm`.`test`.`probe_card`(`probe_card_id`);

-- ========= order --> compliance (16 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_restricted_party_screening_id` FOREIGN KEY (`restricted_party_screening_id`) REFERENCES `semiconductors_ecm`.`compliance`.`restricted_party_screening`(`restricted_party_screening_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);

-- ========= order --> customer (19 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `semiconductors_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `semiconductors_ecm`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `semiconductors_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);

-- ========= order --> design (9 constraint(s)) =========
-- Requires: order schema, design schema
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_mpw_shuttle_id` FOREIGN KEY (`mpw_shuttle_id`) REFERENCES `semiconductors_ecm`.`design`.`mpw_shuttle`(`mpw_shuttle_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ADD CONSTRAINT `fk_order_nre_milestone_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `semiconductors_ecm`.`design`.`milestone`(`milestone_id`);

-- ========= order --> equipment (3 constraint(s)) =========
-- Requires: order schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= order --> fabrication (1 constraint(s)) =========
-- Requires: order schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= order --> finance (6 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_finance_nre_agreement_id` FOREIGN KEY (`finance_nre_agreement_id`) REFERENCES `semiconductors_ecm`.`finance`.`finance_nre_agreement`(`finance_nre_agreement_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= order --> inventory (11 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= order --> process (9 constraint(s)) =========
-- Requires: order schema, process schema
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);

-- ========= order --> product (17 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= order --> quality (12 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `semiconductors_ecm`.`quality`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);

-- ========= order --> sales (10 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `semiconductors_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `semiconductors_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `semiconductors_ecm`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);

-- ========= order --> supply (11 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= order --> test (3 constraint(s)) =========
-- Requires: order schema, test schema
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= process --> compliance (8 constraint(s)) =========
-- Requires: process schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `semiconductors_ecm`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `semiconductors_ecm`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ADD CONSTRAINT `fk_process_opc_rule_set_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= process --> customer (5 constraint(s)) =========
-- Requires: process schema, customer schema
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_customer_design_registration_id` FOREIGN KEY (`customer_design_registration_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_registration`(`customer_design_registration_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `semiconductors_ecm`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= process --> design (1 constraint(s)) =========
-- Requires: process schema, design schema
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);

-- ========= process --> equipment (25 constraint(s)) =========
-- Requires: process schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_metrology_run_id` FOREIGN KEY (`metrology_run_id`) REFERENCES `semiconductors_ecm`.`equipment`.`metrology_run`(`metrology_run_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_event`(`maintenance_event_id`);

-- ========= process --> fabrication (26 constraint(s)) =========
-- Requires: process schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);

-- ========= process --> finance (15 constraint(s)) =========
-- Requires: process schema, finance schema
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ADD CONSTRAINT `fk_process_opc_rule_set_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= process --> inventory (5 constraint(s)) =========
-- Requires: process schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `semiconductors_ecm`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= process --> order (2 constraint(s)) =========
-- Requires: process schema, order schema
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `semiconductors_ecm`.`order`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);

-- ========= process --> product (19 constraint(s)) =========
-- Requires: process schema, product schema
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ADD CONSTRAINT `fk_process_process_technology_node_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= process --> quality (9 constraint(s)) =========
-- Requires: process schema, quality schema
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);

-- ========= process --> sales (2 constraint(s)) =========
-- Requires: process schema, sales schema
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `semiconductors_ecm`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `semiconductors_ecm`.`sales`.`booking`(`booking_id`);

-- ========= process --> supply (9 constraint(s)) =========
-- Requires: process schema, supply schema
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ADD CONSTRAINT `fk_process_recipe_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= product --> compliance (11 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ADD CONSTRAINT `fk_product_ltb_notification_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `semiconductors_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= product --> customer (2 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= product --> design (1 constraint(s)) =========
-- Requires: product schema, design schema
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);

-- ========= product --> equipment (1 constraint(s)) =========
-- Requires: product schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= product --> finance (22 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ADD CONSTRAINT `fk_product_process_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ADD CONSTRAINT `fk_product_process_node_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ADD CONSTRAINT `fk_product_process_node_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= product --> process (2 constraint(s)) =========
-- Requires: product schema, process schema
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_change_notification_id` FOREIGN KEY (`change_notification_id`) REFERENCES `semiconductors_ecm`.`process`.`change_notification`(`change_notification_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);

-- ========= product --> supply (5 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= product --> test (2 constraint(s)) =========
-- Requires: product schema, test schema
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_case_id` FOREIGN KEY (`case_id`) REFERENCES `semiconductors_ecm`.`test`.`case`(`case_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= quality --> compliance (12 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_restricted_party_screening_id` FOREIGN KEY (`restricted_party_screening_id`) REFERENCES `semiconductors_ecm`.`compliance`.`restricted_party_screening`(`restricted_party_screening_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= quality --> customer (8 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> design (28 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `semiconductors_ecm`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `semiconductors_ecm`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= quality --> equipment (36 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= quality --> fabrication (30 constraint(s)) =========
-- Requires: quality schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);

-- ========= quality --> finance (29 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (15 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `semiconductors_ecm`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `semiconductors_ecm`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);

-- ========= quality --> order (3 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);

-- ========= quality --> process (9 constraint(s)) =========
-- Requires: quality schema, process schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `semiconductors_ecm`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);

-- ========= quality --> product (32 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= quality --> sales (2 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);

-- ========= quality --> supply (15 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_approved_vendor_id` FOREIGN KEY (`approved_vendor_id`) REFERENCES `semiconductors_ecm`.`supply`.`approved_vendor`(`approved_vendor_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `semiconductors_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `semiconductors_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= quality --> test (20 constraint(s)) =========
-- Requires: quality schema, test schema
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_reliability_test_run_id` FOREIGN KEY (`reliability_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`reliability_test_run`(`reliability_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);

-- ========= sales --> compliance (16 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_chips_act_obligation_id` FOREIGN KEY (`chips_act_obligation_id`) REFERENCES `semiconductors_ecm`.`compliance`.`chips_act_obligation`(`chips_act_obligation_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_restricted_party_screening_id` FOREIGN KEY (`restricted_party_screening_id`) REFERENCES `semiconductors_ecm`.`compliance`.`restricted_party_screening`(`restricted_party_screening_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= sales --> customer (16 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `semiconductors_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `semiconductors_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `semiconductors_ecm`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `semiconductors_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_address_id` FOREIGN KEY (`address_id`) REFERENCES `semiconductors_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `semiconductors_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `semiconductors_ecm`.`customer`.`segment`(`segment_id`);

-- ========= sales --> design (8 constraint(s)) =========
-- Requires: sales schema, design schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `semiconductors_ecm`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_design_ip_core_id` FOREIGN KEY (`design_ip_core_id`) REFERENCES `semiconductors_ecm`.`design`.`design_ip_core`(`design_ip_core_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= sales --> equipment (5 constraint(s)) =========
-- Requires: sales schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= sales --> fabrication (8 constraint(s)) =========
-- Requires: sales schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);

-- ========= sales --> finance (11 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= sales --> inventory (7 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `semiconductors_ecm`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `semiconductors_ecm`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `semiconductors_ecm`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= sales --> process (11 constraint(s)) =========
-- Requires: sales schema, process schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);

-- ========= sales --> product (24 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= sales --> quality (5 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);

-- ========= sales --> supply (16 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `semiconductors_ecm`.`supply`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= sales --> test (1 constraint(s)) =========
-- Requires: sales schema, test schema
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= supply --> compliance (18 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_substance_inventory_id` FOREIGN KEY (`substance_inventory_id`) REFERENCES `semiconductors_ecm`.`compliance`.`substance_inventory`(`substance_inventory_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_export_license_usage_id` FOREIGN KEY (`export_license_usage_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license_usage`(`export_license_usage_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_audit` ADD CONSTRAINT `fk_supply_supplier_audit_obligation_register_id` FOREIGN KEY (`obligation_register_id`) REFERENCES `semiconductors_ecm`.`compliance`.`obligation_register`(`obligation_register_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_reach_svhc_declaration_id` FOREIGN KEY (`reach_svhc_declaration_id`) REFERENCES `semiconductors_ecm`.`compliance`.`reach_svhc_declaration`(`reach_svhc_declaration_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supply_forecast` ADD CONSTRAINT `fk_supply_supply_forecast_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `semiconductors_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= supply --> finance (13 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_audit` ADD CONSTRAINT `fk_supply_supplier_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_corrective_action` ADD CONSTRAINT `fk_supply_supplier_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= supply --> product (14 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `semiconductors_ecm`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`risk_assessment` ADD CONSTRAINT `fk_supply_risk_assessment_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`sourcing_contract` ADD CONSTRAINT `fk_supply_sourcing_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`osat_work_order` ADD CONSTRAINT `fk_supply_osat_work_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supplier_corrective_action` ADD CONSTRAINT `fk_supply_supplier_corrective_action_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`supply`.`supply_forecast` ADD CONSTRAINT `fk_supply_supply_forecast_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= test --> compliance (8 constraint(s)) =========
-- Requires: test schema, compliance schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_export_license_id` FOREIGN KEY (`export_license_id`) REFERENCES `semiconductors_ecm`.`compliance`.`export_license`(`export_license_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_eccn_classification_id` FOREIGN KEY (`eccn_classification_id`) REFERENCES `semiconductors_ecm`.`compliance`.`eccn_classification`(`eccn_classification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`case` ADD CONSTRAINT `fk_test_case_technology_control_plan_id` FOREIGN KEY (`technology_control_plan_id`) REFERENCES `semiconductors_ecm`.`compliance`.`technology_control_plan`(`technology_control_plan_id`);

-- ========= test --> customer (4 constraint(s)) =========
-- Requires: test schema, customer schema
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `semiconductors_ecm`.`customer`.`account`(`account_id`);

-- ========= test --> design (15 constraint(s)) =========
-- Requires: test schema, design schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_eda_tool_id` FOREIGN KEY (`eda_tool_id`) REFERENCES `semiconductors_ecm`.`design`.`eda_tool`(`eda_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `semiconductors_ecm`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_rtl_specification_id` FOREIGN KEY (`rtl_specification_id`) REFERENCES `semiconductors_ecm`.`design`.`rtl_specification`(`rtl_specification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `semiconductors_ecm`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `semiconductors_ecm`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `semiconductors_ecm`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `semiconductors_ecm`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_verification_plan_id` FOREIGN KEY (`verification_plan_id`) REFERENCES `semiconductors_ecm`.`design`.`verification_plan`(`verification_plan_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `semiconductors_ecm`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= test --> equipment (8 constraint(s)) =========
-- Requires: test schema, equipment schema
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `semiconductors_ecm`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ADD CONSTRAINT `fk_test_insertion_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= test --> fabrication (10 constraint(s)) =========
-- Requires: test schema, fabrication schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= test --> finance (14 constraint(s)) =========
-- Requires: test schema, finance schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= test --> inventory (6 constraint(s)) =========
-- Requires: test schema, inventory schema
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `semiconductors_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= test --> order (3 constraint(s)) =========
-- Requires: test schema, order schema
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);

-- ========= test --> process (16 constraint(s)) =========
-- Requires: test schema, process schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_excursion_id` FOREIGN KEY (`excursion_id`) REFERENCES `semiconductors_ecm`.`process`.`excursion`(`excursion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `semiconductors_ecm`.`process`.`qualification`(`qualification_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);

-- ========= test --> product (14 constraint(s)) =========
-- Requires: test schema, product schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_coverage_ic_catalog_id` FOREIGN KEY (`coverage_ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);

-- ========= test --> supply (5 constraint(s)) =========
-- Requires: test schema, supply schema
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `semiconductors_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `semiconductors_ecm`.`supply`.`supplier`(`supplier_id`);

