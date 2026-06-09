-- Cross-Domain Foreign Keys for Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:37
-- Total cross-domain FK constraints: 885
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, customer, engineering, finance, inventory, order, product, production, quality, sales, supplier, supply

-- ========= asset --> customer (13 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);

-- ========= asset --> engineering (14 constraint(s)) =========
-- Requires: asset schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `manufacturing_ecm`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= asset --> finance (18 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `manufacturing_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `manufacturing_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `manufacturing_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= asset --> inventory (4 constraint(s)) =========
-- Requires: asset schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= asset --> order (1 constraint(s)) =========
-- Requires: asset schema, order schema
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `manufacturing_ecm`.`order`.`rma`(`rma_id`);

-- ========= asset --> product (7 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `manufacturing_ecm`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `manufacturing_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= asset --> production (14 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);

-- ========= asset --> sales (5 constraint(s)) =========
-- Requires: asset schema, sales schema
ALTER TABLE `manufacturing_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);

-- ========= asset --> supplier (17 constraint(s)) =========
-- Requires: asset schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);

-- ========= asset --> supply (3 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `manufacturing_ecm`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_safety_stock_policy_id` FOREIGN KEY (`safety_stock_policy_id`) REFERENCES `manufacturing_ecm`.`supply`.`safety_stock_policy`(`safety_stock_policy_id`);
ALTER TABLE `manufacturing_ecm`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `manufacturing_ecm`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= customer --> finance (10 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `manufacturing_ecm`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> product (1 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `manufacturing_ecm`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= customer --> sales (7 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);

-- ========= customer --> supplier (2 constraint(s)) =========
-- Requires: customer schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`customer`.`account_site` ADD CONSTRAINT `fk_customer_account_site_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);

-- ========= engineering --> asset (2 constraint(s)) =========
-- Requires: engineering schema, asset schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);

-- ========= engineering --> customer (8 constraint(s)) =========
-- Requires: engineering schema, customer schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);

-- ========= engineering --> finance (14 constraint(s)) =========
-- Requires: engineering schema, finance schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `manufacturing_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `manufacturing_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= engineering --> inventory (7 constraint(s)) =========
-- Requires: engineering schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);

-- ========= engineering --> product (4 constraint(s)) =========
-- Requires: engineering schema, product schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `manufacturing_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `manufacturing_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);

-- ========= engineering --> production (4 constraint(s)) =========
-- Requires: engineering schema, production schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);

-- ========= engineering --> quality (3 constraint(s)) =========
-- Requires: engineering schema, quality schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_fmea_id` FOREIGN KEY (`fmea_id`) REFERENCES `manufacturing_ecm`.`quality`.`fmea`(`fmea_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `manufacturing_ecm`.`quality`.`ncr`(`ncr_id`);

-- ========= engineering --> sales (2 constraint(s)) =========
-- Requires: engineering schema, sales schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);

-- ========= engineering --> supplier (15 constraint(s)) =========
-- Requires: engineering schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_revision` ADD CONSTRAINT `fk_engineering_engineering_revision_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `manufacturing_ecm`.`supplier`.`qualification`(`qualification_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `manufacturing_ecm`.`supplier`.`qualification`(`qualification_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `manufacturing_ecm`.`supplier`.`qualification`(`qualification_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);

-- ========= finance --> customer (3 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);

-- ========= finance --> product (4 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ADD CONSTRAINT `fk_finance_procurement_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= finance --> production (4 constraint(s)) =========
-- Requires: finance schema, production schema
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);

-- ========= finance --> supplier (10 constraint(s)) =========
-- Requires: finance schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ADD CONSTRAINT `fk_finance_procurement_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ADD CONSTRAINT `fk_finance_procurement_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ADD CONSTRAINT `fk_finance_procurement_contract_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> asset (2 constraint(s)) =========
-- Requires: inventory schema, asset schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `manufacturing_ecm`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `manufacturing_ecm`.`asset`.`asset_work_order`(`asset_work_order_id`);

-- ========= inventory --> customer (13 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);

-- ========= inventory --> engineering (3 constraint(s)) =========
-- Requires: inventory schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);

-- ========= inventory --> finance (13 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `manufacturing_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= inventory --> order (3 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);

-- ========= inventory --> product (6 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);

-- ========= inventory --> production (5 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);

-- ========= inventory --> quality (2 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> sales (1 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);

-- ========= inventory --> supplier (17 constraint(s)) =========
-- Requires: inventory schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);

-- ========= inventory --> supply (6 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `manufacturing_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `manufacturing_ecm`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `manufacturing_ecm`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_safety_stock_policy_id` FOREIGN KEY (`safety_stock_policy_id`) REFERENCES `manufacturing_ecm`.`supply`.`safety_stock_policy`(`safety_stock_policy_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `manufacturing_ecm`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `manufacturing_ecm`.`inventory`.`serialized_unit` ADD CONSTRAINT `fk_inventory_serialized_unit_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);

-- ========= order --> asset (4 constraint(s)) =========
-- Requires: order schema, asset schema
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `manufacturing_ecm`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= order --> customer (21 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_delivery_ship_to_party_customer_account_id` FOREIGN KEY (`delivery_ship_to_party_customer_account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);

-- ========= order --> engineering (8 constraint(s)) =========
-- Requires: order schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);

-- ========= order --> finance (15 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `manufacturing_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= order --> inventory (23 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= order --> product (7 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= order --> production (1 constraint(s)) =========
-- Requires: order schema, production schema
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= order --> sales (11 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `manufacturing_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `manufacturing_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);

-- ========= order --> supplier (8 constraint(s)) =========
-- Requires: order schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `manufacturing_ecm`.`supplier`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);

-- ========= product --> engineering (11 constraint(s)) =========
-- Requires: product schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `manufacturing_ecm`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `manufacturing_ecm`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= product --> finance (11 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> production (3 constraint(s)) =========
-- Requires: product schema, production schema
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);

-- ========= product --> quality (1 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_quality_audit_id` FOREIGN KEY (`quality_audit_id`) REFERENCES `manufacturing_ecm`.`quality`.`quality_audit`(`quality_audit_id`);

-- ========= product --> supplier (2 constraint(s)) =========
-- Requires: product schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);

-- ========= production --> asset (12 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `manufacturing_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `manufacturing_ecm`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);

-- ========= production --> customer (4 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);

-- ========= production --> engineering (20 constraint(s)) =========
-- Requires: production schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);

-- ========= production --> finance (16 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ADD CONSTRAINT `fk_production_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ADD CONSTRAINT `fk_production_plant_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= production --> inventory (18 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ADD CONSTRAINT `fk_production_plant_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= production --> order (5 constraint(s)) =========
-- Requires: production schema, order schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `manufacturing_ecm`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);

-- ========= production --> product (12 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `manufacturing_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);

-- ========= production --> quality (8 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `manufacturing_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `manufacturing_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `manufacturing_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `manufacturing_ecm`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `manufacturing_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);

-- ========= production --> sales (5 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);

-- ========= production --> supplier (18 constraint(s)) =========
-- Requires: production schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `manufacturing_ecm`.`supplier`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);

-- ========= production --> supply (10 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `manufacturing_ecm`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `manufacturing_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `manufacturing_ecm`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `manufacturing_ecm`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `manufacturing_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_capacity_plan_id` FOREIGN KEY (`capacity_plan_id`) REFERENCES `manufacturing_ecm`.`supply`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `manufacturing_ecm`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `manufacturing_ecm`.`supply`.`plan`(`plan_id`);

-- ========= quality --> asset (9 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `manufacturing_ecm`.`asset`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_location_id` FOREIGN KEY (`location_id`) REFERENCES `manufacturing_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= quality --> customer (13 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> engineering (19 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `manufacturing_ecm`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `manufacturing_ecm`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);

-- ========= quality --> finance (9 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);

-- ========= quality --> inventory (14 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `manufacturing_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);

-- ========= quality --> order (9 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `manufacturing_ecm`.`order`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `manufacturing_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `manufacturing_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `manufacturing_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `manufacturing_ecm`.`order`.`rma`(`rma_id`);

-- ========= quality --> product (15 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `manufacturing_ecm`.`product`.`product_specification`(`product_specification_id`);

-- ========= quality --> production (19 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);

-- ========= quality --> sales (6 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);

-- ========= quality --> supplier (21 constraint(s)) =========
-- Requires: quality schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `manufacturing_ecm`.`supplier`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `manufacturing_ecm`.`supplier`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);

-- ========= quality --> supply (6 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `manufacturing_ecm`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `manufacturing_ecm`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `manufacturing_ecm`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `manufacturing_ecm`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `manufacturing_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `manufacturing_ecm`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= sales --> customer (16 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `manufacturing_ecm`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `manufacturing_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);

-- ========= sales --> engineering (8 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);

-- ========= sales --> finance (17 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_ar_item_id` FOREIGN KEY (`ar_item_id`) REFERENCES `manufacturing_ecm`.`finance`.`ar_item`(`ar_item_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sales --> inventory (6 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_serialized_unit_id` FOREIGN KEY (`serialized_unit_id`) REFERENCES `manufacturing_ecm`.`inventory`.`serialized_unit`(`serialized_unit_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= sales --> product (9 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= sales --> supplier (6 constraint(s)) =========
-- Requires: sales schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);

-- ========= supplier --> asset (3 constraint(s)) =========
-- Requires: supplier schema, asset schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `manufacturing_ecm`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= supplier --> customer (6 constraint(s)) =========
-- Requires: supplier schema, customer schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `manufacturing_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);

-- ========= supplier --> engineering (10 constraint(s)) =========
-- Requires: supplier schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_project_id` FOREIGN KEY (`project_id`) REFERENCES `manufacturing_ecm`.`engineering`.`project`(`project_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `manufacturing_ecm`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);

-- ========= supplier --> finance (24 constraint(s)) =========
-- Requires: supplier schema, finance schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ADD CONSTRAINT `fk_supplier_supplier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ADD CONSTRAINT `fk_supplier_supplier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ADD CONSTRAINT `fk_supplier_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ADD CONSTRAINT `fk_supplier_scorecard_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supplier --> inventory (10 constraint(s)) =========
-- Requires: supplier schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ADD CONSTRAINT `fk_supplier_purchase_info_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= supplier --> order (1 constraint(s)) =========
-- Requires: supplier schema, order schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);

-- ========= supplier --> product (5 constraint(s)) =========
-- Requires: supplier schema, product schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ADD CONSTRAINT `fk_supplier_purchase_info_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= supplier --> sales (2 constraint(s)) =========
-- Requires: supplier schema, sales schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);

-- ========= supplier --> supply (5 constraint(s)) =========
-- Requires: supplier schema, supply schema
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `manufacturing_ecm`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `manufacturing_ecm`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `manufacturing_ecm`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `manufacturing_ecm`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `manufacturing_ecm`.`supply`.`plan`(`plan_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `manufacturing_ecm`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `manufacturing_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_account_site_id` FOREIGN KEY (`account_site_id`) REFERENCES `manufacturing_ecm`.`customer`.`account_site`(`account_site_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `manufacturing_ecm`.`customer`.`segment`(`segment_id`);

-- ========= supply --> engineering (7 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `manufacturing_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_engineering_revision_id` FOREIGN KEY (`engineering_revision_id`) REFERENCES `manufacturing_ecm`.`engineering`.`engineering_revision`(`engineering_revision_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_component_id` FOREIGN KEY (`component_id`) REFERENCES `manufacturing_ecm`.`engineering`.`component`(`component_id`);

-- ========= supply --> finance (12 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `manufacturing_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `manufacturing_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> inventory (15 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `manufacturing_ecm`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `manufacturing_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `manufacturing_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `manufacturing_ecm`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= supply --> order (3 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `manufacturing_ecm`.`order`.`blanket_order`(`blanket_order_id`);

-- ========= supply --> product (20 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `manufacturing_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `manufacturing_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);

-- ========= supply --> production (11 constraint(s)) =========
-- Requires: supply schema, production schema
ALTER TABLE `manufacturing_ecm`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);

-- ========= supply --> sales (7 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `manufacturing_ecm`.`sales`.`order_intake`(`order_intake_id`);

-- ========= supply --> supplier (14 constraint(s)) =========
-- Requires: supply schema, supplier schema
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);

