-- Cross-Domain Foreign Keys for Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:27
-- Total cross-domain FK constraints: 1136
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, distribution, finance, ingredient, inventory, maintenance, manufacturing, marketing, pricing, procurement, product, quality, regulatory, research, sales, supply, sustainability, trade, workforce

-- ========= customer --> inventory (1 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= customer --> marketing (1 constraint(s)) =========
-- Requires: customer schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= customer --> pricing (1 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= customer --> procurement (1 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= customer --> product (1 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= customer --> quality (1 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `food_beverage_ecm`.`quality`.`capa`(`capa_id`);

-- ========= customer --> regulatory (1 constraint(s)) =========
-- Requires: customer schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`customer`.`recall_notification` ADD CONSTRAINT `fk_customer_recall_notification_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);

-- ========= customer --> research (1 constraint(s)) =========
-- Requires: customer schema, research schema
ALTER TABLE `food_beverage_ecm`.`customer`.`sponsorship` ADD CONSTRAINT `fk_customer_sponsorship_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= customer --> sales (3 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `food_beverage_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `food_beverage_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= customer --> workforce (8 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`loyalty_transaction` ADD CONSTRAINT `fk_customer_loyalty_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= distribution --> customer (10 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_edi_trading_partner_id` FOREIGN KEY (`edi_trading_partner_id`) REFERENCES `food_beverage_ecm`.`customer`.`edi_trading_partner`(`edi_trading_partner_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= distribution --> finance (8 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ADD CONSTRAINT `fk_distribution_yard_management_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= distribution --> ingredient (2 constraint(s)) =========
-- Requires: distribution schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);

-- ========= distribution --> inventory (2 constraint(s)) =========
-- Requires: distribution schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= distribution --> maintenance (2 constraint(s)) =========
-- Requires: distribution schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= distribution --> manufacturing (6 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= distribution --> marketing (6 constraint(s)) =========
-- Requires: distribution schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= distribution --> pricing (5 constraint(s)) =========
-- Requires: distribution schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ADD CONSTRAINT `fk_distribution_center_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);

-- ========= distribution --> procurement (6 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` ADD CONSTRAINT `fk_distribution_carton_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= distribution --> product (5 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= distribution --> regulatory (1 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= distribution --> research (4 constraint(s)) =========
-- Requires: distribution schema, research schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_experimental_formula_id` FOREIGN KEY (`experimental_formula_id`) REFERENCES `food_beverage_ecm`.`research`.`experimental_formula`(`experimental_formula_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ADD CONSTRAINT `fk_distribution_yard_management_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= distribution --> sales (5 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= distribution --> sustainability (2 constraint(s)) =========
-- Requires: distribution schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_lifecycle_assessment_id` FOREIGN KEY (`lifecycle_assessment_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`lifecycle_assessment`(`lifecycle_assessment_id`);

-- ========= distribution --> trade (2 constraint(s)) =========
-- Requires: distribution schema, trade schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_promotion_line_id` FOREIGN KEY (`promotion_line_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_line`(`promotion_line_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);

-- ========= distribution --> workforce (12 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ADD CONSTRAINT `fk_distribution_yard_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> customer (2 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= finance --> procurement (4 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= finance --> regulatory (2 constraint(s)) =========
-- Requires: finance schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= finance --> sales (1 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= finance --> supply (1 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `food_beverage_ecm`.`supply`.`sop_cycle`(`sop_cycle_id`);

-- ========= finance --> sustainability (4 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);

-- ========= finance --> workforce (11 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_primary_finance_employee_id` FOREIGN KEY (`primary_finance_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_forecast_employee_id` FOREIGN KEY (`forecast_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= ingredient --> customer (5 constraint(s)) =========
-- Requires: ingredient schema, customer schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ADD CONSTRAINT `fk_ingredient_ingredient_price_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= ingredient --> distribution (3 constraint(s)) =========
-- Requires: ingredient schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);

-- ========= ingredient --> finance (3 constraint(s)) =========
-- Requires: ingredient schema, finance schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= ingredient --> inventory (1 constraint(s)) =========
-- Requires: ingredient schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= ingredient --> maintenance (3 constraint(s)) =========
-- Requires: ingredient schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ADD CONSTRAINT `fk_ingredient_material_asset_cleaning_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= ingredient --> manufacturing (1 constraint(s)) =========
-- Requires: ingredient schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ADD CONSTRAINT `fk_ingredient_supplier_document_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= ingredient --> marketing (2 constraint(s)) =========
-- Requires: ingredient schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);

-- ========= ingredient --> procurement (16 constraint(s)) =========
-- Requires: ingredient schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_category_strategy_id` FOREIGN KEY (`category_strategy_id`) REFERENCES `food_beverage_ecm`.`procurement`.`category_strategy`(`category_strategy_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ADD CONSTRAINT `fk_ingredient_organic_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ADD CONSTRAINT `fk_ingredient_supplier_document_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ADD CONSTRAINT `fk_ingredient_substitution_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ADD CONSTRAINT `fk_ingredient_ingredient_price_history_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` ADD CONSTRAINT `fk_ingredient_sample_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= ingredient --> product (2 constraint(s)) =========
-- Requires: ingredient schema, product schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= ingredient --> quality (6 constraint(s)) =========
-- Requires: ingredient schema, quality schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= ingredient --> regulatory (5 constraint(s)) =========
-- Requires: ingredient schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);

-- ========= ingredient --> research (1 constraint(s)) =========
-- Requires: ingredient schema, research schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ADD CONSTRAINT `fk_ingredient_formulation_ingredient_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);

-- ========= ingredient --> sales (1 constraint(s)) =========
-- Requires: ingredient schema, sales schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= ingredient --> supply (1 constraint(s)) =========
-- Requires: ingredient schema, supply schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= ingredient --> workforce (9 constraint(s)) =========
-- Requires: ingredient schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ADD CONSTRAINT `fk_ingredient_supplier_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ADD CONSTRAINT `fk_ingredient_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ADD CONSTRAINT `fk_ingredient_ingredient_price_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> customer (1 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= inventory --> distribution (5 constraint(s)) =========
-- Requires: inventory schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= inventory --> finance (7 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= inventory --> ingredient (4 constraint(s)) =========
-- Requires: inventory schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= inventory --> manufacturing (7 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_production_line_work_center_id` FOREIGN KEY (`production_line_work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);

-- ========= inventory --> pricing (6 constraint(s)) =========
-- Requires: inventory schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `food_beverage_ecm`.`pricing`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);

-- ========= inventory --> procurement (4 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= inventory --> product (7 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_sku_id` FOREIGN KEY (`adjustment_sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> quality (1 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> regulatory (9 constraint(s)) =========
-- Requires: inventory schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ADD CONSTRAINT `fk_inventory_shelf_life_monitor_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= inventory --> research (4 constraint(s)) =========
-- Requires: inventory schema, research schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= inventory --> sales (3 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= inventory --> sustainability (1 constraint(s)) =========
-- Requires: inventory schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);

-- ========= inventory --> trade (2 constraint(s)) =========
-- Requires: inventory schema, trade schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= inventory --> workforce (21 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_primary_goods_employee_id` FOREIGN KEY (`primary_goods_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_tertiary_stock_approved_by_user_employee_id` FOREIGN KEY (`tertiary_stock_approved_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_employee_id` FOREIGN KEY (`adjustment_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_tertiary_quarantine_modified_by_user_employee_id` FOREIGN KEY (`tertiary_quarantine_modified_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ADD CONSTRAINT `fk_inventory_wip_stock_production_shift_id` FOREIGN KEY (`production_shift_id`) REFERENCES `food_beverage_ecm`.`workforce`.`production_shift`(`production_shift_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_reservation_employee_id` FOREIGN KEY (`reservation_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_reservation_modified_by_user_employee_id` FOREIGN KEY (`reservation_modified_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ADD CONSTRAINT `fk_inventory_shelf_life_monitor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= maintenance --> customer (6 constraint(s)) =========
-- Requires: maintenance schema, customer schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ADD CONSTRAINT `fk_maintenance_maintenance_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ADD CONSTRAINT `fk_maintenance_maintenance_contract_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);

-- ========= maintenance --> distribution (1 constraint(s)) =========
-- Requires: maintenance schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= maintenance --> finance (5 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= maintenance --> inventory (8 constraint(s)) =========
-- Requires: maintenance schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ADD CONSTRAINT `fk_maintenance_failure_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ADD CONSTRAINT `fk_maintenance_calibration_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= maintenance --> manufacturing (13 constraint(s)) =========
-- Requires: maintenance schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ADD CONSTRAINT `fk_maintenance_asset_hierarchy_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ADD CONSTRAINT `fk_maintenance_crew_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_facility_plant_id` FOREIGN KEY (`facility_plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ADD CONSTRAINT `fk_maintenance_lubrication_route_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ADD CONSTRAINT `fk_maintenance_asset_replacement_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ADD CONSTRAINT `fk_maintenance_asset_replacement_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= maintenance --> marketing (2 constraint(s)) =========
-- Requires: maintenance schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= maintenance --> procurement (6 constraint(s)) =========
-- Requires: maintenance schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ADD CONSTRAINT `fk_maintenance_maintenance_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ADD CONSTRAINT `fk_maintenance_maintenance_contract_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ADD CONSTRAINT `fk_maintenance_contractor_visit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= maintenance --> product (1 constraint(s)) =========
-- Requires: maintenance schema, product schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= maintenance --> regulatory (2 constraint(s)) =========
-- Requires: maintenance schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= maintenance --> research (2 constraint(s)) =========
-- Requires: maintenance schema, research schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= maintenance --> sales (3 constraint(s)) =========
-- Requires: maintenance schema, sales schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= maintenance --> supply (2 constraint(s)) =========
-- Requires: maintenance schema, supply schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`plan`(`plan_id`);

-- ========= maintenance --> trade (2 constraint(s)) =========
-- Requires: maintenance schema, trade schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ADD CONSTRAINT `fk_maintenance_maintenance_contract_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);

-- ========= maintenance --> workforce (17 constraint(s)) =========
-- Requires: maintenance schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ADD CONSTRAINT `fk_maintenance_failure_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ADD CONSTRAINT `fk_maintenance_calibration_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ADD CONSTRAINT `fk_maintenance_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_quaternary_permit_updated_by_user_employee_id` FOREIGN KEY (`quaternary_permit_updated_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_quinary_permit_approved_by_employee_id` FOREIGN KEY (`quinary_permit_approved_by_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_tertiary_permit_created_by_user_employee_id` FOREIGN KEY (`tertiary_permit_created_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ADD CONSTRAINT `fk_maintenance_asset_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_tertiary_lubrication_updated_by_user_employee_id` FOREIGN KEY (`tertiary_lubrication_updated_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ADD CONSTRAINT `fk_maintenance_asset_replacement_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= manufacturing --> customer (2 constraint(s)) =========
-- Requires: manufacturing schema, customer schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= manufacturing --> distribution (1 constraint(s)) =========
-- Requires: manufacturing schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);

-- ========= manufacturing --> finance (4 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= manufacturing --> ingredient (1 constraint(s)) =========
-- Requires: manufacturing schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);

-- ========= manufacturing --> inventory (2 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= manufacturing --> maintenance (2 constraint(s)) =========
-- Requires: manufacturing schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= manufacturing --> marketing (2 constraint(s)) =========
-- Requires: manufacturing schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= manufacturing --> pricing (1 constraint(s)) =========
-- Requires: manufacturing schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= manufacturing --> procurement (13 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_routing_toll_manufacturer_supplier_id` FOREIGN KEY (`routing_toll_manufacturer_supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= manufacturing --> product (14 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`oee_event` ADD CONSTRAINT `fk_manufacturing_oee_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_changeover_sku_to_sku_id` FOREIGN KEY (`changeover_sku_to_sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`manufacturing_production_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_production_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> quality (4 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `food_beverage_ecm`.`quality`.`capa`(`capa_id`);

-- ========= manufacturing --> regulatory (3 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= manufacturing --> research (3 constraint(s)) =========
-- Requires: manufacturing schema, research schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);

-- ========= manufacturing --> sales (2 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= manufacturing --> supply (4 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= manufacturing --> sustainability (3 constraint(s)) =========
-- Requires: manufacturing schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_waste_generation_id` FOREIGN KEY (`waste_generation_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`waste_generation`(`waste_generation_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_environmental_instrument_id` FOREIGN KEY (`environmental_instrument_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`environmental_instrument`(`environmental_instrument_id`);

-- ========= manufacturing --> trade (5 constraint(s)) =========
-- Requires: manufacturing schema, trade schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`copacking_order` ADD CONSTRAINT `fk_manufacturing_copacking_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= manufacturing --> workforce (22 constraint(s)) =========
-- Requires: manufacturing schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_shift_id` FOREIGN KEY (`production_shift_id`) REFERENCES `food_beverage_ecm`.`workforce`.`production_shift`(`production_shift_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_tertiary_batch_qa_reviewer_employee_id` FOREIGN KEY (`tertiary_batch_qa_reviewer_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`oee_event` ADD CONSTRAINT `fk_manufacturing_oee_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`oee_event` ADD CONSTRAINT `fk_manufacturing_oee_event_production_shift_id` FOREIGN KEY (`production_shift_id`) REFERENCES `food_beverage_ecm`.`workforce`.`production_shift`(`production_shift_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_changeover_sanitation_crew_lead_employee_id` FOREIGN KEY (`changeover_sanitation_crew_lead_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_tertiary_gmp_closed_by_employee_id` FOREIGN KEY (`tertiary_gmp_closed_by_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`manufacturing_production_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_production_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_routing_created_by_employee_id` FOREIGN KEY (`routing_created_by_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_routing_employee_id` FOREIGN KEY (`routing_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_routing_modified_by_employee_id` FOREIGN KEY (`routing_modified_by_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> customer (6 constraint(s)) =========
-- Requires: marketing schema, customer schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ADD CONSTRAINT `fk_marketing_brand_equity_tracker_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ADD CONSTRAINT `fk_marketing_consumer_promotion_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= marketing --> distribution (1 constraint(s)) =========
-- Requires: marketing schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= marketing --> finance (7 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= marketing --> inventory (4 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ADD CONSTRAINT `fk_marketing_consumer_promotion_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= marketing --> manufacturing (1 constraint(s)) =========
-- Requires: marketing schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= marketing --> procurement (5 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);

-- ========= marketing --> product (8 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ADD CONSTRAINT `fk_marketing_digital_asset_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `food_beverage_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ADD CONSTRAINT `fk_marketing_consumer_promotion_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= marketing --> quality (1 constraint(s)) =========
-- Requires: marketing schema, quality schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ADD CONSTRAINT `fk_marketing_claim_substantiation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= marketing --> regulatory (3 constraint(s)) =========
-- Requires: marketing schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ADD CONSTRAINT `fk_marketing_claim_substantiation_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);

-- ========= marketing --> research (4 constraint(s)) =========
-- Requires: marketing schema, research schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);

-- ========= marketing --> sustainability (1 constraint(s)) =========
-- Requires: marketing schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);

-- ========= marketing --> trade (5 constraint(s)) =========
-- Requires: marketing schema, trade schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ADD CONSTRAINT `fk_marketing_digital_asset_promotion_line_id` FOREIGN KEY (`promotion_line_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_line`(`promotion_line_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= marketing --> workforce (8 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim_substantiation` ADD CONSTRAINT `fk_marketing_claim_substantiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`digital_asset` ADD CONSTRAINT `fk_marketing_digital_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`shopper_program` ADD CONSTRAINT `fk_marketing_shopper_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_promotion` ADD CONSTRAINT `fk_marketing_consumer_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= pricing --> customer (6 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ADD CONSTRAINT `fk_pricing_promotional_price_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ADD CONSTRAINT `fk_pricing_customer_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ADD CONSTRAINT `fk_pricing_retail_shelf_price_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ADD CONSTRAINT `fk_pricing_revenue_realization_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= pricing --> distribution (1 constraint(s)) =========
-- Requires: pricing schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_assignment` ADD CONSTRAINT `fk_pricing_price_list_assignment_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= pricing --> finance (10 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ADD CONSTRAINT `fk_pricing_procedure_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_receiving_entity_company_code_id` FOREIGN KEY (`receiving_entity_company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ADD CONSTRAINT `fk_pricing_revenue_realization_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= pricing --> ingredient (2 constraint(s)) =========
-- Requires: pricing schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`transfer_price` ADD CONSTRAINT `fk_pricing_transfer_price_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= pricing --> marketing (3 constraint(s)) =========
-- Requires: pricing schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ADD CONSTRAINT `fk_pricing_promotional_price_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= pricing --> procurement (6 constraint(s)) =========
-- Requires: pricing schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);

-- ========= pricing --> product (12 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ADD CONSTRAINT `fk_pricing_promotional_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ADD CONSTRAINT `fk_pricing_pricing_price_history_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`customer_price_agreement` ADD CONSTRAINT `fk_pricing_customer_price_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ADD CONSTRAINT `fk_pricing_price_exception_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ADD CONSTRAINT `fk_pricing_retail_shelf_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_elasticity` ADD CONSTRAINT `fk_pricing_price_elasticity_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`foodservice_price` ADD CONSTRAINT `fk_pricing_foodservice_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`dtc_price` ADD CONSTRAINT `fk_pricing_dtc_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`revenue_realization` ADD CONSTRAINT `fk_pricing_revenue_realization_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= pricing --> quality (2 constraint(s)) =========
-- Requires: pricing schema, quality schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `food_beverage_ecm`.`quality`.`non_conformance`(`non_conformance_id`);

-- ========= pricing --> regulatory (6 constraint(s)) =========
-- Requires: pricing schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ADD CONSTRAINT `fk_pricing_promotional_price_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`pricing_price_history` ADD CONSTRAINT `fk_pricing_pricing_price_history_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= pricing --> research (3 constraint(s)) =========
-- Requires: pricing schema, research schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);

-- ========= pricing --> sales (7 constraint(s)) =========
-- Requires: pricing schema, sales schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `food_beverage_ecm`.`sales`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_sales_organization_id` FOREIGN KEY (`sales_organization_id`) REFERENCES `food_beverage_ecm`.`sales`.`sales_organization`(`sales_organization_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ADD CONSTRAINT `fk_pricing_price_exception_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ADD CONSTRAINT `fk_pricing_price_exception_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `food_beverage_ecm`.`sales`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`competitor_price` ADD CONSTRAINT `fk_pricing_competitor_price_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`retail_shelf_price` ADD CONSTRAINT `fk_pricing_retail_shelf_price_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_waterfall` ADD CONSTRAINT `fk_pricing_price_waterfall_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `food_beverage_ecm`.`sales`.`pos_transaction`(`pos_transaction_id`);

-- ========= pricing --> supply (4 constraint(s)) =========
-- Requires: pricing schema, supply schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_ibp_scenario_id` FOREIGN KEY (`ibp_scenario_id`) REFERENCES `food_beverage_ecm`.`supply`.`ibp_scenario`(`ibp_scenario_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `food_beverage_ecm`.`supply`.`plan_version`(`plan_version_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_condition` ADD CONSTRAINT `fk_pricing_price_condition_demand_balance_id` FOREIGN KEY (`demand_balance_id`) REFERENCES `food_beverage_ecm`.`supply`.`demand_balance`(`demand_balance_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ADD CONSTRAINT `fk_pricing_procedure_step_capacity_constraint_id` FOREIGN KEY (`capacity_constraint_id`) REFERENCES `food_beverage_ecm`.`supply`.`capacity_constraint`(`capacity_constraint_id`);

-- ========= pricing --> sustainability (3 constraint(s)) =========
-- Requires: pricing schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);

-- ========= pricing --> workforce (14 constraint(s)) =========
-- Requires: pricing schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_list_line` ADD CONSTRAINT `fk_pricing_price_list_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure` ADD CONSTRAINT `fk_pricing_procedure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`procedure_step` ADD CONSTRAINT `fk_pricing_procedure_step_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`cost_plus_model` ADD CONSTRAINT `fk_pricing_cost_plus_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`promotional_price` ADD CONSTRAINT `fk_pricing_promotional_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_change_request` ADD CONSTRAINT `fk_pricing_price_change_request_primary_price_employee_id` FOREIGN KEY (`primary_price_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_primary_price_employee_id` FOREIGN KEY (`primary_price_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_exception` ADD CONSTRAINT `fk_pricing_price_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`surcharge_rule` ADD CONSTRAINT `fk_pricing_surcharge_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`discount_rule` ADD CONSTRAINT `fk_pricing_discount_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`pricing`.`price_simulation` ADD CONSTRAINT `fk_pricing_price_simulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> customer (3 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= procurement --> finance (6 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> ingredient (6 constraint(s)) =========
-- Requires: procurement schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ADD CONSTRAINT `fk_procurement_supplier_approval_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= procurement --> inventory (1 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= procurement --> maintenance (3 constraint(s)) =========
-- Requires: procurement schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`spare_part`(`spare_part_id`);

-- ========= procurement --> manufacturing (3 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= procurement --> quality (1 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= procurement --> regulatory (4 constraint(s)) =========
-- Requires: procurement schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= procurement --> research (10 constraint(s)) =========
-- Requires: procurement schema, research schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ADD CONSTRAINT `fk_procurement_supplier_risk_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= procurement --> supply (1 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`demand_plan`(`demand_plan_id`);

-- ========= procurement --> sustainability (5 constraint(s)) =========
-- Requires: procurement schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ADD CONSTRAINT `fk_procurement_sustainability_partnership_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= procurement --> workforce (9 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_primary_purchase_requestor_employee_id` FOREIGN KEY (`primary_purchase_requestor_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> finance (7 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> inventory (1 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ADD CONSTRAINT `fk_product_inventory_allocation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= product --> maintenance (1 constraint(s)) =========
-- Requires: product schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ADD CONSTRAINT `fk_product_production_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= product --> manufacturing (4 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ADD CONSTRAINT `fk_product_product_production_bom_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= product --> marketing (3 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ADD CONSTRAINT `fk_product_lifecycle_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= product --> pricing (4 constraint(s)) =========
-- Requires: product schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_cost_plus_model_id` FOREIGN KEY (`cost_plus_model_id`) REFERENCES `food_beverage_ecm`.`pricing`.`cost_plus_model`(`cost_plus_model_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `food_beverage_ecm`.`pricing`.`procedure`(`procedure_id`);

-- ========= product --> procurement (3 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> quality (1 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= product --> regulatory (7 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_packaging_compliance_id` FOREIGN KEY (`packaging_compliance_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`packaging_compliance`(`packaging_compliance_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ADD CONSTRAINT `fk_product_lifecycle_event_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);

-- ========= product --> sustainability (4 constraint(s)) =========
-- Requires: product schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);

-- ========= product --> workforce (10 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ADD CONSTRAINT `fk_product_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ADD CONSTRAINT `fk_product_substitution_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> customer (3 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);

-- ========= quality --> distribution (5 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= quality --> finance (10 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ADD CONSTRAINT `fk_quality_qms_document_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ADD CONSTRAINT `fk_quality_process_validation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (2 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= quality --> maintenance (5 constraint(s)) =========
-- Requires: quality schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= quality --> manufacturing (10 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ADD CONSTRAINT `fk_quality_sensory_panel_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ADD CONSTRAINT `fk_quality_allergen_matrix_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ADD CONSTRAINT `fk_quality_process_validation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= quality --> marketing (7 constraint(s)) =========
-- Requires: quality schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ADD CONSTRAINT `fk_quality_allergen_matrix_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= quality --> procurement (2 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= quality --> product (13 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ADD CONSTRAINT `fk_quality_sensory_panel_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`allergen_matrix` ADD CONSTRAINT `fk_quality_allergen_matrix_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ADD CONSTRAINT `fk_quality_process_validation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= quality --> regulatory (7 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= quality --> research (6 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_lab_id` FOREIGN KEY (`lab_id`) REFERENCES `food_beverage_ecm`.`research`.`lab`(`lab_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ADD CONSTRAINT `fk_quality_sensory_panel_rd_sensory_panel_id` FOREIGN KEY (`rd_sensory_panel_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_sensory_panel`(`rd_sensory_panel_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ADD CONSTRAINT `fk_quality_qms_document_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= quality --> sales (3 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= quality --> sustainability (1 constraint(s)) =========
-- Requires: quality schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_supplier_esg_score_id` FOREIGN KEY (`supplier_esg_score_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`supplier_esg_score`(`supplier_esg_score_id`);

-- ========= quality --> trade (2 constraint(s)) =========
-- Requires: quality schema, trade schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= quality --> workforce (21 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_production_shift_id` FOREIGN KEY (`production_shift_id`) REFERENCES `food_beverage_ecm`.`workforce`.`production_shift`(`production_shift_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sensory_panel` ADD CONSTRAINT `fk_quality_sensory_panel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`shelf_life_study` ADD CONSTRAINT `fk_quality_shelf_life_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`qms_document` ADD CONSTRAINT `fk_quality_qms_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`process_validation` ADD CONSTRAINT `fk_quality_process_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_analyst_employee_id` FOREIGN KEY (`analyst_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= regulatory --> finance (1 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ADD CONSTRAINT `fk_regulatory_establishment_registration_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= regulatory --> maintenance (2 constraint(s)) =========
-- Requires: regulatory schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ADD CONSTRAINT `fk_regulatory_fsma_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= regulatory --> manufacturing (3 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ADD CONSTRAINT `fk_regulatory_facility_inspection_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`compliance_evidence` ADD CONSTRAINT `fk_regulatory_compliance_evidence_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= regulatory --> procurement (1 constraint(s)) =========
-- Requires: regulatory schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ADD CONSTRAINT `fk_regulatory_gfsi_certification_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= regulatory --> product (1 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`agency_submission` ADD CONSTRAINT `fk_regulatory_agency_submission_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= regulatory --> quality (1 constraint(s)) =========
-- Requires: regulatory schema, quality schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_qms_document_id` FOREIGN KEY (`qms_document_id`) REFERENCES `food_beverage_ecm`.`quality`.`qms_document`(`qms_document_id`);

-- ========= regulatory --> sustainability (4 constraint(s)) =========
-- Requires: regulatory schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ADD CONSTRAINT `fk_regulatory_nutrition_label_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ADD CONSTRAINT `fk_regulatory_packaging_compliance_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ADD CONSTRAINT `fk_regulatory_gfsi_certification_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= regulatory --> workforce (12 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ADD CONSTRAINT `fk_regulatory_establishment_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ADD CONSTRAINT `fk_regulatory_facility_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ADD CONSTRAINT `fk_regulatory_fsma_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ADD CONSTRAINT `fk_regulatory_label_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`agency_submission` ADD CONSTRAINT `fk_regulatory_agency_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ADD CONSTRAINT `fk_regulatory_import_export_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`regulation_change` ADD CONSTRAINT `fk_regulatory_regulation_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ADD CONSTRAINT `fk_regulatory_gfsi_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`compliance_evidence` ADD CONSTRAINT `fk_regulatory_compliance_evidence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= research --> customer (5 constraint(s)) =========
-- Requires: research schema, customer schema
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ADD CONSTRAINT `fk_research_external_collaboration_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ADD CONSTRAINT `fk_research_ingredient_feasibility_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= research --> finance (16 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `food_beverage_ecm`.`finance`.`forecast`(`forecast_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ADD CONSTRAINT `fk_research_rd_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`external_collaboration` ADD CONSTRAINT `fk_research_external_collaboration_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= research --> ingredient (5 constraint(s)) =========
-- Requires: research schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ADD CONSTRAINT `fk_research_sensory_result_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ADD CONSTRAINT `fk_research_ingredient_feasibility_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= research --> maintenance (1 constraint(s)) =========
-- Requires: research schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ADD CONSTRAINT `fk_research_rd_test_result_calibration_order_id` FOREIGN KEY (`calibration_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`calibration_order`(`calibration_order_id`);

-- ========= research --> manufacturing (8 constraint(s)) =========
-- Requires: research schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ADD CONSTRAINT `fk_research_rd_test_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= research --> product (12 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_target_sku_id` FOREIGN KEY (`target_sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ADD CONSTRAINT `fk_research_formulation_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ADD CONSTRAINT `fk_research_rd_sensory_panel_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`competitor_benchmark` ADD CONSTRAINT `fk_research_competitor_benchmark_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ADD CONSTRAINT `fk_research_ingredient_feasibility_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_session` ADD CONSTRAINT `fk_research_sensory_session_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= research --> regulatory (6 constraint(s)) =========
-- Requires: research schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ADD CONSTRAINT `fk_research_innovation_pipeline_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ADD CONSTRAINT `fk_research_formulation_version_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ADD CONSTRAINT `fk_research_concept_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ADD CONSTRAINT `fk_research_regulatory_submission_dossier_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= research --> sustainability (2 constraint(s)) =========
-- Requires: research schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ADD CONSTRAINT `fk_research_formulation_version_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);

-- ========= research --> workforce (24 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_rd_employee_id` FOREIGN KEY (`rd_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_tertiary_rd_sponsor_employee_id` FOREIGN KEY (`tertiary_rd_sponsor_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`innovation_pipeline` ADD CONSTRAINT `fk_research_innovation_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`experimental_formula` ADD CONSTRAINT `fk_research_experimental_formula_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`formulation_version` ADD CONSTRAINT `fk_research_formulation_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_sensory_panel` ADD CONSTRAINT `fk_research_rd_sensory_panel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`sensory_result` ADD CONSTRAINT `fk_research_sensory_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`pilot_trial` ADD CONSTRAINT `fk_research_pilot_trial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`technology_scout` ADD CONSTRAINT `fk_research_technology_scout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`stage_gate_review` ADD CONSTRAINT `fk_research_stage_gate_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ADD CONSTRAINT `fk_research_concept_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`concept` ADD CONSTRAINT `fk_research_concept_owner_user_employee_id` FOREIGN KEY (`owner_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_lab_sample` ADD CONSTRAINT `fk_research_rd_lab_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_request` ADD CONSTRAINT `fk_research_rd_test_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_test_result` ADD CONSTRAINT `fk_research_rd_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_budget` ADD CONSTRAINT `fk_research_rd_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`regulatory_submission_dossier` ADD CONSTRAINT `fk_research_regulatory_submission_dossier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`ingredient_feasibility` ADD CONSTRAINT `fk_research_ingredient_feasibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`scale_up_plan` ADD CONSTRAINT `fk_research_scale_up_plan_tertiary_scale_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_scale_last_modified_by_user_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`research`.`rd_milestone` ADD CONSTRAINT `fk_research_rd_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> customer (19 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_target_customer_account_id` FOREIGN KEY (`target_customer_account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`credit_memo` ADD CONSTRAINT `fk_sales_credit_memo_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= sales --> distribution (3 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= sales --> finance (7 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`credit_memo` ADD CONSTRAINT `fk_sales_credit_memo_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= sales --> inventory (1 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= sales --> manufacturing (2 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= sales --> marketing (6 constraint(s)) =========
-- Requires: sales schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`planogram` ADD CONSTRAINT `fk_sales_planogram_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);

-- ========= sales --> pricing (4 constraint(s)) =========
-- Requires: sales schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= sales --> procurement (4 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`credit_memo` ADD CONSTRAINT `fk_sales_credit_memo_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);

-- ========= sales --> product (3 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= sales --> quality (1 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= sales --> regulatory (2 constraint(s)) =========
-- Requires: sales schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= sales --> research (5 constraint(s)) =========
-- Requires: sales schema, research schema
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`planogram` ADD CONSTRAINT `fk_sales_planogram_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `food_beverage_ecm`.`research`.`concept`(`concept_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= sales --> supply (1 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `food_beverage_ecm`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`plan`(`plan_id`);

-- ========= sales --> sustainability (2 constraint(s)) =========
-- Requires: sales schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);

-- ========= sales --> trade (4 constraint(s)) =========
-- Requires: sales schema, trade schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);

-- ========= sales --> workforce (6 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`credit_memo` ADD CONSTRAINT `fk_sales_credit_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= supply --> distribution (14 constraint(s)) =========
-- Requires: supply schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_balance` ADD CONSTRAINT `fk_supply_demand_balance_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`lane` ADD CONSTRAINT `fk_supply_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`lane` ADD CONSTRAINT `fk_supply_lane_lane_carrier_id` FOREIGN KEY (`lane_carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`partner_sla` ADD CONSTRAINT `fk_supply_partner_sla_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= supply --> finance (11 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_balance` ADD CONSTRAINT `fk_supply_demand_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> ingredient (1 constraint(s)) =========
-- Requires: supply schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= supply --> inventory (4 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_balance` ADD CONSTRAINT `fk_supply_demand_balance_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= supply --> manufacturing (5 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= supply --> marketing (3 constraint(s)) =========
-- Requires: supply schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= supply --> procurement (7 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`partner_sla` ADD CONSTRAINT `fk_supply_partner_sla_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`partner_sla` ADD CONSTRAINT `fk_supply_partner_sla_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= supply --> product (10 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_balance` ADD CONSTRAINT `fk_supply_demand_balance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= supply --> quality (3 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `food_beverage_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= supply --> regulatory (3 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= supply --> research (2 constraint(s)) =========
-- Requires: supply schema, research schema
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan_version` ADD CONSTRAINT `fk_supply_plan_version_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= supply --> sales (4 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `food_beverage_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= supply --> sustainability (1 constraint(s)) =========
-- Requires: supply schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`supply`.`lane` ADD CONSTRAINT `fk_supply_lane_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);

-- ========= supply --> trade (2 constraint(s)) =========
-- Requires: supply schema, trade schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);

-- ========= supply --> workforce (12 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plan_employee_id` FOREIGN KEY (`plan_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`ibp_scenario` ADD CONSTRAINT `fk_supply_ibp_scenario_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`partner_sla` ADD CONSTRAINT `fk_supply_partner_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan_version` ADD CONSTRAINT `fk_supply_plan_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan_version` ADD CONSTRAINT `fk_supply_plan_version_primary_plan_employee_id` FOREIGN KEY (`primary_plan_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> ingredient (2 constraint(s)) =========
-- Requires: sustainability schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ADD CONSTRAINT `fk_sustainability_lifecycle_assessment_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= sustainability --> maintenance (5 constraint(s)) =========
-- Requires: sustainability schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ADD CONSTRAINT `fk_sustainability_audit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= sustainability --> manufacturing (10 constraint(s)) =========
-- Requires: sustainability schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ADD CONSTRAINT `fk_sustainability_circular_activity_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ADD CONSTRAINT `fk_sustainability_environmental_instrument_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= sustainability --> marketing (2 constraint(s)) =========
-- Requires: sustainability schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= sustainability --> procurement (4 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`supplier_esg_score` ADD CONSTRAINT `fk_sustainability_supplier_esg_score_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_activity` ADD CONSTRAINT `fk_sustainability_circular_activity_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= sustainability --> product (5 constraint(s)) =========
-- Requires: sustainability schema, product schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ADD CONSTRAINT `fk_sustainability_lifecycle_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`environmental_instrument` ADD CONSTRAINT `fk_sustainability_environmental_instrument_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= sustainability --> research (2 constraint(s)) =========
-- Requires: sustainability schema, research schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ADD CONSTRAINT `fk_sustainability_lifecycle_assessment_formulation_version_id` FOREIGN KEY (`formulation_version_id`) REFERENCES `food_beverage_ecm`.`research`.`formulation_version`(`formulation_version_id`);

-- ========= sustainability --> supply (1 constraint(s)) =========
-- Requires: sustainability schema, supply schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= sustainability --> workforce (13 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`packaging_profile` ADD CONSTRAINT `fk_sustainability_packaging_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`circular_program` ADD CONSTRAINT `fk_sustainability_circular_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`lifecycle_assessment` ADD CONSTRAINT `fk_sustainability_lifecycle_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`audit` ADD CONSTRAINT `fk_sustainability_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= trade --> customer (18 constraint(s)) =========
-- Requires: trade schema, customer schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_promotion_account_id` FOREIGN KEY (`promotion_account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ADD CONSTRAINT `fk_trade_slotting_fee_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_retailer_account_id` FOREIGN KEY (`retailer_account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ADD CONSTRAINT `fk_trade_category_captain_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ADD CONSTRAINT `fk_trade_coop_advertising_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= trade --> distribution (2 constraint(s)) =========
-- Requires: trade schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_dsd_route_id` FOREIGN KEY (`dsd_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);

-- ========= trade --> finance (8 constraint(s)) =========
-- Requires: trade schema, finance schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= trade --> inventory (3 constraint(s)) =========
-- Requires: trade schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ADD CONSTRAINT `fk_trade_slotting_fee_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= trade --> maintenance (1 constraint(s)) =========
-- Requires: trade schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= trade --> marketing (4 constraint(s)) =========
-- Requires: trade schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= trade --> pricing (5 constraint(s)) =========
-- Requires: trade schema, pricing schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ADD CONSTRAINT `fk_trade_promotion_price_assignment_price_list_line_id` FOREIGN KEY (`price_list_line_id`) REFERENCES `food_beverage_ecm`.`pricing`.`price_list_line`(`price_list_line_id`);

-- ========= trade --> procurement (3 constraint(s)) =========
-- Requires: trade schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_category_strategy_id` FOREIGN KEY (`category_strategy_id`) REFERENCES `food_beverage_ecm`.`procurement`.`category_strategy`(`category_strategy_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);

-- ========= trade --> product (5 constraint(s)) =========
-- Requires: trade schema, product schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= trade --> regulatory (2 constraint(s)) =========
-- Requires: trade schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= trade --> research (4 constraint(s)) =========
-- Requires: trade schema, research schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `food_beverage_ecm`.`research`.`rd_project`(`rd_project_id`);

-- ========= trade --> sales (2 constraint(s)) =========
-- Requires: trade schema, sales schema
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`sales_contract`(`sales_contract_id`);

-- ========= trade --> supply (3 constraint(s)) =========
-- Requires: trade schema, supply schema
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ADD CONSTRAINT `fk_trade_slotting_fee_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_ibp_scenario_id` FOREIGN KEY (`ibp_scenario_id`) REFERENCES `food_beverage_ecm`.`supply`.`ibp_scenario`(`ibp_scenario_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `food_beverage_ecm`.`supply`.`lane`(`lane_id`);

-- ========= trade --> sustainability (5 constraint(s)) =========
-- Requires: trade schema, sustainability schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ADD CONSTRAINT `fk_trade_slotting_fee_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ADD CONSTRAINT `fk_trade_coop_advertising_target_id` FOREIGN KEY (`target_id`) REFERENCES `food_beverage_ecm`.`sustainability`.`target`(`target_id`);

-- ========= trade --> workforce (8 constraint(s)) =========
-- Requires: trade schema, workforce schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ADD CONSTRAINT `fk_trade_slotting_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> maintenance (1 constraint(s)) =========
-- Requires: workforce schema, maintenance schema
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);

-- ========= workforce --> manufacturing (4 constraint(s)) =========
-- Requires: workforce schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ADD CONSTRAINT `fk_workforce_production_shift_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ADD CONSTRAINT `fk_workforce_production_shift_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);

-- ========= workforce --> supply (4 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ADD CONSTRAINT `fk_workforce_total_rewards_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);

