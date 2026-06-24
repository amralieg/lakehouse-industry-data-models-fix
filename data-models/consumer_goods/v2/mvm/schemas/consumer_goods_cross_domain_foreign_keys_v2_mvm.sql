-- Cross-Domain Foreign Keys for Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:11
-- Total cross-domain FK constraints: 337
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: distribution, finance, manufacturing, procurement, product, promotion, quality, sales, supply

-- ========= distribution --> finance (16 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);

-- ========= distribution --> manufacturing (8 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= distribution --> procurement (6 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= distribution --> product (4 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= distribution --> promotion (1 constraint(s)) =========
-- Requires: distribution schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= distribution --> quality (9 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= distribution --> sales (6 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_primary_outbound_sales_order_id` FOREIGN KEY (`primary_outbound_sales_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);

-- ========= distribution --> supply (7 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_atp_record_id` FOREIGN KEY (`atp_record_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`atp_record`(`atp_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_inventory_policy_id` FOREIGN KEY (`inventory_policy_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`inventory_policy`(`inventory_policy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`safety_stock`(`safety_stock_id`);

-- ========= finance --> manufacturing (10 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);

-- ========= finance --> procurement (5 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= finance --> product (3 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= finance --> sales (4 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= manufacturing --> finance (10 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= manufacturing --> procurement (4 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);

-- ========= manufacturing --> product (13 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`certification`(`certification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> promotion (3 constraint(s)) =========
-- Requires: manufacturing schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= manufacturing --> quality (5 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= manufacturing --> sales (4 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= manufacturing --> supply (6 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`safety_stock`(`safety_stock_id`);

-- ========= procurement --> finance (10 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= procurement --> manufacturing (1 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= procurement --> product (3 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);

-- ========= procurement --> quality (2 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);

-- ========= procurement --> sales (1 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);

-- ========= product --> finance (7 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> manufacturing (8 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= product --> procurement (6 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> sales (1 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= promotion --> finance (23 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= promotion --> procurement (3 constraint(s)) =========
-- Requires: promotion schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= promotion --> product (11 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= promotion --> sales (19 constraint(s)) =========
-- Requires: promotion schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`accrual` ADD CONSTRAINT `fk_promotion_accrual_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= quality --> finance (6 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> manufacturing (11 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= quality --> procurement (4 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= quality --> product (13 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= quality --> sales (5 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= sales --> distribution (1 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= sales --> finance (13 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);

-- ========= sales --> manufacturing (1 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= sales --> procurement (1 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= sales --> product (3 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= supply --> finance (18 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`standard_cost`(`standard_cost_id`);

-- ========= supply --> manufacturing (7 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`planned_order`(`planned_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);

-- ========= supply --> procurement (6 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);

-- ========= supply --> product (9 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= supply --> promotion (11 constraint(s)) =========
-- Requires: supply schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_event_id` FOREIGN KEY (`event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`event`(`event_id`);

-- ========= supply --> quality (2 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= supply --> sales (7 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

