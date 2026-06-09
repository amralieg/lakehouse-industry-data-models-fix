-- Cross-Domain Foreign Keys for Business: Agriculture | Version: v1_mvm
-- Generated on: 2026-05-01 18:45:54
-- Total cross-domain FK constraints: 1530
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: crop, customer, equipment, finance, inventory, invoice, land, livestock, procurement, product, quality, sales, supply, workforce

-- ========= crop --> customer (5 constraint(s)) =========
-- Requires: crop schema, customer schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= crop --> equipment (19 constraint(s)) =========
-- Requires: crop schema, equipment schema
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_fault_id` FOREIGN KEY (`fault_id`) REFERENCES `agriculture_ecm`.`equipment`.`fault`(`fault_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);

-- ========= crop --> finance (20 constraint(s)) =========
-- Requires: crop schema, finance schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= crop --> inventory (14 constraint(s)) =========
-- Requires: crop schema, inventory schema
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= crop --> land (29 constraint(s)) =========
-- Requires: crop schema, land schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_soil_sample_id` FOREIGN KEY (`soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`soil_sample`(`soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_soil_sample_id` FOREIGN KEY (`soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`soil_sample`(`soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);

-- ========= crop --> livestock (4 constraint(s)) =========
-- Requires: crop schema, livestock schema
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);

-- ========= crop --> procurement (13 constraint(s)) =========
-- Requires: crop schema, procurement schema
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `agriculture_ecm`.`procurement`.`budget`(`budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `agriculture_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `agriculture_ecm`.`procurement`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= crop --> product (31 constraint(s)) =========
-- Requires: crop schema, product schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);

-- ========= crop --> quality (12 constraint(s)) =========
-- Requires: crop schema, quality schema
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `agriculture_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);

-- ========= crop --> sales (3 constraint(s)) =========
-- Requires: crop schema, sales schema
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);

-- ========= crop --> workforce (21 constraint(s)) =========
-- Requires: crop schema, workforce schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> finance (8 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= customer --> inventory (1 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);

-- ========= customer --> invoice (3 constraint(s)) =========
-- Requires: customer schema, invoice schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);

-- ========= customer --> procurement (2 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= customer --> product (20 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `agriculture_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `agriculture_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_label_id` FOREIGN KEY (`label_id`) REFERENCES `agriculture_ecm`.`product`.`label`(`label_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `agriculture_ecm`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);

-- ========= customer --> sales (8 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `agriculture_ecm`.`sales`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);

-- ========= customer --> workforce (8 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_safety_event_id` FOREIGN KEY (`safety_event_id`) REFERENCES `agriculture_ecm`.`workforce`.`safety_event`(`safety_event_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= equipment --> crop (6 constraint(s)) =========
-- Requires: equipment schema, crop schema
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= equipment --> customer (5 constraint(s)) =========
-- Requires: equipment schema, customer schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);

-- ========= equipment --> finance (19 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `agriculture_ecm`.`finance`.`loan`(`loan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`precision_device` ADD CONSTRAINT `fk_equipment_precision_device_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= equipment --> inventory (4 constraint(s)) =========
-- Requires: equipment schema, inventory schema
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= equipment --> invoice (3 constraint(s)) =========
-- Requires: equipment schema, invoice schema
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_schedule`(`billing_schedule_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_schedule`(`billing_schedule_id`);

-- ========= equipment --> land (20 constraint(s)) =========
-- Requires: equipment schema, land schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_soil_sample_id` FOREIGN KEY (`soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`soil_sample`(`soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= equipment --> procurement (17 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `agriculture_ecm`.`procurement`.`budget`(`budget_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`precision_device` ADD CONSTRAINT `fk_equipment_precision_device_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`precision_device` ADD CONSTRAINT `fk_equipment_precision_device_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> product (3 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);

-- ========= equipment --> quality (6 constraint(s)) =========
-- Requires: equipment schema, quality schema
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `agriculture_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `agriculture_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);

-- ========= equipment --> sales (4 constraint(s)) =========
-- Requires: equipment schema, sales schema
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);

-- ========= equipment --> supply (11 constraint(s)) =========
-- Requires: equipment schema, supply schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= equipment --> workforce (15 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`field_operation` ADD CONSTRAINT `fk_equipment_field_operation_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`precision_device` ADD CONSTRAINT `fk_equipment_precision_device_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `agriculture_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_issue` ADD CONSTRAINT `fk_equipment_parts_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> land (16 constraint(s)) =========
-- Requires: finance schema, land schema
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);

-- ========= finance --> procurement (6 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> product (13 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= finance --> sales (5 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_market_price_id` FOREIGN KEY (`market_price_id`) REFERENCES `agriculture_ecm`.`sales`.`market_price`(`market_price_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);

-- ========= finance --> workforce (8 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_primary_capital_requestor_employee_id` FOREIGN KEY (`primary_capital_requestor_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_primary_period_employee_id` FOREIGN KEY (`primary_period_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_tertiary_profit_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_profit_last_modified_by_user_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> crop (3 constraint(s)) =========
-- Requires: inventory schema, crop schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);

-- ========= inventory --> customer (8 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= inventory --> equipment (7 constraint(s)) =========
-- Requires: inventory schema, equipment schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= inventory --> finance (41 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `agriculture_ecm`.`finance`.`loan`(`loan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `agriculture_ecm`.`finance`.`loan`(`loan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= inventory --> invoice (4 constraint(s)) =========
-- Requires: inventory schema, invoice schema
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);

-- ========= inventory --> land (11 constraint(s)) =========
-- Requires: inventory schema, land schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= inventory --> procurement (11 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `agriculture_ecm`.`procurement`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `agriculture_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> product (21 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);

-- ========= inventory --> quality (10 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= inventory --> sales (10 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);

-- ========= inventory --> supply (16 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= inventory --> workforce (11 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_work_assignment_id` FOREIGN KEY (`work_assignment_id`) REFERENCES `agriculture_ecm`.`workforce`.`work_assignment`(`work_assignment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= invoice --> crop (5 constraint(s)) =========
-- Requires: invoice schema, crop schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_harvest_event_id` FOREIGN KEY (`harvest_event_id`) REFERENCES `agriculture_ecm`.`crop`.`harvest_event`(`harvest_event_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);

-- ========= invoice --> customer (11 constraint(s)) =========
-- Requires: invoice schema, customer schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `agriculture_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_billing_customer_account_id` FOREIGN KEY (`billing_customer_account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= invoice --> equipment (2 constraint(s)) =========
-- Requires: invoice schema, equipment schema
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= invoice --> finance (42 constraint(s)) =========
-- Requires: invoice schema, finance schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `agriculture_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment_allocation` ADD CONSTRAINT `fk_invoice_payment_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment_allocation` ADD CONSTRAINT `fk_invoice_payment_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment_allocation` ADD CONSTRAINT `fk_invoice_payment_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment_term` ADD CONSTRAINT `fk_invoice_payment_term_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `agriculture_ecm`.`finance`.`loan`(`loan_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `agriculture_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= invoice --> inventory (16 constraint(s)) =========
-- Requires: invoice schema, inventory schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `agriculture_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `agriculture_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);

-- ========= invoice --> land (10 constraint(s)) =========
-- Requires: invoice schema, land schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `agriculture_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `agriculture_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `agriculture_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `agriculture_ecm`.`land`.`lease`(`lease_id`);

-- ========= invoice --> livestock (1 constraint(s)) =========
-- Requires: invoice schema, livestock schema
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_animal_transaction_id` FOREIGN KEY (`animal_transaction_id`) REFERENCES `agriculture_ecm`.`livestock`.`animal_transaction`(`animal_transaction_id`);

-- ========= invoice --> procurement (4 constraint(s)) =========
-- Requires: invoice schema, procurement schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);

-- ========= invoice --> product (22 constraint(s)) =========
-- Requires: invoice schema, product schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);

-- ========= invoice --> quality (12 constraint(s)) =========
-- Requires: invoice schema, quality schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `agriculture_ecm`.`quality`.`test_result`(`test_result_id`);

-- ========= invoice --> sales (18 constraint(s)) =========
-- Requires: invoice schema, sales schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_market_price_id` FOREIGN KEY (`market_price_id`) REFERENCES `agriculture_ecm`.`sales`.`market_price`(`market_price_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);

-- ========= invoice --> supply (20 constraint(s)) =========
-- Requires: invoice schema, supply schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_freight_booking_id` FOREIGN KEY (`freight_booking_id`) REFERENCES `agriculture_ecm`.`supply`.`freight_booking`(`freight_booking_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `agriculture_ecm`.`supply`.`service_contract`(`service_contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_shipment_line_id` FOREIGN KEY (`shipment_line_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment_line`(`shipment_line_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= invoice --> workforce (6 constraint(s)) =========
-- Requires: invoice schema, workforce schema
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `agriculture_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= land --> crop (1 constraint(s)) =========
-- Requires: land schema, crop schema
ALTER TABLE `agriculture_ecm`.`land`.`management_zone` ADD CONSTRAINT `fk_land_management_zone_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= land --> customer (6 constraint(s)) =========
-- Requires: land schema, customer schema
ALTER TABLE `agriculture_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`land`.`water_right` ADD CONSTRAINT `fk_land_water_right_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_operation` ADD CONSTRAINT `fk_land_farm_operation_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= land --> procurement (3 constraint(s)) =========
-- Requires: land schema, procurement schema
ALTER TABLE `agriculture_ecm`.`land`.`soil_sample` ADD CONSTRAINT `fk_land_soil_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`land`.`field_boundary` ADD CONSTRAINT `fk_land_field_boundary_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`land`.`conservation_practice` ADD CONSTRAINT `fk_land_conservation_practice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= land --> product (8 constraint(s)) =========
-- Requires: land schema, product schema
ALTER TABLE `agriculture_ecm`.`land`.`field` ADD CONSTRAINT `fk_land_field_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`land`.`field` ADD CONSTRAINT `fk_land_field_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`land`.`field` ADD CONSTRAINT `fk_land_field_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`land`.`management_zone` ADD CONSTRAINT `fk_land_management_zone_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`land`.`conservation_practice` ADD CONSTRAINT `fk_land_conservation_practice_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_operation` ADD CONSTRAINT `fk_land_farm_operation_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= land --> sales (2 constraint(s)) =========
-- Requires: land schema, sales schema
ALTER TABLE `agriculture_ecm`.`land`.`field` ADD CONSTRAINT `fk_land_field_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);

-- ========= land --> workforce (2 constraint(s)) =========
-- Requires: land schema, workforce schema
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_operation` ADD CONSTRAINT `fk_land_farm_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= livestock --> crop (1 constraint(s)) =========
-- Requires: livestock schema, crop schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);

-- ========= livestock --> customer (8 constraint(s)) =========
-- Requires: livestock schema, customer schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= livestock --> equipment (10 constraint(s)) =========
-- Requires: livestock schema, equipment schema
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= livestock --> finance (25 constraint(s)) =========
-- Requires: livestock schema, finance schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= livestock --> inventory (11 constraint(s)) =========
-- Requires: livestock schema, inventory schema
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`ration_ingredient` ADD CONSTRAINT `fk_livestock_ration_ingredient_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= livestock --> invoice (12 constraint(s)) =========
-- Requires: livestock schema, invoice schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_account`(`billing_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `agriculture_ecm`.`invoice`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_account`(`billing_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `agriculture_ecm`.`invoice`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `agriculture_ecm`.`invoice`.`settlement_statement`(`settlement_statement_id`);

-- ========= livestock --> land (4 constraint(s)) =========
-- Requires: livestock schema, land schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= livestock --> procurement (26 constraint(s)) =========
-- Requires: livestock schema, procurement schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`ration_ingredient` ADD CONSTRAINT `fk_livestock_ration_ingredient_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`ration_ingredient` ADD CONSTRAINT `fk_livestock_ration_ingredient_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);

-- ========= livestock --> product (10 constraint(s)) =========
-- Requires: livestock schema, product schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= livestock --> quality (22 constraint(s)) =========
-- Requires: livestock schema, quality schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`ration_ingredient` ADD CONSTRAINT `fk_livestock_ration_ingredient_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);

-- ========= livestock --> sales (17 constraint(s)) =========
-- Requires: livestock schema, sales schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `agriculture_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `agriculture_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);

-- ========= livestock --> supply (37 constraint(s)) =========
-- Requires: livestock schema, supply schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_herd_premises_facility_id` FOREIGN KEY (`herd_premises_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_transport_unit_id` FOREIGN KEY (`transport_unit_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_unit`(`transport_unit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `agriculture_ecm`.`supply`.`carrier`(`carrier_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_destination_premises_facility_id` FOREIGN KEY (`destination_premises_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_primary_animal_facility_id` FOREIGN KEY (`primary_animal_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_transport_unit_id` FOREIGN KEY (`transport_unit_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_unit`(`transport_unit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_transport_unit_id` FOREIGN KEY (`transport_unit_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_unit`(`transport_unit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= livestock --> workforce (25 constraint(s)) =========
-- Requires: livestock schema, workforce schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_herd_veterinarian_employee_id` FOREIGN KEY (`herd_veterinarian_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `agriculture_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> crop (6 constraint(s)) =========
-- Requires: procurement schema, crop schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_crop_id` FOREIGN KEY (`crop_id`) REFERENCES `agriculture_ecm`.`crop`.`crop`(`crop_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`chemical_compliance` ADD CONSTRAINT `fk_procurement_chemical_compliance_crop_id` FOREIGN KEY (`crop_id`) REFERENCES `agriculture_ecm`.`crop`.`crop`(`crop_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= procurement --> finance (26 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `agriculture_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= procurement --> inventory (9 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= procurement --> invoice (6 constraint(s)) =========
-- Requires: procurement schema, invoice schema
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);

-- ========= procurement --> land (11 constraint(s)) =========
-- Requires: procurement schema, land schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= procurement --> product (30 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`chemical_compliance` ADD CONSTRAINT `fk_procurement_chemical_compliance_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`chemical_compliance` ADD CONSTRAINT `fk_procurement_chemical_compliance_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= procurement --> quality (5 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);

-- ========= procurement --> supply (2 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= procurement --> workforce (12 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`chemical_compliance` ADD CONSTRAINT `fk_procurement_chemical_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `agriculture_ecm`.`workforce`.`position`(`position_id`);

-- ========= quality --> customer (9 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> equipment (3 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (13 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= quality --> inventory (11 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `agriculture_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= quality --> land (18 constraint(s)) =========
-- Requires: quality schema, land schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_soil_sample_id` FOREIGN KEY (`soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`soil_sample`(`soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);

-- ========= quality --> procurement (9 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= quality --> product (28 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `agriculture_ecm`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= quality --> sales (2 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);

-- ========= quality --> supply (8 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= quality --> workforce (16 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_safety_event_id` FOREIGN KEY (`safety_event_id`) REFERENCES `agriculture_ecm`.`workforce`.`safety_event`(`safety_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_safety_event_id` FOREIGN KEY (`safety_event_id`) REFERENCES `agriculture_ecm`.`workforce`.`safety_event`(`safety_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_training_event_id` FOREIGN KEY (`training_event_id`) REFERENCES `agriculture_ecm`.`workforce`.`training_event`(`training_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);

-- ========= sales --> crop (7 constraint(s)) =========
-- Requires: sales schema, crop schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ADD CONSTRAINT `fk_sales_market_price_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_harvest_event_id` FOREIGN KEY (`harvest_event_id`) REFERENCES `agriculture_ecm`.`crop`.`harvest_event`(`harvest_event_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);

-- ========= sales --> customer (26 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= sales --> finance (18 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ADD CONSTRAINT `fk_sales_distribution_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sales --> invoice (11 constraint(s)) =========
-- Requires: sales schema, invoice schema
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_account`(`billing_account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_account`(`billing_account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);

-- ========= sales --> land (7 constraint(s)) =========
-- Requires: sales schema, land schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= sales --> procurement (4 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= sales --> product (39 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ADD CONSTRAINT `fk_sales_market_price_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ADD CONSTRAINT `fk_sales_market_price_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= sales --> quality (8 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);

-- ========= sales --> supply (2 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `agriculture_ecm`.`supply`.`carrier`(`carrier_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= sales --> workforce (13 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_sales_manager_employee_id` FOREIGN KEY (`territory_sales_manager_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_sales_rep_employee_id` FOREIGN KEY (`territory_sales_rep_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ADD CONSTRAINT `fk_sales_distribution_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> crop (5 constraint(s)) =========
-- Requires: supply schema, crop schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_harvest_event_id` FOREIGN KEY (`harvest_event_id`) REFERENCES `agriculture_ecm`.`crop`.`harvest_event`(`harvest_event_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);

-- ========= supply --> customer (11 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= supply --> equipment (3 constraint(s)) =========
-- Requires: supply schema, equipment schema
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_field_operation_id` FOREIGN KEY (`field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`field_operation`(`field_operation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= supply --> finance (32 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_rate` ADD CONSTRAINT `fk_supply_freight_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= supply --> inventory (10 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `agriculture_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= supply --> land (4 constraint(s)) =========
-- Requires: supply schema, land schema
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);

-- ========= supply --> procurement (14 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `agriculture_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `agriculture_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `agriculture_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= supply --> product (35 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`route` ADD CONSTRAINT `fk_supply_route_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `agriculture_ecm`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_rate` ADD CONSTRAINT `fk_supply_freight_rate_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_unit` ADD CONSTRAINT `fk_supply_transport_unit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= supply --> quality (13 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);

-- ========= supply --> sales (14 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);

-- ========= supply --> workforce (8 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> crop (9 constraint(s)) =========
-- Requires: workforce schema, crop schema
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_crop_id` FOREIGN KEY (`crop_id`) REFERENCES `agriculture_ecm`.`crop`.`crop`(`crop_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= workforce --> equipment (5 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= workforce --> finance (25 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `agriculture_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `agriculture_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `agriculture_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> land (11 constraint(s)) =========
-- Requires: workforce schema, land schema
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);

-- ========= workforce --> livestock (7 constraint(s)) =========
-- Requires: workforce schema, livestock schema
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_pen_location_id` FOREIGN KEY (`pen_location_id`) REFERENCES `agriculture_ecm`.`livestock`.`pen_location`(`pen_location_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_pen_location_id` FOREIGN KEY (`pen_location_id`) REFERENCES `agriculture_ecm`.`livestock`.`pen_location`(`pen_location_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_animal_id` FOREIGN KEY (`animal_id`) REFERENCES `agriculture_ecm`.`livestock`.`animal`(`animal_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_pen_location_id` FOREIGN KEY (`pen_location_id`) REFERENCES `agriculture_ecm`.`livestock`.`pen_location`(`pen_location_id`);

-- ========= workforce --> procurement (5 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);

-- ========= workforce --> product (13 constraint(s)) =========
-- Requires: workforce schema, product schema
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= workforce --> quality (5 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);

-- ========= workforce --> supply (8 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

