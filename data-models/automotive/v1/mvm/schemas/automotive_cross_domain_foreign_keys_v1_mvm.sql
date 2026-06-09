-- Cross-Domain Foreign Keys for Business: Automotive | Version: v1_mvm
-- Generated on: 2026-05-07 02:20:11
-- Total cross-domain FK constraints: 906
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: aftersales, billing, compliance, customer, dealer, engineering, finance, inventory, logistics, manufacturing, quality, sales, supply, vehicle

-- ========= aftersales --> compliance (7 constraint(s)) =========
-- Requires: aftersales schema, compliance schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `automotive_ecm`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `automotive_ecm`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ADD CONSTRAINT `fk_aftersales_service_center_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= aftersales --> customer (10 constraint(s)) =========
-- Requires: aftersales schema, customer schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= aftersales --> dealer (11 constraint(s)) =========
-- Requires: aftersales schema, dealer schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_tertiary_service_transfer_to_dealer_dealership_id` FOREIGN KEY (`tertiary_service_transfer_to_dealer_dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ADD CONSTRAINT `fk_aftersales_service_center_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ADD CONSTRAINT `fk_aftersales_parts_return_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= aftersales --> engineering (23 constraint(s)) =========
-- Requires: aftersales schema, engineering schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_powertrain_spec_id` FOREIGN KEY (`powertrain_spec_id`) REFERENCES `automotive_ecm`.`engineering`.`powertrain_spec`(`powertrain_spec_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `automotive_ecm`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `automotive_ecm`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_validation_test_id` FOREIGN KEY (`validation_test_id`) REFERENCES `automotive_ecm`.`engineering`.`validation_test`(`validation_test_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ADD CONSTRAINT `fk_aftersales_labor_time_standard_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ADD CONSTRAINT `fk_aftersales_service_part_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ADD CONSTRAINT `fk_aftersales_parts_return_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);

-- ========= aftersales --> finance (20 constraint(s)) =========
-- Requires: aftersales schema, finance schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ADD CONSTRAINT `fk_aftersales_service_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ADD CONSTRAINT `fk_aftersales_parts_return_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= aftersales --> inventory (6 constraint(s)) =========
-- Requires: aftersales schema, inventory schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ADD CONSTRAINT `fk_aftersales_parts_order_line_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `automotive_ecm`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ADD CONSTRAINT `fk_aftersales_parts_return_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= aftersales --> logistics (1 constraint(s)) =========
-- Requires: aftersales schema, logistics schema
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `automotive_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= aftersales --> manufacturing (11 constraint(s)) =========
-- Requires: aftersales schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `automotive_ecm`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `automotive_ecm`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ADD CONSTRAINT `fk_aftersales_labor_time_standard_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `automotive_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ADD CONSTRAINT `fk_aftersales_service_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= aftersales --> quality (6 constraint(s)) =========
-- Requires: aftersales schema, quality schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `automotive_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `automotive_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `automotive_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `automotive_ecm`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ADD CONSTRAINT `fk_aftersales_parts_return_supplier_quality_event_id` FOREIGN KEY (`supplier_quality_event_id`) REFERENCES `automotive_ecm`.`quality`.`supplier_quality_event`(`supplier_quality_event_id`);

-- ========= aftersales --> sales (1 constraint(s)) =========
-- Requires: aftersales schema, sales schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= aftersales --> supply (5 constraint(s)) =========
-- Requires: aftersales schema, supply schema
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `automotive_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ADD CONSTRAINT `fk_aftersales_service_part_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `automotive_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= aftersales --> vehicle (15 constraint(s)) =========
-- Requires: aftersales schema, vehicle schema
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_build_spec_id` FOREIGN KEY (`build_spec_id`) REFERENCES `automotive_ecm`.`vehicle`.`build_spec`(`build_spec_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ADD CONSTRAINT `fk_aftersales_campaign_vin_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_ecu_catalog_id` FOREIGN KEY (`ecu_catalog_id`) REFERENCES `automotive_ecm`.`vehicle`.`ecu_catalog`(`ecu_catalog_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ADD CONSTRAINT `fk_aftersales_labor_time_standard_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= billing --> aftersales (9 constraint(s)) =========
-- Requires: billing schema, aftersales schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_contract`(`service_contract_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_aftersales_service_appointment_id` FOREIGN KEY (`aftersales_service_appointment_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_service_appointment`(`aftersales_service_appointment_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_aftersales_warranty_claim_id` FOREIGN KEY (`aftersales_warranty_claim_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_warranty_claim`(`aftersales_warranty_claim_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_goodwill_adjustment_id` FOREIGN KEY (`goodwill_adjustment_id`) REFERENCES `automotive_ecm`.`aftersales`.`goodwill_adjustment`(`goodwill_adjustment_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_parts_order_id` FOREIGN KEY (`parts_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`parts_order`(`parts_order_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_parts_return_id` FOREIGN KEY (`parts_return_id`) REFERENCES `automotive_ecm`.`aftersales`.`parts_return`(`parts_return_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_repair_order_line_id` FOREIGN KEY (`repair_order_line_id`) REFERENCES `automotive_ecm`.`aftersales`.`repair_order_line`(`repair_order_line_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_contract_claim_id` FOREIGN KEY (`service_contract_claim_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_contract_claim`(`service_contract_claim_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_part_id` FOREIGN KEY (`service_part_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_part`(`service_part_id`);

-- ========= billing --> compliance (4 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `automotive_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ADD CONSTRAINT `fk_billing_dealer_statement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ADD CONSTRAINT `fk_billing_tax_code_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= billing --> customer (5 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_invoice_party_id` FOREIGN KEY (`invoice_party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_payer_entity_party_id` FOREIGN KEY (`payment_payer_entity_party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= billing --> dealer (10 constraint(s)) =========
-- Requires: billing schema, dealer schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_invoice_dealership_id` FOREIGN KEY (`invoice_dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_dealer_incentive_claim_id` FOREIGN KEY (`dealer_incentive_claim_id`) REFERENCES `automotive_ecm`.`dealer`.`dealer_incentive_claim`(`dealer_incentive_claim_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_dealer_inventory_id` FOREIGN KEY (`dealer_inventory_id`) REFERENCES `automotive_ecm`.`dealer`.`dealer_inventory`(`dealer_inventory_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_parts_inventory_id` FOREIGN KEY (`parts_inventory_id`) REFERENCES `automotive_ecm`.`dealer`.`parts_inventory`(`parts_inventory_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_recall_completion_id` FOREIGN KEY (`recall_completion_id`) REFERENCES `automotive_ecm`.`dealer`.`recall_completion`(`recall_completion_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_dealer_incentive_claim_id` FOREIGN KEY (`dealer_incentive_claim_id`) REFERENCES `automotive_ecm`.`dealer`.`dealer_incentive_claim`(`dealer_incentive_claim_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_dealer_warranty_claim_id` FOREIGN KEY (`dealer_warranty_claim_id`) REFERENCES `automotive_ecm`.`dealer`.`dealer_warranty_claim`(`dealer_warranty_claim_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_recall_completion_id` FOREIGN KEY (`recall_completion_id`) REFERENCES `automotive_ecm`.`dealer`.`recall_completion`(`recall_completion_id`);
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ADD CONSTRAINT `fk_billing_dealer_statement_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= billing --> engineering (5 constraint(s)) =========
-- Requires: billing schema, engineering schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ADD CONSTRAINT `fk_billing_price_condition_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_powertrain_spec_id` FOREIGN KEY (`powertrain_spec_id`) REFERENCES `automotive_ecm`.`engineering`.`powertrain_spec`(`powertrain_spec_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= billing --> finance (18 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ADD CONSTRAINT `fk_billing_dealer_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ADD CONSTRAINT `fk_billing_dealer_statement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= billing --> inventory (3 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ADD CONSTRAINT `fk_billing_price_condition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= billing --> logistics (4 constraint(s)) =========
-- Requires: billing schema, logistics schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `automotive_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `automotive_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `automotive_ecm`.`logistics`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ADD CONSTRAINT `fk_billing_price_condition_transport_rate_id` FOREIGN KEY (`transport_rate_id`) REFERENCES `automotive_ecm`.`logistics`.`transport_rate`(`transport_rate_id`);

-- ========= billing --> sales (4 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `automotive_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `automotive_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `automotive_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= billing --> supply (2 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `automotive_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `automotive_ecm`.`supply`.`po_line`(`po_line_id`);

-- ========= billing --> vehicle (9 constraint(s)) =========
-- Requires: billing schema, vehicle schema
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_msrp_pricing_id` FOREIGN KEY (`msrp_pricing_id`) REFERENCES `automotive_ecm`.`vehicle`.`msrp_pricing`(`msrp_pricing_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_trim_option_availability_id` FOREIGN KEY (`trim_option_availability_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_option_availability`(`trim_option_availability_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ADD CONSTRAINT `fk_billing_price_condition_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ADD CONSTRAINT `fk_billing_price_condition_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);

-- ========= compliance --> customer (1 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= compliance --> engineering (9 constraint(s)) =========
-- Requires: compliance schema, engineering schema
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ADD CONSTRAINT `fk_compliance_compliance_test_result_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ADD CONSTRAINT `fk_compliance_compliance_test_result_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= compliance --> quality (2 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);

-- ========= compliance --> vehicle (11 constraint(s)) =========
-- Requires: compliance schema, vehicle schema
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_homologation_id` FOREIGN KEY (`homologation_id`) REFERENCES `automotive_ecm`.`vehicle`.`homologation`(`homologation_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);

-- ========= customer --> aftersales (3 constraint(s)) =========
-- Requires: customer schema, aftersales schema
ALTER TABLE `automotive_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_aftersales_warranty_claim_id` FOREIGN KEY (`aftersales_warranty_claim_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_warranty_claim`(`aftersales_warranty_claim_id`);

-- ========= customer --> billing (4 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `automotive_ecm`.`customer`.`individual` ADD CONSTRAINT `fk_customer_individual_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `automotive_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `automotive_ecm`.`customer`.`organization_account` ADD CONSTRAINT `fk_customer_organization_account_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `automotive_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `automotive_ecm`.`customer`.`loyalty_membership` ADD CONSTRAINT `fk_customer_loyalty_membership_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (2 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `automotive_ecm`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= customer --> dealer (6 constraint(s)) =========
-- Requires: customer schema, dealer schema
ALTER TABLE `automotive_ecm`.`customer`.`individual` ADD CONSTRAINT `fk_customer_individual_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`customer`.`individual` ADD CONSTRAINT `fk_customer_individual_individual_preferred_dealer_dealership_id` FOREIGN KEY (`individual_preferred_dealer_dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`customer`.`individual` ADD CONSTRAINT `fk_customer_individual_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `automotive_ecm`.`dealer`.`contact`(`contact_id`);
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `automotive_ecm`.`dealer`.`contact`(`contact_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= customer --> engineering (4 constraint(s)) =========
-- Requires: customer schema, engineering schema
ALTER TABLE `automotive_ecm`.`customer`.`organization_account` ADD CONSTRAINT `fk_customer_organization_account_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);

-- ========= customer --> finance (3 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `automotive_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `automotive_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `automotive_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);

-- ========= customer --> manufacturing (2 constraint(s)) =========
-- Requires: customer schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `automotive_ecm`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);

-- ========= customer --> sales (1 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= customer --> vehicle (3 constraint(s)) =========
-- Requires: customer schema, vehicle schema
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= dealer --> aftersales (4 constraint(s)) =========
-- Requires: dealer schema, aftersales schema
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_aftersales_service_appointment_id` FOREIGN KEY (`aftersales_service_appointment_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_service_appointment`(`aftersales_service_appointment_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_warranty_claim` ADD CONSTRAINT `fk_dealer_dealer_warranty_claim_aftersales_warranty_claim_id` FOREIGN KEY (`aftersales_warranty_claim_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_warranty_claim`(`aftersales_warranty_claim_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);

-- ========= dealer --> billing (7 constraint(s)) =========
-- Requires: dealer schema, billing schema
ALTER TABLE `automotive_ecm`.`dealer`.`dealership` ADD CONSTRAINT `fk_dealer_dealership_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealership` ADD CONSTRAINT `fk_dealer_dealership_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `automotive_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_incentive_claim` ADD CONSTRAINT `fk_dealer_dealer_incentive_claim_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `automotive_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_warranty_claim` ADD CONSTRAINT `fk_dealer_dealer_warranty_claim_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `automotive_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `automotive_ecm`.`billing`.`payment`(`payment_id`);

-- ========= dealer --> compliance (4 constraint(s)) =========
-- Requires: dealer schema, compliance schema
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_territory` ADD CONSTRAINT `fk_dealer_dealer_territory_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`certification` ADD CONSTRAINT `fk_dealer_certification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `automotive_ecm`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= dealer --> customer (7 constraint(s)) =========
-- Requires: dealer schema, customer schema
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_order_party_id` FOREIGN KEY (`order_party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_warranty_claim` ADD CONSTRAINT `fk_dealer_dealer_warranty_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= dealer --> engineering (8 constraint(s)) =========
-- Requires: dealer schema, engineering schema
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`parts_inventory` ADD CONSTRAINT `fk_dealer_parts_inventory_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`parts_inventory` ADD CONSTRAINT `fk_dealer_parts_inventory_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_incentive_claim` ADD CONSTRAINT `fk_dealer_dealer_incentive_claim_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= dealer --> finance (13 constraint(s)) =========
-- Requires: dealer schema, finance schema
ALTER TABLE `automotive_ecm`.`dealer`.`dealership` ADD CONSTRAINT `fk_dealer_dealership_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealership` ADD CONSTRAINT `fk_dealer_dealership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`franchise_agreement` ADD CONSTRAINT `fk_dealer_franchise_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_territory` ADD CONSTRAINT `fk_dealer_dealer_territory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`parts_inventory` ADD CONSTRAINT `fk_dealer_parts_inventory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_incentive_claim` ADD CONSTRAINT `fk_dealer_dealer_incentive_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_incentive_claim` ADD CONSTRAINT `fk_dealer_dealer_incentive_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`floor_plan` ADD CONSTRAINT `fk_dealer_floor_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`floor_plan` ADD CONSTRAINT `fk_dealer_floor_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= dealer --> inventory (2 constraint(s)) =========
-- Requires: dealer schema, inventory schema
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`parts_inventory` ADD CONSTRAINT `fk_dealer_parts_inventory_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= dealer --> logistics (5 constraint(s)) =========
-- Requires: dealer schema, logistics schema
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_logistics_delivery_schedule_id` FOREIGN KEY (`logistics_delivery_schedule_id`) REFERENCES `automotive_ecm`.`logistics`.`logistics_delivery_schedule`(`logistics_delivery_schedule_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `automotive_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_vehicle_transport_order_id` FOREIGN KEY (`vehicle_transport_order_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_transport_order`(`vehicle_transport_order_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);

-- ========= dealer --> manufacturing (7 constraint(s)) =========
-- Requires: dealer schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `automotive_ecm`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= dealer --> sales (6 constraint(s)) =========
-- Requires: dealer schema, sales schema
ALTER TABLE `automotive_ecm`.`dealer`.`franchise_agreement` ADD CONSTRAINT `fk_dealer_franchise_agreement_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `automotive_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_territory` ADD CONSTRAINT `fk_dealer_dealer_territory_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `automotive_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `automotive_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_incentive_claim` ADD CONSTRAINT `fk_dealer_dealer_incentive_claim_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `automotive_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= dealer --> supply (1 constraint(s)) =========
-- Requires: dealer schema, supply schema
ALTER TABLE `automotive_ecm`.`dealer`.`parts_inventory` ADD CONSTRAINT `fk_dealer_parts_inventory_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);

-- ========= dealer --> vehicle (11 constraint(s)) =========
-- Requires: dealer schema, vehicle schema
ALTER TABLE `automotive_ecm`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`order` ADD CONSTRAINT `fk_dealer_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_incentive_claim` ADD CONSTRAINT `fk_dealer_dealer_incentive_claim_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`floor_plan` ADD CONSTRAINT `fk_dealer_floor_plan_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`dealer_warranty_claim` ADD CONSTRAINT `fk_dealer_dealer_warranty_claim_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`dealer`.`recall_completion` ADD CONSTRAINT `fk_dealer_recall_completion_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= engineering --> compliance (14 constraint(s)) =========
-- Requires: engineering schema, compliance schema
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ADD CONSTRAINT `fk_engineering_material_specification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= engineering --> finance (8 constraint(s)) =========
-- Requires: engineering schema, finance schema
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ADD CONSTRAINT `fk_engineering_vehicle_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ADD CONSTRAINT `fk_engineering_vehicle_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ADD CONSTRAINT `fk_engineering_vehicle_program_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= engineering --> inventory (5 constraint(s)) =========
-- Requires: engineering schema, inventory schema
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ADD CONSTRAINT `fk_engineering_bom_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= engineering --> quality (7 constraint(s)) =========
-- Requires: engineering schema, quality schema
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `automotive_ecm`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `automotive_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);

-- ========= engineering --> supply (5 constraint(s)) =========
-- Requires: engineering schema, supply schema
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `automotive_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_supplier_part_approval_id` FOREIGN KEY (`supplier_part_approval_id`) REFERENCES `automotive_ecm`.`supply`.`supplier_part_approval`(`supplier_part_approval_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_supplier_part_approval_id` FOREIGN KEY (`supplier_part_approval_id`) REFERENCES `automotive_ecm`.`supply`.`supplier_part_approval`(`supplier_part_approval_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `automotive_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= finance --> compliance (5 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= finance --> customer (3 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `automotive_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= finance --> manufacturing (6 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `automotive_ecm`.`sales`.`sales_territory`(`sales_territory_id`);

-- ========= finance --> vehicle (1 constraint(s)) =========
-- Requires: finance schema, vehicle schema
ALTER TABLE `automotive_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= inventory --> billing (1 constraint(s)) =========
-- Requires: inventory schema, billing schema
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= inventory --> compliance (6 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ADD CONSTRAINT `fk_inventory_sku_master_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `automotive_ecm`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `automotive_ecm`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= inventory --> customer (7 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_individual_id` FOREIGN KEY (`individual_id`) REFERENCES `automotive_ecm`.`customer`.`individual`(`individual_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_organization_account_id` FOREIGN KEY (`organization_account_id`) REFERENCES `automotive_ecm`.`customer`.`organization_account`(`organization_account_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_case_id` FOREIGN KEY (`case_id`) REFERENCES `automotive_ecm`.`customer`.`case`(`case_id`);

-- ========= inventory --> dealer (3 constraint(s)) =========
-- Requires: inventory schema, dealer schema
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= inventory --> engineering (12 constraint(s)) =========
-- Requires: inventory schema, engineering schema
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ADD CONSTRAINT `fk_inventory_sku_master_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`material_specification`(`material_specification_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ADD CONSTRAINT `fk_inventory_sku_master_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_powertrain_spec_id` FOREIGN KEY (`powertrain_spec_id`) REFERENCES `automotive_ecm`.`engineering`.`powertrain_spec`(`powertrain_spec_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= inventory --> finance (12 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ADD CONSTRAINT `fk_inventory_sku_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= inventory --> manufacturing (12 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `automotive_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_source_plant_id` FOREIGN KEY (`source_plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= inventory --> quality (2 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> sales (2 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= inventory --> supply (4 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= inventory --> vehicle (5 constraint(s)) =========
-- Requires: inventory schema, vehicle schema
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= logistics --> aftersales (1 constraint(s)) =========
-- Requires: logistics schema, aftersales schema
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);

-- ========= logistics --> billing (1 constraint(s)) =========
-- Requires: logistics schema, billing schema
ALTER TABLE `automotive_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);

-- ========= logistics --> compliance (6 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `automotive_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vessel_voyage` ADD CONSTRAINT `fk_logistics_vessel_voyage_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= logistics --> customer (2 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `automotive_ecm`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= logistics --> dealer (4 constraint(s)) =========
-- Requires: logistics schema, dealer schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= logistics --> engineering (6 constraint(s)) =========
-- Requires: logistics schema, engineering schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_homologation_requirement_id` FOREIGN KEY (`homologation_requirement_id`) REFERENCES `automotive_ecm`.`engineering`.`homologation_requirement`(`homologation_requirement_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= logistics --> finance (14 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= logistics --> inventory (4 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `automotive_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);

-- ========= logistics --> manufacturing (11 constraint(s)) =========
-- Requires: logistics schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_production_variant_id` FOREIGN KEY (`production_variant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_variant`(`production_variant_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`load_plan` ADD CONSTRAINT `fk_logistics_load_plan_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= logistics --> sales (5 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`logistics_delivery_schedule` ADD CONSTRAINT `fk_logistics_logistics_delivery_schedule_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= logistics --> vehicle (7 constraint(s)) =========
-- Requires: logistics schema, vehicle schema
ALTER TABLE `automotive_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`compound_movement` ADD CONSTRAINT `fk_logistics_compound_movement_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_homologation_id` FOREIGN KEY (`homologation_id`) REFERENCES `automotive_ecm`.`vehicle`.`homologation`(`homologation_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`port_processing` ADD CONSTRAINT `fk_logistics_port_processing_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= manufacturing --> billing (2 constraint(s)) =========
-- Requires: manufacturing schema, billing schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_price_condition_id` FOREIGN KEY (`price_condition_id`) REFERENCES `automotive_ecm`.`billing`.`price_condition`(`price_condition_id`);

-- ========= manufacturing --> compliance (6 constraint(s)) =========
-- Requires: manufacturing schema, compliance schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);

-- ========= manufacturing --> customer (2 constraint(s)) =========
-- Requires: manufacturing schema, customer schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= manufacturing --> engineering (16 constraint(s)) =========
-- Requires: manufacturing schema, engineering schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `automotive_ecm`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_primary_production_ebom_reference_bom_id` FOREIGN KEY (`primary_production_ebom_reference_bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_ecu_specification_id` FOREIGN KEY (`ecu_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`ecu_specification`(`ecu_specification_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_powertrain_spec_id` FOREIGN KEY (`powertrain_spec_id`) REFERENCES `automotive_ecm`.`engineering`.`powertrain_spec`(`powertrain_spec_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= manufacturing --> finance (24 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `automotive_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `automotive_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `automotive_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= manufacturing --> inventory (12 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= manufacturing --> quality (17 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `automotive_ecm`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_characteristic_id` FOREIGN KEY (`characteristic_id`) REFERENCES `automotive_ecm`.`quality`.`characteristic`(`characteristic_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `automotive_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `automotive_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_characteristic_id` FOREIGN KEY (`characteristic_id`) REFERENCES `automotive_ecm`.`quality`.`characteristic`(`characteristic_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `automotive_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);

-- ========= manufacturing --> sales (4 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_msrp_schedule_id` FOREIGN KEY (`msrp_schedule_id`) REFERENCES `automotive_ecm`.`sales`.`msrp_schedule`(`msrp_schedule_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `automotive_ecm`.`sales`.`fleet_contract`(`fleet_contract_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_msrp_schedule_id` FOREIGN KEY (`msrp_schedule_id`) REFERENCES `automotive_ecm`.`sales`.`msrp_schedule`(`msrp_schedule_id`);

-- ========= manufacturing --> supply (8 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `automotive_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_supply_delivery_schedule_id` FOREIGN KEY (`supply_delivery_schedule_id`) REFERENCES `automotive_ecm`.`supply`.`supply_delivery_schedule`(`supply_delivery_schedule_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_scheduling_agreement_id` FOREIGN KEY (`scheduling_agreement_id`) REFERENCES `automotive_ecm`.`supply`.`scheduling_agreement`(`scheduling_agreement_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);

-- ========= manufacturing --> vehicle (20 constraint(s)) =========
-- Requires: manufacturing schema, vehicle schema
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_level`(`trim_level_id`);

-- ========= quality --> billing (1 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= quality --> compliance (6 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= quality --> customer (4 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_ownership_id` FOREIGN KEY (`vehicle_ownership_id`) REFERENCES `automotive_ecm`.`customer`.`vehicle_ownership`(`vehicle_ownership_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_organization_account_id` FOREIGN KEY (`organization_account_id`) REFERENCES `automotive_ecm`.`customer`.`organization_account`(`organization_account_id`);

-- ========= quality --> dealer (5 constraint(s)) =========
-- Requires: quality schema, dealer schema
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_dealer_repair_order_id` FOREIGN KEY (`dealer_repair_order_id`) REFERENCES `automotive_ecm`.`dealer`.`dealer_repair_order`(`dealer_repair_order_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `automotive_ecm`.`dealer`.`certification`(`certification_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`quality`.`pdi_inspection` ADD CONSTRAINT `fk_quality_pdi_inspection_dealer_inventory_id` FOREIGN KEY (`dealer_inventory_id`) REFERENCES `automotive_ecm`.`dealer`.`dealer_inventory`(`dealer_inventory_id`);

-- ========= quality --> engineering (5 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= quality --> finance (16 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `automotive_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `automotive_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`quality`.`standard` ADD CONSTRAINT `fk_quality_standard_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= quality --> inventory (11 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`quality_ppap_submission` ADD CONSTRAINT `fk_quality_quality_ppap_submission_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`quality`.`characteristic` ADD CONSTRAINT `fk_quality_characteristic_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= quality --> logistics (12 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `automotive_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `automotive_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `automotive_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_handover_id` FOREIGN KEY (`vehicle_handover_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_handover`(`vehicle_handover_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `automotive_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`quality`.`pdi_inspection` ADD CONSTRAINT `fk_quality_pdi_inspection_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `automotive_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= quality --> manufacturing (23 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `automotive_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `automotive_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_build_stage_id` FOREIGN KEY (`build_stage_id`) REFERENCES `automotive_ecm`.`manufacturing`.`build_stage`(`build_stage_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `automotive_ecm`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `automotive_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_build_stage_id` FOREIGN KEY (`build_stage_id`) REFERENCES `automotive_ecm`.`manufacturing`.`build_stage`(`build_stage_id`);
ALTER TABLE `automotive_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `automotive_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`quality_ppap_submission` ADD CONSTRAINT `fk_quality_quality_ppap_submission_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`quality`.`quality_ppap_submission` ADD CONSTRAINT `fk_quality_quality_ppap_submission_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_primary_auditee_location_plant_id` FOREIGN KEY (`primary_auditee_location_plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `automotive_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `automotive_ecm`.`quality`.`pdi_inspection` ADD CONSTRAINT `fk_quality_pdi_inspection_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `automotive_ecm`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `automotive_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `automotive_ecm`.`sales`.`fleet_contract`(`fleet_contract_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= quality --> supply (4 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `automotive_ecm`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `automotive_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `automotive_ecm`.`quality`.`quality_ppap_submission` ADD CONSTRAINT `fk_quality_quality_ppap_submission_supply_ppap_submission_id` FOREIGN KEY (`supply_ppap_submission_id`) REFERENCES `automotive_ecm`.`supply`.`supply_ppap_submission`(`supply_ppap_submission_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `automotive_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= quality --> vehicle (10 constraint(s)) =========
-- Requires: quality schema, vehicle schema
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `automotive_ecm`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `automotive_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`quality`.`pdi_inspection` ADD CONSTRAINT `fk_quality_pdi_inspection_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`quality`.`supplier_quality_event` ADD CONSTRAINT `fk_quality_supplier_quality_event_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`quality`.`characteristic` ADD CONSTRAINT `fk_quality_characteristic_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);

-- ========= sales --> aftersales (2 constraint(s)) =========
-- Requires: sales schema, aftersales schema
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_vehicle_warranty_id` FOREIGN KEY (`vehicle_warranty_id`) REFERENCES `automotive_ecm`.`aftersales`.`vehicle_warranty`(`vehicle_warranty_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_contract`(`service_contract_id`);

-- ========= sales --> billing (1 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `automotive_ecm`.`sales`.`sales_incentive_claim` ADD CONSTRAINT `fk_sales_sales_incentive_claim_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `automotive_ecm`.`billing`.`payment`(`payment_id`);

-- ========= sales --> compliance (7 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`sales`.`incentive_program` ADD CONSTRAINT `fk_sales_incentive_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= sales --> customer (13 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_opportunity_party_id` FOREIGN KEY (`opportunity_party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_party_id` FOREIGN KEY (`quote_party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_contact_point_id` FOREIGN KEY (`contact_point_id`) REFERENCES `automotive_ecm`.`customer`.`contact_point`(`contact_point_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_organization_account_id` FOREIGN KEY (`organization_account_id`) REFERENCES `automotive_ecm`.`customer`.`organization_account`(`organization_account_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_activity_party_id` FOREIGN KEY (`activity_party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_case_id` FOREIGN KEY (`case_id`) REFERENCES `automotive_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_contact_point_id` FOREIGN KEY (`contact_point_id`) REFERENCES `automotive_ecm`.`customer`.`contact_point`(`contact_point_id`);

-- ========= sales --> dealer (11 constraint(s)) =========
-- Requires: sales schema, dealer schema
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_lead_dealership_id` FOREIGN KEY (`lead_dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_dealership_id` FOREIGN KEY (`quote_dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `automotive_ecm`.`dealer`.`contact`(`contact_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= sales --> engineering (11 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`sales`.`incentive_program` ADD CONSTRAINT `fk_sales_incentive_program_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_powertrain_spec_id` FOREIGN KEY (`powertrain_spec_id`) REFERENCES `automotive_ecm`.`engineering`.`powertrain_spec`(`powertrain_spec_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= sales --> finance (13 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`sales`.`sales_incentive_claim` ADD CONSTRAINT `fk_sales_sales_incentive_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`sales`.`sales_incentive_claim` ADD CONSTRAINT `fk_sales_sales_incentive_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `automotive_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= sales --> inventory (7 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`sales`.`sales_incentive_claim` ADD CONSTRAINT `fk_sales_sales_incentive_claim_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `automotive_ecm`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= sales --> vehicle (31 constraint(s)) =========
-- Requires: sales schema, vehicle schema
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_opportunity_vehicle_model_id` FOREIGN KEY (`opportunity_vehicle_model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_vin_registry_id` FOREIGN KEY (`quote_vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_trim_option_availability_id` FOREIGN KEY (`trim_option_availability_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_option_availability`(`trim_option_availability_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `automotive_ecm`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_tertiary_order_vin_registry_id` FOREIGN KEY (`tertiary_order_vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_trim_option_availability_id` FOREIGN KEY (`trim_option_availability_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_option_availability`(`trim_option_availability_id`);
ALTER TABLE `automotive_ecm`.`sales`.`incentive_program` ADD CONSTRAINT `fk_sales_incentive_program_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`incentive_program` ADD CONSTRAINT `fk_sales_incentive_program_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`fleet_contract_line` ADD CONSTRAINT `fk_sales_fleet_contract_line_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `automotive_ecm`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `automotive_ecm`.`sales`.`msrp_schedule` ADD CONSTRAINT `fk_sales_msrp_schedule_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `automotive_ecm`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_model_year_program_id` FOREIGN KEY (`model_year_program_id`) REFERENCES `automotive_ecm`.`vehicle`.`model_year_program`(`model_year_program_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `automotive_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_activity_vin_registry_id` FOREIGN KEY (`activity_vin_registry_id`) REFERENCES `automotive_ecm`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= supply --> billing (4 constraint(s)) =========
-- Requires: supply schema, billing schema
ALTER TABLE `automotive_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_tax_code_id` FOREIGN KEY (`tax_code_id`) REFERENCES `automotive_ecm`.`billing`.`tax_code`(`tax_code_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq_response` ADD CONSTRAINT `fk_supply_rfq_response_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `automotive_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `automotive_ecm`.`billing`.`payment_term`(`payment_term_id`);

-- ========= supply --> compliance (8 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `automotive_ecm`.`supply`.`supplier_part_approval` ADD CONSTRAINT `fk_supply_supplier_part_approval_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`supply`.`commodity_group` ADD CONSTRAINT `fk_supply_commodity_group_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_organization_account_id` FOREIGN KEY (`organization_account_id`) REFERENCES `automotive_ecm`.`customer`.`organization_account`(`organization_account_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_organization_account_id` FOREIGN KEY (`organization_account_id`) REFERENCES `automotive_ecm`.`customer`.`organization_account`(`organization_account_id`);
ALTER TABLE `automotive_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_organization_account_id` FOREIGN KEY (`organization_account_id`) REFERENCES `automotive_ecm`.`customer`.`organization_account`(`organization_account_id`);

-- ========= supply --> engineering (3 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);

-- ========= supply --> finance (21 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `automotive_ecm`.`supply`.`supplier_part_approval` ADD CONSTRAINT `fk_supply_supplier_part_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq_response` ADD CONSTRAINT `fk_supply_rfq_response_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`corrective_action` ADD CONSTRAINT `fk_supply_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`corrective_action` ADD CONSTRAINT `fk_supply_corrective_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_inspection` ADD CONSTRAINT `fk_supply_inbound_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `automotive_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`supply`.`commodity_group` ADD CONSTRAINT `fk_supply_commodity_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `automotive_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> inventory (5 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_inspection` ADD CONSTRAINT `fk_supply_inbound_inspection_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= supply --> logistics (2 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `automotive_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `automotive_ecm`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);

-- ========= supply --> manufacturing (1 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= supply --> quality (7 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `automotive_ecm`.`supply`.`supplier_part_approval` ADD CONSTRAINT `fk_supply_supplier_part_approval_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `automotive_ecm`.`supply`.`supplier_part_approval` ADD CONSTRAINT `fk_supply_supplier_part_approval_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `automotive_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `automotive_ecm`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`supply`.`supply_ppap_submission` ADD CONSTRAINT `fk_supply_supply_ppap_submission_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `automotive_ecm`.`quality`.`fmea`(`fmea_id`);

-- ========= supply --> sales (5 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `automotive_ecm`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `automotive_ecm`.`sales`.`fleet_contract`(`fleet_contract_id`);
ALTER TABLE `automotive_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `automotive_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `automotive_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `automotive_ecm`.`sales`.`fleet_contract`(`fleet_contract_id`);
ALTER TABLE `automotive_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `automotive_ecm`.`sales`.`vehicle_order`(`vehicle_order_id`);

-- ========= supply --> vehicle (7 constraint(s)) =========
-- Requires: supply schema, vehicle schema
ALTER TABLE `automotive_ecm`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `automotive_ecm`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `automotive_ecm`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`supply`.`supply_delivery_schedule` ADD CONSTRAINT `fk_supply_supply_delivery_schedule_build_spec_id` FOREIGN KEY (`build_spec_id`) REFERENCES `automotive_ecm`.`vehicle`.`build_spec`(`build_spec_id`);
ALTER TABLE `automotive_ecm`.`supply`.`supply_ppap_submission` ADD CONSTRAINT `fk_supply_supply_ppap_submission_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);
ALTER TABLE `automotive_ecm`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_model_id` FOREIGN KEY (`model_id`) REFERENCES `automotive_ecm`.`vehicle`.`model`(`model_id`);

-- ========= vehicle --> compliance (5 constraint(s)) =========
-- Requires: vehicle schema, compliance schema
ALTER TABLE `automotive_ecm`.`vehicle`.`vin_registry` ADD CONSTRAINT `fk_vehicle_vin_registry_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`homologation` ADD CONSTRAINT `fk_vehicle_homologation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= vehicle --> customer (2 constraint(s)) =========
-- Requires: vehicle schema, customer schema
ALTER TABLE `automotive_ecm`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`ownership` ADD CONSTRAINT `fk_vehicle_ownership_party_id` FOREIGN KEY (`party_id`) REFERENCES `automotive_ecm`.`customer`.`party`(`party_id`);

-- ========= vehicle --> dealer (1 constraint(s)) =========
-- Requires: vehicle schema, dealer schema
ALTER TABLE `automotive_ecm`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `automotive_ecm`.`dealer`.`dealership`(`dealership_id`);

-- ========= vehicle --> engineering (18 constraint(s)) =========
-- Requires: vehicle schema, engineering schema
ALTER TABLE `automotive_ecm`.`vehicle`.`vin_registry` ADD CONSTRAINT `fk_vehicle_vin_registry_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`model_year_program` ADD CONSTRAINT `fk_vehicle_model_year_program_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`trim_level` ADD CONSTRAINT `fk_vehicle_trim_level_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`powertrain_variant` ADD CONSTRAINT `fk_vehicle_powertrain_variant_powertrain_spec_id` FOREIGN KEY (`powertrain_spec_id`) REFERENCES `automotive_ecm`.`engineering`.`powertrain_spec`(`powertrain_spec_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`platform` ADD CONSTRAINT `fk_vehicle_platform_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `automotive_ecm`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`homologation` ADD CONSTRAINT `fk_vehicle_homologation_homologation_requirement_id` FOREIGN KEY (`homologation_requirement_id`) REFERENCES `automotive_ecm`.`engineering`.`homologation_requirement`(`homologation_requirement_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`homologation` ADD CONSTRAINT `fk_vehicle_homologation_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`ecu_catalog` ADD CONSTRAINT `fk_vehicle_ecu_catalog_ecu_specification_id` FOREIGN KEY (`ecu_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`ecu_specification`(`ecu_specification_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`trim_option_availability` ADD CONSTRAINT `fk_vehicle_trim_option_availability_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);

-- ========= vehicle --> finance (4 constraint(s)) =========
-- Requires: vehicle schema, finance schema
ALTER TABLE `automotive_ecm`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `automotive_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`model_year_program` ADD CONSTRAINT `fk_vehicle_model_year_program_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `automotive_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`platform` ADD CONSTRAINT `fk_vehicle_platform_project_id` FOREIGN KEY (`project_id`) REFERENCES `automotive_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `automotive_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= vehicle --> manufacturing (1 constraint(s)) =========
-- Requires: vehicle schema, manufacturing schema
ALTER TABLE `automotive_ecm`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `automotive_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= vehicle --> quality (2 constraint(s)) =========
-- Requires: vehicle schema, quality schema
ALTER TABLE `automotive_ecm`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `automotive_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `automotive_ecm`.`vehicle`.`homologation` ADD CONSTRAINT `fk_vehicle_homologation_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `automotive_ecm`.`quality`.`standard`(`standard_id`);

