-- Cross-Domain Foreign Keys for Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-06-24 10:28:49
-- Total cross-domain FK constraints: 626
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, customer, engineering, inventory, logistics, order, procurement, product, production, quality, sales, supply

-- ========= asset --> customer (11 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= asset --> engineering (14 constraint(s)) =========
-- Requires: asset schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= asset --> inventory (4 constraint(s)) =========
-- Requires: asset schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= asset --> logistics (3 constraint(s)) =========
-- Requires: asset schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= asset --> order (3 constraint(s)) =========
-- Requires: asset schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);

-- ========= asset --> procurement (6 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= asset --> product (4 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= asset --> production (12 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`downtime_event` ADD CONSTRAINT `fk_asset_downtime_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= asset --> sales (1 constraint(s)) =========
-- Requires: asset schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= billing --> asset (4 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= billing --> customer (4 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);

-- ========= billing --> engineering (4 constraint(s)) =========
-- Requires: billing schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);

-- ========= billing --> inventory (3 constraint(s)) =========
-- Requires: billing schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= billing --> logistics (6 constraint(s)) =========
-- Requires: billing schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= billing --> order (7 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_delivery_item_id` FOREIGN KEY (`delivery_item_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery_item`(`delivery_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= billing --> product (2 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= billing --> production (4 constraint(s)) =========
-- Requires: billing schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= billing --> quality (2 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= billing --> sales (10 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= customer --> billing (2 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= customer --> order (1 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= customer --> product (4 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= customer --> sales (8 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`sla_agreement` ADD CONSTRAINT `fk_customer_sla_agreement_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);

-- ========= engineering --> customer (8 constraint(s)) =========
-- Requires: engineering schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`drawing` ADD CONSTRAINT `fk_engineering_drawing_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`revision` ADD CONSTRAINT `fk_engineering_revision_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= engineering --> inventory (6 constraint(s)) =========
-- Requires: engineering schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= engineering --> product (8 constraint(s)) =========
-- Requires: engineering schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`component` ADD CONSTRAINT `fk_engineering_component_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`eco` ADD CONSTRAINT `fk_engineering_eco_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`ecn` ADD CONSTRAINT `fk_engineering_ecn_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`engineering_specification` ADD CONSTRAINT `fk_engineering_engineering_specification_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);

-- ========= inventory --> asset (1 constraint(s)) =========
-- Requires: inventory schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);

-- ========= inventory --> customer (5 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= inventory --> engineering (1 constraint(s)) =========
-- Requires: inventory schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= inventory --> logistics (1 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= inventory --> order (4 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= inventory --> procurement (3 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);

-- ========= inventory --> product (6 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);

-- ========= inventory --> production (3 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_wip_lot_id` FOREIGN KEY (`wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_wip_lot_id` FOREIGN KEY (`wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= inventory --> quality (2 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> sales (2 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= inventory --> supply (3 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);

-- ========= logistics --> asset (1 constraint(s)) =========
-- Requires: logistics schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);

-- ========= logistics --> billing (1 constraint(s)) =========
-- Requires: logistics schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= logistics --> customer (9 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= logistics --> engineering (5 constraint(s)) =========
-- Requires: logistics schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= logistics --> inventory (9 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ADD CONSTRAINT `fk_logistics_transport_route_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= logistics --> order (8 constraint(s)) =========
-- Requires: logistics schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);

-- ========= logistics --> procurement (2 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= logistics --> product (12 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`inbound_delivery` ADD CONSTRAINT `fk_logistics_inbound_delivery_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= logistics --> production (1 constraint(s)) =========
-- Requires: logistics schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`transport_route` ADD CONSTRAINT `fk_logistics_transport_route_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);

-- ========= logistics --> sales (3 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`delivery_note` ADD CONSTRAINT `fk_logistics_delivery_note_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= logistics --> supply (1 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);

-- ========= order --> asset (3 constraint(s)) =========
-- Requires: order schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`failure_record`(`failure_record_id`);

-- ========= order --> customer (15 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_delivery_ship_to_party_customer_account_id` FOREIGN KEY (`delivery_ship_to_party_customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);

-- ========= order --> engineering (10 constraint(s)) =========
-- Requires: order schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= order --> inventory (11 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= order --> product (7 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= order --> production (1 constraint(s)) =========
-- Requires: order schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= order --> quality (1 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= order --> sales (9 constraint(s)) =========
-- Requires: order schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`line` ADD CONSTRAINT `fk_order_line_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= procurement --> asset (4 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= procurement --> billing (4 constraint(s)) =========
-- Requires: procurement schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= procurement --> customer (2 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);

-- ========= procurement --> engineering (10 constraint(s)) =========
-- Requires: procurement schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= procurement --> inventory (11 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= procurement --> logistics (3 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);

-- ========= procurement --> order (4 constraint(s)) =========
-- Requires: procurement schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`blanket_order`(`blanket_order_id`);

-- ========= procurement --> product (8 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= procurement --> sales (4 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_quote_line_id` FOREIGN KEY (`quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);

-- ========= procurement --> supply (6 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);

-- ========= product --> engineering (2 constraint(s)) =========
-- Requires: product schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);

-- ========= product --> inventory (3 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_order_warehouse_id` FOREIGN KEY (`order_warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= product --> order (1 constraint(s)) =========
-- Requires: product schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);

-- ========= product --> production (1 constraint(s)) =========
-- Requires: product schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= production --> asset (9 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);

-- ========= production --> customer (2 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);

-- ========= production --> engineering (23 constraint(s)) =========
-- Requires: production schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_ecn_id` FOREIGN KEY (`ecn_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`ecn`(`ecn_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);

-- ========= production --> inventory (17 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= production --> order (7 constraint(s)) =========
-- Requires: production schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);

-- ========= production --> procurement (4 constraint(s)) =========
-- Requires: production schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= production --> product (11 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_product_bom_line_id` FOREIGN KEY (`product_bom_line_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_bom_line`(`product_bom_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= production --> quality (3 constraint(s)) =========
-- Requires: production schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= production --> sales (4 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= production --> supply (5 constraint(s)) =========
-- Requires: production schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);

-- ========= quality --> asset (6 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_calibration_record_id` FOREIGN KEY (`calibration_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`calibration_record`(`calibration_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);

-- ========= quality --> billing (1 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= quality --> customer (11 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`sla_agreement`(`sla_agreement_id`);

-- ========= quality --> engineering (13 constraint(s)) =========
-- Requires: quality schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);

-- ========= quality --> inventory (9 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= quality --> logistics (2 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_delivery_note_id` FOREIGN KEY (`delivery_note_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`delivery_note`(`delivery_note_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`shipment`(`shipment_id`);

-- ========= quality --> order (9 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_delivery_item_id` FOREIGN KEY (`delivery_item_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery_item`(`delivery_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_delivery_item_id` FOREIGN KEY (`delivery_item_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`delivery_item`(`delivery_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`rma`(`rma_id`);

-- ========= quality --> procurement (8 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= quality --> product (15 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit` ADD CONSTRAINT `fk_quality_supplier_quality_audit_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= quality --> production (17 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`fmea` ADD CONSTRAINT `fk_quality_fmea_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);

-- ========= quality --> sales (4 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`ppap_submission` ADD CONSTRAINT `fk_quality_ppap_submission_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_intake_id` FOREIGN KEY (`order_intake_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`order_intake`(`order_intake_id`);

-- ========= quality --> supply (1 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_manufacturing_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);

-- ========= sales --> customer (14 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_credit_profile_id` FOREIGN KEY (`credit_profile_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`address`(`address_id`);

-- ========= sales --> engineering (7 constraint(s)) =========
-- Requires: sales schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_engineering_specification_id` FOREIGN KEY (`engineering_specification_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`engineering_specification`(`engineering_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);

-- ========= sales --> inventory (3 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);

-- ========= sales --> logistics (1 constraint(s)) =========
-- Requires: sales schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);

-- ========= sales --> product (13 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= supply --> asset (3 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);

-- ========= supply --> billing (1 constraint(s)) =========
-- Requires: supply schema, billing schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= supply --> customer (3 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_manufacturing_v1`.`customer`.`segment`(`segment_id`);

-- ========= supply --> engineering (8 constraint(s)) =========
-- Requires: supply schema, engineering schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_eco_id` FOREIGN KEY (`eco_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`eco`(`eco_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`revision`(`revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_manufacturing_v1`.`engineering`.`component`(`component_id`);

-- ========= supply --> inventory (12 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_manufacturing_v1`.`inventory`.`stock_location`(`stock_location_id`);

-- ========= supply --> logistics (3 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `vibe_manufacturing_v1`.`logistics`.`transport_route`(`transport_route_id`);

-- ========= supply --> order (5 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_manufacturing_v1`.`order`.`line`(`line_id`);

-- ========= supply --> procurement (2 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);

-- ========= supply --> product (13 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);

-- ========= supply --> production (7 constraint(s)) =========
-- Requires: supply schema, production schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`plant`(`plant_id`);

-- ========= supply --> quality (2 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_supplier_quality_audit_id` FOREIGN KEY (`supplier_quality_audit_id`) REFERENCES `vibe_manufacturing_v1`.`quality`.`supplier_quality_audit`(`supplier_quality_audit_id`);

-- ========= supply --> sales (4 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);

