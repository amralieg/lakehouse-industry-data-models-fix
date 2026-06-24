-- Cross-Domain Foreign Keys for Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-24 01:59:39
-- Total cross-domain FK constraints: 484
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, design, equipment, fabrication, inventory, order, packaging, product, quality, sales, supply, test

-- ========= customer --> design (2 constraint(s)) =========
-- Requires: customer schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ADD CONSTRAINT `fk_customer_design_registration_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= customer --> packaging (4 constraint(s)) =========
-- Requires: customer schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ADD CONSTRAINT `fk_customer_design_registration_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= customer --> product (1 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);

-- ========= customer --> sales (2 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= design --> customer (3 constraint(s)) =========
-- Requires: design schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);

-- ========= design --> product (6 constraint(s)) =========
-- Requires: design schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`rtl_specification` ADD CONSTRAINT `fk_design_rtl_specification_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`timing_analysis_run` ADD CONSTRAINT `fk_design_timing_analysis_run_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);

-- ========= design --> supply (6 constraint(s)) =========
-- Requires: design schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_approved_vendor_id` FOREIGN KEY (`approved_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`approved_vendor`(`approved_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ic_design_project` ADD CONSTRAINT `fk_design_ic_design_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`ip_core` ADD CONSTRAINT `fk_design_ip_core_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`pdk` ADD CONSTRAINT `fk_design_pdk_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_approved_vendor_id` FOREIGN KEY (`approved_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`approved_vendor`(`approved_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`design`.`tapeout` ADD CONSTRAINT `fk_design_tapeout_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= equipment --> design (1 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= equipment --> fabrication (5 constraint(s)) =========
-- Requires: equipment schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_step`(`process_step_id`);

-- ========= equipment --> inventory (3 constraint(s)) =========
-- Requires: equipment schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= equipment --> product (1 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);

-- ========= equipment --> quality (4 constraint(s)) =========
-- Requires: equipment schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);

-- ========= equipment --> supply (4 constraint(s)) =========
-- Requires: equipment schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ADD CONSTRAINT `fk_equipment_fab_tool_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= fabrication --> customer (7 constraint(s)) =========
-- Requires: fabrication schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= fabrication --> design (10 constraint(s)) =========
-- Requires: fabrication schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);

-- ========= fabrication --> equipment (8 constraint(s)) =========
-- Requires: fabrication schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= fabrication --> inventory (3 constraint(s)) =========
-- Requires: fabrication schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= fabrication --> order (3 constraint(s)) =========
-- Requires: fabrication schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);

-- ========= fabrication --> product (12 constraint(s)) =========
-- Requires: fabrication schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`technology_node` ADD CONSTRAINT `fk_fabrication_technology_node_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= fabrication --> quality (13 constraint(s)) =========
-- Requires: fabrication schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);

-- ========= fabrication --> sales (4 constraint(s)) =========
-- Requires: fabrication schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= fabrication --> supply (11 constraint(s)) =========
-- Requires: fabrication schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ADD CONSTRAINT `fk_fabrication_process_recipe_approved_vendor_id` FOREIGN KEY (`approved_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`approved_vendor`(`approved_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`process_recipe` ADD CONSTRAINT `fk_fabrication_process_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= fabrication --> test (6 constraint(s)) =========
-- Requires: fabrication schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_parametric_measurement_id` FOREIGN KEY (`parametric_measurement_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`parametric_measurement`(`parametric_measurement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`lot_hold` ADD CONSTRAINT `fk_fabrication_lot_hold_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);
ALTER TABLE `vibe_semiconductors_v1`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);

-- ========= inventory --> customer (7 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);

-- ========= inventory --> design (7 constraint(s)) =========
-- Requires: inventory schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);

-- ========= inventory --> equipment (5 constraint(s)) =========
-- Requires: inventory schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);

-- ========= inventory --> fabrication (5 constraint(s)) =========
-- Requires: inventory schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);

-- ========= inventory --> order (5 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`order`(`order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`line`(`line_id`);

-- ========= inventory --> packaging (7 constraint(s)) =========
-- Requires: inventory schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);

-- ========= inventory --> product (5 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= inventory --> supply (28 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot` ADD CONSTRAINT `fk_inventory_inventory_wafer_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_approved_vendor_id` FOREIGN KEY (`approved_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`approved_vendor`(`approved_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`raw_material` ADD CONSTRAINT `fk_inventory_raw_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`finished_good` ADD CONSTRAINT `fk_inventory_finished_good_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_certification`(`material_certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`physical_inventory` ADD CONSTRAINT `fk_inventory_physical_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> test (2 constraint(s)) =========
-- Requires: inventory schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `vibe_semiconductors_v1`.`inventory`.`die_bank` ADD CONSTRAINT `fk_inventory_die_bank_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);

-- ========= order --> customer (19 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_design_registration_id` FOREIGN KEY (`design_registration_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_registration`(`design_registration_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);

-- ========= order --> design (3 constraint(s)) =========
-- Requires: order schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);

-- ========= order --> fabrication (4 constraint(s)) =========
-- Requires: order schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);

-- ========= order --> inventory (15 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);

-- ========= order --> packaging (8 constraint(s)) =========
-- Requires: order schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= order --> quality (8 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= order --> sales (6 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`order` ADD CONSTRAINT `fk_order_order_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`customer_contract`(`customer_contract_id`);

-- ========= order --> supply (3 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= order --> test (5 constraint(s)) =========
-- Requires: order schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);

-- ========= packaging --> customer (3 constraint(s)) =========
-- Requires: packaging schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);

-- ========= packaging --> design (6 constraint(s)) =========
-- Requires: packaging schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);

-- ========= packaging --> equipment (3 constraint(s)) =========
-- Requires: packaging schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);

-- ========= packaging --> fabrication (1 constraint(s)) =========
-- Requires: packaging schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= packaging --> inventory (4 constraint(s)) =========
-- Requires: packaging schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);

-- ========= packaging --> product (2 constraint(s)) =========
-- Requires: packaging schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= packaging --> quality (4 constraint(s)) =========
-- Requires: packaging schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`reliability_test`(`reliability_test_id`);

-- ========= packaging --> sales (1 constraint(s)) =========
-- Requires: packaging schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`booking`(`booking_id`);

-- ========= packaging --> supply (8 constraint(s)) =========
-- Requires: packaging schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ADD CONSTRAINT `fk_packaging_osat_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_supplier_qualification_id` FOREIGN KEY (`supplier_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier_qualification`(`supplier_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= packaging --> test (1 constraint(s)) =========
-- Requires: packaging schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`program`(`program_id`);

-- ========= product --> packaging (8 constraint(s)) =========
-- Requires: product schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_substrate_bom_id` FOREIGN KEY (`substrate_bom_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`substrate_bom`(`substrate_bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_substrate_bom_id` FOREIGN KEY (`substrate_bom_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`substrate_bom`(`substrate_bom_id`);

-- ========= product --> quality (6 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_kgd_certification_id` FOREIGN KEY (`kgd_certification_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`kgd_certification`(`kgd_certification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`reliability_test`(`reliability_test_id`);

-- ========= product --> supply (5 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ADD CONSTRAINT `fk_product_process_node_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= product --> test (1 constraint(s)) =========
-- Requires: product schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);

-- ========= quality --> customer (8 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);

-- ========= quality --> design (16 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_pdk_id` FOREIGN KEY (`pdk_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`pdk`(`pdk_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);

-- ========= quality --> equipment (4 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);

-- ========= quality --> fabrication (6 constraint(s)) =========
-- Requires: quality schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= quality --> inventory (15 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= quality --> order (1 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`rma`(`rma_id`);

-- ========= quality --> packaging (4 constraint(s)) =========
-- Requires: quality schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);

-- ========= quality --> product (4 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= quality --> supply (10 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= quality --> test (10 constraint(s)) =========
-- Requires: quality schema, test schema
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`quality_spec` ADD CONSTRAINT `fk_quality_quality_spec_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`limit`(`limit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `vibe_semiconductors_v1`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `vibe_semiconductors_v1`.`test`.`unit_test_result`(`unit_test_result_id`);

-- ========= sales --> customer (13 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);

-- ========= sales --> design (3 constraint(s)) =========
-- Requires: sales schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_ip_core_id` FOREIGN KEY (`ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ip_core`(`ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);

-- ========= sales --> fabrication (2 constraint(s)) =========
-- Requires: sales schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_technology_node_id` FOREIGN KEY (`technology_node_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`technology_node`(`technology_node_id`);

-- ========= sales --> inventory (3 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_die_bank_id` FOREIGN KEY (`die_bank_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`die_bank`(`die_bank_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);

-- ========= sales --> packaging (7 constraint(s)) =========
-- Requires: sales schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= sales --> product (7 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= sales --> quality (1 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `vibe_semiconductors_v1`.`quality`.`quality_spec`(`quality_spec_id`);

-- ========= sales --> supply (2 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= supply --> customer (1 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_nda_agreement_id` FOREIGN KEY (`nda_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`nda_agreement`(`nda_agreement_id`);

-- ========= supply --> inventory (5 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`raw_material`(`raw_material_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= supply --> order (2 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_backlog_position_id` FOREIGN KEY (`backlog_position_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`backlog_position`(`backlog_position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_semiconductors_v1`.`order`.`line`(`line_id`);

-- ========= supply --> product (2 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= supply --> sales (1 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`forecast`(`forecast_id`);

-- ========= test --> customer (2 constraint(s)) =========
-- Requires: test schema, customer schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= test --> design (13 constraint(s)) =========
-- Requires: test schema, design schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_verification_plan_id` FOREIGN KEY (`verification_plan_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`verification_plan`(`verification_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_physical_layout_id` FOREIGN KEY (`physical_layout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`physical_layout`(`physical_layout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_netlist_id` FOREIGN KEY (`netlist_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`netlist`(`netlist_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ic_design_project_id` FOREIGN KEY (`ic_design_project_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`ic_design_project`(`ic_design_project_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_tapeout_id` FOREIGN KEY (`tapeout_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`tapeout`(`tapeout_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`case` ADD CONSTRAINT `fk_test_case_rtl_specification_id` FOREIGN KEY (`rtl_specification_id`) REFERENCES `vibe_semiconductors_v1`.`design`.`rtl_specification`(`rtl_specification_id`);

-- ========= test --> equipment (6 constraint(s)) =========
-- Requires: test schema, equipment schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`ate_configuration` ADD CONSTRAINT `fk_test_ate_configuration_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= test --> fabrication (3 constraint(s)) =========
-- Requires: test schema, fabrication schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `vibe_semiconductors_v1`.`fabrication`.`process_step`(`process_step_id`);

-- ========= test --> inventory (2 constraint(s)) =========
-- Requires: test schema, inventory schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_finished_good_id` FOREIGN KEY (`finished_good_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`finished_good`(`finished_good_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_inventory_wafer_lot_id` FOREIGN KEY (`inventory_wafer_lot_id`) REFERENCES `vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`(`inventory_wafer_lot_id`);

-- ========= test --> packaging (2 constraint(s)) =========
-- Requires: test schema, packaging schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= test --> product (4 constraint(s)) =========
-- Requires: test schema, product schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`program` ADD CONSTRAINT `fk_test_program_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= test --> supply (4 constraint(s)) =========
-- Requires: test schema, supply schema
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`probe_card` ADD CONSTRAINT `fk_test_probe_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);

