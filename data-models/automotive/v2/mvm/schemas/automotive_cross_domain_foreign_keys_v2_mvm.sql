-- Cross-Domain Foreign Keys for Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:21
-- Total cross-domain FK constraints: 543
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: aftersales, compliance, customer, dealer, engineering, inventory, logistics, manufacturing, product, quality, sales, supply, vehicle

-- ========= aftersales --> compliance (12 constraint(s)) =========
-- Requires: aftersales schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_center` ADD CONSTRAINT `fk_aftersales_service_center_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= aftersales --> customer (6 constraint(s)) =========
-- Requires: aftersales schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_fleet_account_id` FOREIGN KEY (`fleet_account_id`) REFERENCES `vibe_automotive_v1`.`customer`.`fleet_account`(`fleet_account_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_warranty_aftersales_party_id` FOREIGN KEY (`warranty_aftersales_party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);

-- ========= aftersales --> dealer (7 constraint(s)) =========
-- Requires: aftersales schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_warranty_aftersales_dealership_id` FOREIGN KEY (`warranty_aftersales_dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_center` ADD CONSTRAINT `fk_aftersales_service_center_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= aftersales --> engineering (12 constraint(s)) =========
-- Requires: aftersales schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_part` ADD CONSTRAINT `fk_aftersales_service_part_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);

-- ========= aftersales --> inventory (3 constraint(s)) =========
-- Requires: aftersales schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= aftersales --> manufacturing (4 constraint(s)) =========
-- Requires: aftersales schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= aftersales --> product (2 constraint(s)) =========
-- Requires: aftersales schema, product schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);

-- ========= aftersales --> quality (2 constraint(s)) =========
-- Requires: aftersales schema, quality schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_automotive_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_ncap_test_result_id` FOREIGN KEY (`ncap_test_result_id`) REFERENCES `vibe_automotive_v1`.`quality`.`ncap_test_result`(`ncap_test_result_id`);

-- ========= aftersales --> supply (4 constraint(s)) =========
-- Requires: aftersales schema, supply schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_part` ADD CONSTRAINT `fk_aftersales_service_part_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`parts_order` ADD CONSTRAINT `fk_aftersales_parts_order_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);

-- ========= aftersales --> vehicle (11 constraint(s)) =========
-- Requires: aftersales schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_claim` ADD CONSTRAINT `fk_aftersales_warranty_claim_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`service_campaign` ADD CONSTRAINT `fk_aftersales_service_campaign_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment` ADD CONSTRAINT `fk_aftersales_aftersales_service_appointment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);

-- ========= compliance --> engineering (8 constraint(s)) =========
-- Requires: compliance schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ADD CONSTRAINT `fk_compliance_recall_defect_report_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ADD CONSTRAINT `fk_compliance_recall_defect_report_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);

-- ========= compliance --> product (4 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ADD CONSTRAINT `fk_compliance_fmvss_certification_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ADD CONSTRAINT `fk_compliance_recall_defect_report_product_bom_line_id` FOREIGN KEY (`product_bom_line_id`) REFERENCES `vibe_automotive_v1`.`product`.`product_bom_line`(`product_bom_line_id`);

-- ========= compliance --> vehicle (8 constraint(s)) =========
-- Requires: compliance schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ADD CONSTRAINT `fk_compliance_fmvss_certification_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ADD CONSTRAINT `fk_compliance_fmvss_certification_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);

-- ========= customer --> aftersales (1 constraint(s)) =========
-- Requires: customer schema, aftersales schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_vehicle_warranty_id` FOREIGN KEY (`vehicle_warranty_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`vehicle_warranty`(`vehicle_warranty_id`);

-- ========= customer --> compliance (4 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= customer --> dealer (7 constraint(s)) =========
-- Requires: customer schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`individual` ADD CONSTRAINT `fk_customer_individual_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`individual` ADD CONSTRAINT `fk_customer_individual_individual_preferred_dealer_dealership_id` FOREIGN KEY (`individual_preferred_dealer_dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`organization_account` ADD CONSTRAINT `fk_customer_organization_account_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`fleet_account` ADD CONSTRAINT `fk_customer_fleet_account_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_retail_sale_id` FOREIGN KEY (`retail_sale_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`retail_sale`(`retail_sale_id`);

-- ========= customer --> engineering (2 constraint(s)) =========
-- Requires: customer schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);

-- ========= customer --> manufacturing (2 constraint(s)) =========
-- Requires: customer schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);

-- ========= customer --> product (2 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);

-- ========= customer --> supply (2 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= customer --> vehicle (3 constraint(s)) =========
-- Requires: customer schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`customer`.`vehicle_ownership` ADD CONSTRAINT `fk_customer_vehicle_ownership_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= dealer --> aftersales (4 constraint(s)) =========
-- Requires: dealer schema, aftersales schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ADD CONSTRAINT `fk_dealer_franchise_agreement_warranty_policy_id` FOREIGN KEY (`warranty_policy_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`warranty_policy`(`warranty_policy_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_aftersales_service_appointment_id` FOREIGN KEY (`aftersales_service_appointment_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment`(`aftersales_service_appointment_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);

-- ========= dealer --> compliance (9 constraint(s)) =========
-- Requires: dealer schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ADD CONSTRAINT `fk_dealer_dealership_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ADD CONSTRAINT `fk_dealer_franchise_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ADD CONSTRAINT `fk_dealer_franchise_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ADD CONSTRAINT `fk_dealer_territory_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ADD CONSTRAINT `fk_dealer_certification_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ADD CONSTRAINT `fk_dealer_certification_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ADD CONSTRAINT `fk_dealer_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= dealer --> customer (3 constraint(s)) =========
-- Requires: dealer schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);

-- ========= dealer --> engineering (2 constraint(s)) =========
-- Requires: dealer schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= dealer --> manufacturing (3 constraint(s)) =========
-- Requires: dealer schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);

-- ========= dealer --> product (5 constraint(s)) =========
-- Requires: dealer schema, product schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ADD CONSTRAINT `fk_dealer_territory_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ADD CONSTRAINT `fk_dealer_certification_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `vibe_automotive_v1`.`product`.`msrp_price_book`(`msrp_price_book_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ADD CONSTRAINT `fk_dealer_performance_scorecard_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);

-- ========= dealer --> sales (3 constraint(s)) =========
-- Requires: dealer schema, sales schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `vibe_automotive_v1`.`sales`.`fleet_contract`(`fleet_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_automotive_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_automotive_v1`.`sales`.`opportunity`(`opportunity_id`);

-- ========= dealer --> vehicle (7 constraint(s)) =========
-- Requires: dealer schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= engineering --> compliance (3 constraint(s)) =========
-- Requires: engineering schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= inventory --> aftersales (4 constraint(s)) =========
-- Requires: inventory schema, aftersales schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_service_part_id` FOREIGN KEY (`service_part_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`service_part`(`service_part_id`);

-- ========= inventory --> compliance (6 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_emissions_certification_id` FOREIGN KEY (`emissions_certification_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`emissions_certification`(`emissions_certification_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= inventory --> customer (3 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);

-- ========= inventory --> dealer (3 constraint(s)) =========
-- Requires: inventory schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vehicle_allocation_id` FOREIGN KEY (`vehicle_allocation_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`vehicle_allocation`(`vehicle_allocation_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= inventory --> engineering (6 constraint(s)) =========
-- Requires: inventory schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`sku_master` ADD CONSTRAINT `fk_inventory_sku_master_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);

-- ========= inventory --> manufacturing (8 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_source_plant_id` FOREIGN KEY (`source_plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= inventory --> product (2 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);

-- ========= inventory --> sales (1 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `vibe_automotive_v1`.`sales`.`fleet_contract`(`fleet_contract_id`);

-- ========= inventory --> supply (1 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);

-- ========= inventory --> vehicle (7 constraint(s)) =========
-- Requires: inventory schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);

-- ========= logistics --> aftersales (2 constraint(s)) =========
-- Requires: logistics schema, aftersales schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_parts_order_id` FOREIGN KEY (`parts_order_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`parts_order`(`parts_order_id`);

-- ========= logistics --> compliance (12 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`transport_rate` ADD CONSTRAINT `fk_logistics_transport_rate_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= logistics --> customer (4 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_fleet_account_id` FOREIGN KEY (`fleet_account_id`) REFERENCES `vibe_automotive_v1`.`customer`.`fleet_account`(`fleet_account_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);

-- ========= logistics --> dealer (7 constraint(s)) =========
-- Requires: logistics schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_vehicle_allocation_id` FOREIGN KEY (`vehicle_allocation_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`vehicle_allocation`(`vehicle_allocation_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_vehicle_allocation_id` FOREIGN KEY (`vehicle_allocation_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`vehicle_allocation`(`vehicle_allocation_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_vehicle_allocation_id` FOREIGN KEY (`vehicle_allocation_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`vehicle_allocation`(`vehicle_allocation_id`);

-- ========= logistics --> engineering (3 constraint(s)) =========
-- Requires: logistics schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= logistics --> inventory (8 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`stock_transfer_order`(`stock_transfer_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`stock_transfer_order`(`stock_transfer_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`compound_movement` ADD CONSTRAINT `fk_logistics_compound_movement_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`compound_movement` ADD CONSTRAINT `fk_logistics_compound_movement_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`stock_transfer_order`(`stock_transfer_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= logistics --> manufacturing (8 constraint(s)) =========
-- Requires: logistics schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_transport_order` ADD CONSTRAINT `fk_logistics_vehicle_transport_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_compound` ADD CONSTRAINT `fk_logistics_vehicle_compound_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= logistics --> product (1 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);

-- ========= logistics --> sales (4 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`compound_movement` ADD CONSTRAINT `fk_logistics_compound_movement_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `vibe_automotive_v1`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `vibe_automotive_v1`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `vibe_automotive_v1`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_delivery_appointment_id` FOREIGN KEY (`delivery_appointment_id`) REFERENCES `vibe_automotive_v1`.`sales`.`delivery_appointment`(`delivery_appointment_id`);

-- ========= logistics --> supply (2 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_automotive_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_supplier_plant_id` FOREIGN KEY (`supplier_plant_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier_plant`(`supplier_plant_id`);

-- ========= logistics --> vehicle (5 constraint(s)) =========
-- Requires: logistics schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`compound_movement` ADD CONSTRAINT `fk_logistics_compound_movement_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`in_transit_inventory` ADD CONSTRAINT `fk_logistics_in_transit_inventory_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`logistics`.`vehicle_handover` ADD CONSTRAINT `fk_logistics_vehicle_handover_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= manufacturing --> compliance (5 constraint(s)) =========
-- Requires: manufacturing schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= manufacturing --> customer (2 constraint(s)) =========
-- Requires: manufacturing schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_fleet_account_id` FOREIGN KEY (`fleet_account_id`) REFERENCES `vibe_automotive_v1`.`customer`.`fleet_account`(`fleet_account_id`);

-- ========= manufacturing --> dealer (2 constraint(s)) =========
-- Requires: manufacturing schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= manufacturing --> engineering (16 constraint(s)) =========
-- Requires: manufacturing schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= manufacturing --> inventory (7 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_finished_vehicle_stock_id` FOREIGN KEY (`finished_vehicle_stock_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock`(`finished_vehicle_stock_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`goods_movement`(`goods_movement_id`);

-- ========= manufacturing --> logistics (1 constraint(s)) =========
-- Requires: manufacturing schema, logistics schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);

-- ========= manufacturing --> product (4 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);

-- ========= manufacturing --> quality (2 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);

-- ========= manufacturing --> sales (2 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `vibe_automotive_v1`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_fleet_contract_id` FOREIGN KEY (`fleet_contract_id`) REFERENCES `vibe_automotive_v1`.`sales`.`fleet_contract`(`fleet_contract_id`);

-- ========= manufacturing --> vehicle (18 constraint(s)) =========
-- Requires: manufacturing schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_build_spec_id` FOREIGN KEY (`build_spec_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`build_spec`(`build_spec_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);

-- ========= product --> compliance (1 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= product --> dealer (1 constraint(s)) =========
-- Requires: product schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` ADD CONSTRAINT `fk_product_package_availability_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= product --> engineering (3 constraint(s)) =========
-- Requires: product schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);

-- ========= product --> inventory (2 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= product --> manufacturing (1 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);

-- ========= quality --> compliance (9 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_fmvss_certification_id` FOREIGN KEY (`fmvss_certification_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`fmvss_certification`(`fmvss_certification_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= quality --> customer (2 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_automotive_v1`.`customer`.`case`(`case_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_automotive_v1`.`customer`.`case`(`case_id`);

-- ========= quality --> dealer (3 constraint(s)) =========
-- Requires: quality schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_dealer_repair_order_id` FOREIGN KEY (`dealer_repair_order_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealer_repair_order`(`dealer_repair_order_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= quality --> engineering (13 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);

-- ========= quality --> inventory (4 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_balance_id` FOREIGN KEY (`stock_balance_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`stock_balance`(`stock_balance_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= quality --> logistics (6 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vehicle_transport_order_id` FOREIGN KEY (`vehicle_transport_order_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_transport_order`(`vehicle_transport_order_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_shipment_leg_id` FOREIGN KEY (`shipment_leg_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`shipment_leg`(`shipment_leg_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_compound_id` FOREIGN KEY (`vehicle_compound_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_compound`(`vehicle_compound_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_handover_id` FOREIGN KEY (`vehicle_handover_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_handover`(`vehicle_handover_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= quality --> manufacturing (11 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);

-- ========= quality --> product (5 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ADD CONSTRAINT `fk_quality_characteristic_product_bom_line_id` FOREIGN KEY (`product_bom_line_id`) REFERENCES `vibe_automotive_v1`.`product`.`product_bom_line`(`product_bom_line_id`);

-- ========= quality --> supply (5 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_ppap_submission_id` FOREIGN KEY (`ppap_submission_id`) REFERENCES `vibe_automotive_v1`.`supply`.`ppap_submission`(`ppap_submission_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_supplier_scorecard_id` FOREIGN KEY (`supplier_scorecard_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier_scorecard`(`supplier_scorecard_id`);

-- ========= quality --> vehicle (11 constraint(s)) =========
-- Requires: quality schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ADD CONSTRAINT `fk_quality_apqp_plan_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= sales --> aftersales (1 constraint(s)) =========
-- Requires: sales schema, aftersales schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`delivery_appointment` ADD CONSTRAINT `fk_sales_delivery_appointment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `vibe_automotive_v1`.`aftersales`.`technician`(`technician_id`);

-- ========= sales --> compliance (5 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= sales --> customer (12 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_opportunity_party_id` FOREIGN KEY (`opportunity_party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_contact_point_id` FOREIGN KEY (`contact_point_id`) REFERENCES `vibe_automotive_v1`.`customer`.`contact_point`(`contact_point_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_party_id` FOREIGN KEY (`quote_party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_contact_point_id` FOREIGN KEY (`contact_point_id`) REFERENCES `vibe_automotive_v1`.`customer`.`contact_point`(`contact_point_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_fleet_account_id` FOREIGN KEY (`fleet_account_id`) REFERENCES `vibe_automotive_v1`.`customer`.`fleet_account`(`fleet_account_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`trade_in` ADD CONSTRAINT `fk_sales_trade_in_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`delivery_appointment` ADD CONSTRAINT `fk_sales_delivery_appointment_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);

-- ========= sales --> dealer (9 constraint(s)) =========
-- Requires: sales schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_lead_dealership_id` FOREIGN KEY (`lead_dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_dealership_id` FOREIGN KEY (`quote_dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`trade_in` ADD CONSTRAINT `fk_sales_trade_in_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`delivery_appointment` ADD CONSTRAINT `fk_sales_delivery_appointment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= sales --> engineering (4 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= sales --> inventory (1 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_service_parts_stock_id` FOREIGN KEY (`service_parts_stock_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`service_parts_stock`(`service_parts_stock_id`);

-- ========= sales --> manufacturing (4 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`delivery_appointment` ADD CONSTRAINT `fk_sales_delivery_appointment_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);

-- ========= sales --> product (9 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `vibe_automotive_v1`.`product`.`msrp_price_book`(`msrp_price_book_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `vibe_automotive_v1`.`product`.`msrp_price_book`(`msrp_price_book_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);

-- ========= sales --> vehicle (24 constraint(s)) =========
-- Requires: sales schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_msrp_pricing_id` FOREIGN KEY (`msrp_pricing_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`msrp_pricing`(`msrp_pricing_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_vin_registry_id` FOREIGN KEY (`quote_vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_option_package_id` FOREIGN KEY (`option_package_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`option_package`(`option_package_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`vehicle_order` ADD CONSTRAINT `fk_sales_vehicle_order_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_option_package_id` FOREIGN KEY (`option_package_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`option_package`(`option_package_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_tertiary_order_vin_registry_id` FOREIGN KEY (`tertiary_order_vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`fleet_contract` ADD CONSTRAINT `fk_sales_fleet_contract_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`trade_in` ADD CONSTRAINT `fk_sales_trade_in_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`delivery_appointment` ADD CONSTRAINT `fk_sales_delivery_appointment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);

-- ========= supply --> compliance (6 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_plant` ADD CONSTRAINT `fk_supply_supplier_plant_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= supply --> dealer (1 constraint(s)) =========
-- Requires: supply schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= supply --> engineering (14 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= supply --> inventory (8 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_mrp_requirement_id` FOREIGN KEY (`mrp_requirement_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`mrp_requirement`(`mrp_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_movement_type_id` FOREIGN KEY (`movement_type_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`movement_type`(`movement_type_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);

-- ========= supply --> logistics (4 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_in_transit_inventory_id` FOREIGN KEY (`in_transit_inventory_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`in_transit_inventory`(`in_transit_inventory_id`);

-- ========= supply --> manufacturing (11 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);

-- ========= supply --> product (6 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_product_bom_line_id` FOREIGN KEY (`product_bom_line_id`) REFERENCES `vibe_automotive_v1`.`product`.`product_bom_line`(`product_bom_line_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);

-- ========= supply --> quality (6 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= supply --> vehicle (6 constraint(s)) =========
-- Requires: supply schema, vehicle schema
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);

-- ========= vehicle --> compliance (1 constraint(s)) =========
-- Requires: vehicle schema, compliance schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);

-- ========= vehicle --> customer (2 constraint(s)) =========
-- Requires: vehicle schema, customer schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ADD CONSTRAINT `fk_vehicle_ownership_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_automotive_v1`.`customer`.`party`(`party_id`);

-- ========= vehicle --> dealer (1 constraint(s)) =========
-- Requires: vehicle schema, dealer schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= vehicle --> engineering (10 constraint(s)) =========
-- Requires: vehicle schema, engineering schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ADD CONSTRAINT `fk_vehicle_powertrain_variant_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ADD CONSTRAINT `fk_vehicle_powertrain_variant_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` ADD CONSTRAINT `fk_vehicle_platform_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` ADD CONSTRAINT `fk_vehicle_platform_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`option_package` ADD CONSTRAINT `fk_vehicle_option_package_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);

-- ========= vehicle --> logistics (4 constraint(s)) =========
-- Requires: vehicle schema, logistics schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_compound_movement_id` FOREIGN KEY (`compound_movement_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`compound_movement`(`compound_movement_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_vehicle_handover_id` FOREIGN KEY (`vehicle_handover_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_handover`(`vehicle_handover_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ADD CONSTRAINT `fk_vehicle_ownership_vehicle_handover_id` FOREIGN KEY (`vehicle_handover_id`) REFERENCES `vibe_automotive_v1`.`logistics`.`vehicle_handover`(`vehicle_handover_id`);

-- ========= vehicle --> manufacturing (2 constraint(s)) =========
-- Requires: vehicle schema, manufacturing schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= vehicle --> product (8 constraint(s)) =========
-- Requires: vehicle schema, product schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`trim_level` ADD CONSTRAINT `fk_vehicle_trim_level_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ADD CONSTRAINT `fk_vehicle_powertrain_variant_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `vibe_automotive_v1`.`product`.`msrp_price_book`(`msrp_price_book_id`);

-- ========= vehicle --> quality (4 constraint(s)) =========
-- Requires: vehicle schema, quality schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_automotive_v1`.`quality`.`defect_record`(`defect_record_id`);

-- ========= vehicle --> sales (2 constraint(s)) =========
-- Requires: vehicle schema, sales schema
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `vibe_automotive_v1`.`sales`.`vehicle_order`(`vehicle_order_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ADD CONSTRAINT `fk_vehicle_ownership_vehicle_order_id` FOREIGN KEY (`vehicle_order_id`) REFERENCES `vibe_automotive_v1`.`sales`.`vehicle_order`(`vehicle_order_id`);

