-- Cross-Domain Foreign Keys for Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:32
-- Total cross-domain FK constraints: 955
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, distribution, finance, ingredient, inventory, manufacturing, marketing, procurement, product, quality, regulatory, sales, supply, trade

-- ========= customer --> distribution (1 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);

-- ========= customer --> finance (3 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `food_beverage_ecm`.`customer`.`bill_to_location` ADD CONSTRAINT `fk_customer_bill_to_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ADD CONSTRAINT `fk_customer_edi_trading_partner_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= customer --> inventory (1 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= customer --> marketing (1 constraint(s)) =========
-- Requires: customer schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= customer --> procurement (2 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`edi_trading_partner` ADD CONSTRAINT `fk_customer_edi_trading_partner_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= customer --> regulatory (2 constraint(s)) =========
-- Requires: customer schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= customer --> sales (1 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `food_beverage_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `food_beverage_ecm`.`customer`.`ship_to_location` ADD CONSTRAINT `fk_customer_ship_to_location_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= distribution --> customer (12 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_edi_trading_partner_id` FOREIGN KEY (`edi_trading_partner_id`) REFERENCES `food_beverage_ecm`.`customer`.`edi_trading_partner`(`edi_trading_partner_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);

-- ========= distribution --> finance (11 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ADD CONSTRAINT `fk_distribution_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ADD CONSTRAINT `fk_distribution_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= distribution --> ingredient (1 constraint(s)) =========
-- Requires: distribution schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);

-- ========= distribution --> manufacturing (5 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= distribution --> marketing (11 constraint(s)) =========
-- Requires: distribution schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ADD CONSTRAINT `fk_distribution_center_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ADD CONSTRAINT `fk_distribution_location_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);

-- ========= distribution --> procurement (4 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ADD CONSTRAINT `fk_distribution_carrier_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= distribution --> product (6 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= distribution --> quality (1 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `food_beverage_ecm`.`quality`.`critical_control_point`(`critical_control_point_id`);

-- ========= distribution --> regulatory (9 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ADD CONSTRAINT `fk_distribution_center_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ADD CONSTRAINT `fk_distribution_carrier_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ADD CONSTRAINT `fk_distribution_location_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= distribution --> sales (13 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ADD CONSTRAINT `fk_distribution_center_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `food_beverage_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ADD CONSTRAINT `fk_distribution_location_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);

-- ========= distribution --> trade (8 constraint(s)) =========
-- Requires: distribution schema, trade schema
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_promotion_line_id` FOREIGN KEY (`promotion_line_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_line`(`promotion_line_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);

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

-- ========= finance --> product (3 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ADD CONSTRAINT `fk_finance_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);

-- ========= finance --> regulatory (4 constraint(s)) =========
-- Requires: finance schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`finance_standard_cost` ADD CONSTRAINT `fk_finance_finance_standard_cost_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= finance --> sales (5 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);

-- ========= finance --> supply (1 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `food_beverage_ecm`.`finance`.`forecast` ADD CONSTRAINT `fk_finance_forecast_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `food_beverage_ecm`.`supply`.`sop_cycle`(`sop_cycle_id`);

-- ========= ingredient --> customer (3 constraint(s)) =========
-- Requires: ingredient schema, customer schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= ingredient --> distribution (4 constraint(s)) =========
-- Requires: ingredient schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);

-- ========= ingredient --> finance (11 constraint(s)) =========
-- Requires: ingredient schema, finance schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= ingredient --> inventory (3 constraint(s)) =========
-- Requires: ingredient schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);

-- ========= ingredient --> manufacturing (4 constraint(s)) =========
-- Requires: ingredient schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= ingredient --> marketing (6 constraint(s)) =========
-- Requires: ingredient schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);

-- ========= ingredient --> procurement (19 constraint(s)) =========
-- Requires: ingredient schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `food_beverage_ecm`.`procurement`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= ingredient --> product (5 constraint(s)) =========
-- Requires: ingredient schema, product schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= ingredient --> quality (10 constraint(s)) =========
-- Requires: ingredient schema, quality schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_supplier_quality_assessment_id` FOREIGN KEY (`supplier_quality_assessment_id`) REFERENCES `food_beverage_ecm`.`quality`.`supplier_quality_assessment`(`supplier_quality_assessment_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `food_beverage_ecm`.`quality`.`product_recall`(`product_recall_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `food_beverage_ecm`.`quality`.`non_conformance`(`non_conformance_id`);

-- ========= ingredient --> regulatory (14 constraint(s)) =========
-- Requires: ingredient schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ADD CONSTRAINT `fk_ingredient_raw_material_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_gfsi_certification_id` FOREIGN KEY (`gfsi_certification_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`gfsi_certification`(`gfsi_certification_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= ingredient --> sales (2 constraint(s)) =========
-- Requires: ingredient schema, sales schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= ingredient --> supply (2 constraint(s)) =========
-- Requires: ingredient schema, supply schema
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= inventory --> distribution (11 constraint(s)) =========
-- Requires: inventory schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_cold_chain_event_id` FOREIGN KEY (`cold_chain_event_id`) REFERENCES `food_beverage_ecm`.`distribution`.`cold_chain_event`(`cold_chain_event_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= inventory --> finance (13 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= inventory --> ingredient (8 constraint(s)) =========
-- Requires: inventory schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_cost_id` FOREIGN KEY (`cost_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`cost`(`cost_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_allergen_id` FOREIGN KEY (`allergen_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`allergen`(`allergen_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`test_result`(`test_result_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= inventory --> manufacturing (10 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= inventory --> procurement (4 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= inventory --> product (16 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_sku_id` FOREIGN KEY (`adjustment_sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_product_standard_cost_id` FOREIGN KEY (`product_standard_cost_id`) REFERENCES `food_beverage_ecm`.`product`.`product_standard_cost`(`product_standard_cost_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> quality (1 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= inventory --> regulatory (9 constraint(s)) =========
-- Requires: inventory schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);

-- ========= inventory --> sales (3 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= inventory --> trade (2 constraint(s)) =========
-- Requires: inventory schema, trade schema
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= manufacturing --> customer (2 constraint(s)) =========
-- Requires: manufacturing schema, customer schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= manufacturing --> distribution (2 constraint(s)) =========
-- Requires: manufacturing schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);

-- ========= manufacturing --> finance (16 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_finance_standard_cost_id` FOREIGN KEY (`finance_standard_cost_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_standard_cost`(`finance_standard_cost_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `food_beverage_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `food_beverage_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= manufacturing --> ingredient (5 constraint(s)) =========
-- Requires: manufacturing schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_allergen_id` FOREIGN KEY (`allergen_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`allergen`(`allergen_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);

-- ========= manufacturing --> inventory (6 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `food_beverage_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= manufacturing --> marketing (7 constraint(s)) =========
-- Requires: manufacturing schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);

-- ========= manufacturing --> procurement (12 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_routing_toll_manufacturer_supplier_id` FOREIGN KEY (`routing_toll_manufacturer_supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= manufacturing --> product (10 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_bom_line_id` FOREIGN KEY (`bom_line_id`) REFERENCES `food_beverage_ecm`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> quality (7 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `food_beverage_ecm`.`quality`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);

-- ========= manufacturing --> regulatory (8 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= manufacturing --> sales (3 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= manufacturing --> supply (9 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_capacity_constraint_id` FOREIGN KEY (`capacity_constraint_id`) REFERENCES `food_beverage_ecm`.`supply`.`capacity_constraint`(`capacity_constraint_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ADD CONSTRAINT `fk_manufacturing_plant_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= manufacturing --> trade (4 constraint(s)) =========
-- Requires: manufacturing schema, trade schema
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= marketing --> customer (4 constraint(s)) =========
-- Requires: marketing schema, customer schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ADD CONSTRAINT `fk_marketing_brand_equity_tracker_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);

-- ========= marketing --> finance (10 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ADD CONSTRAINT `fk_marketing_brand_equity_tracker_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= marketing --> procurement (5 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= marketing --> product (13 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ADD CONSTRAINT `fk_marketing_syndicated_market_data_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`syndicated_market_data` ADD CONSTRAINT `fk_marketing_syndicated_market_data_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand_equity_tracker` ADD CONSTRAINT `fk_marketing_brand_equity_tracker_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_nutritional_panel_id` FOREIGN KEY (`nutritional_panel_id`) REFERENCES `food_beverage_ecm`.`product`.`nutritional_panel`(`nutritional_panel_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= marketing --> quality (1 constraint(s)) =========
-- Requires: marketing schema, quality schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= marketing --> regulatory (8 constraint(s)) =========
-- Requires: marketing schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`consumer_insight` ADD CONSTRAINT `fk_marketing_consumer_insight_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);
ALTER TABLE `food_beverage_ecm`.`marketing`.`claim` ADD CONSTRAINT `fk_marketing_claim_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= marketing --> trade (1 constraint(s)) =========
-- Requires: marketing schema, trade schema
ALTER TABLE `food_beverage_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);

-- ========= procurement --> customer (1 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= procurement --> distribution (3 constraint(s)) =========
-- Requires: procurement schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);

-- ========= procurement --> finance (8 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> ingredient (6 constraint(s)) =========
-- Requires: procurement schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= procurement --> inventory (5 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= procurement --> manufacturing (6 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= procurement --> product (2 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);

-- ========= procurement --> quality (4 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_supplier_quality_assessment_id` FOREIGN KEY (`supplier_quality_assessment_id`) REFERENCES `food_beverage_ecm`.`quality`.`supplier_quality_assessment`(`supplier_quality_assessment_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= procurement --> regulatory (4 constraint(s)) =========
-- Requires: procurement schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_fsma_record_id` FOREIGN KEY (`fsma_record_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`fsma_record`(`fsma_record_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= procurement --> supply (1 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `food_beverage_ecm`.`supply`.`demand_plan`(`demand_plan_id`);

-- ========= product --> customer (4 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);

-- ========= product --> finance (8 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> ingredient (1 constraint(s)) =========
-- Requires: product schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= product --> manufacturing (8 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`routing`(`routing_id`);

-- ========= product --> marketing (2 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= product --> procurement (6 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `food_beverage_ecm`.`procurement`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);

-- ========= product --> quality (4 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= product --> regulatory (8 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_packaging_compliance_id` FOREIGN KEY (`packaging_compliance_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`packaging_compliance`(`packaging_compliance_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);

-- ========= quality --> customer (5 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> distribution (13 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_otif_record_id` FOREIGN KEY (`otif_record_id`) REFERENCES `food_beverage_ecm`.`distribution`.`otif_record`(`otif_record_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_cold_chain_event_id` FOREIGN KEY (`cold_chain_event_id`) REFERENCES `food_beverage_ecm`.`distribution`.`cold_chain_event`(`cold_chain_event_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_cold_chain_event_id` FOREIGN KEY (`cold_chain_event_id`) REFERENCES `food_beverage_ecm`.`distribution`.`cold_chain_event`(`cold_chain_event_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);

-- ========= quality --> finance (15 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= quality --> inventory (11 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `food_beverage_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `food_beverage_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= quality --> manufacturing (16 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= quality --> marketing (7 constraint(s)) =========
-- Requires: quality schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `food_beverage_ecm`.`marketing`.`claim`(`claim_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= quality --> procurement (13 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);

-- ========= quality --> product (20 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= quality --> regulatory (13 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`critical_control_point` ADD CONSTRAINT `fk_quality_critical_control_point_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_facility_inspection_id` FOREIGN KEY (`facility_inspection_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`supplier_quality_assessment` ADD CONSTRAINT `fk_quality_supplier_quality_assessment_gfsi_certification_id` FOREIGN KEY (`gfsi_certification_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`gfsi_certification`(`gfsi_certification_id`);

-- ========= quality --> sales (7 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `food_beverage_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);

-- ========= quality --> supply (6 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `food_beverage_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_capacity_constraint_id` FOREIGN KEY (`capacity_constraint_id`) REFERENCES `food_beverage_ecm`.`supply`.`capacity_constraint`(`capacity_constraint_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`micro_test_result` ADD CONSTRAINT `fk_quality_micro_test_result_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`food_safety_audit` ADD CONSTRAINT `fk_quality_food_safety_audit_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `food_beverage_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`product_recall` ADD CONSTRAINT `fk_quality_product_recall_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `food_beverage_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= quality --> trade (2 constraint(s)) =========
-- Requires: quality schema, trade schema
ALTER TABLE `food_beverage_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);

-- ========= regulatory --> finance (4 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ADD CONSTRAINT `fk_regulatory_establishment_registration_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ADD CONSTRAINT `fk_regulatory_import_export_permit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= regulatory --> manufacturing (2 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ADD CONSTRAINT `fk_regulatory_facility_inspection_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= regulatory --> procurement (5 constraint(s)) =========
-- Requires: regulatory schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ADD CONSTRAINT `fk_regulatory_facility_inspection_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ADD CONSTRAINT `fk_regulatory_fsma_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ADD CONSTRAINT `fk_regulatory_gfsi_certification_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= regulatory --> product (1 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= sales --> customer (20 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_account_hierarchy_id` FOREIGN KEY (`account_hierarchy_id`) REFERENCES `food_beverage_ecm`.`customer`.`account_hierarchy`(`account_hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_account_hierarchy_id` FOREIGN KEY (`account_hierarchy_id`) REFERENCES `food_beverage_ecm`.`customer`.`account_hierarchy`(`account_hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);

-- ========= sales --> distribution (4 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);

-- ========= sales --> finance (23 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sales --> inventory (1 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= sales --> manufacturing (1 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= sales --> marketing (10 constraint(s)) =========
-- Requires: sales schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`store` ADD CONSTRAINT `fk_sales_store_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);

-- ========= sales --> procurement (1 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= sales --> product (7 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);

-- ========= sales --> quality (1 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= sales --> regulatory (7 constraint(s)) =========
-- Requires: sales schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);

-- ========= sales --> trade (9 constraint(s)) =========
-- Requires: sales schema, trade schema
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `food_beverage_ecm`.`trade`.`fund`(`fund_id`);
ALTER TABLE `food_beverage_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);

-- ========= supply --> customer (9 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_edi_trading_partner_id` FOREIGN KEY (`edi_trading_partner_id`) REFERENCES `food_beverage_ecm`.`customer`.`edi_trading_partner`(`edi_trading_partner_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);

-- ========= supply --> distribution (15 constraint(s)) =========
-- Requires: supply schema, distribution schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`lane` ADD CONSTRAINT `fk_supply_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`lane` ADD CONSTRAINT `fk_supply_lane_lane_carrier_id` FOREIGN KEY (`lane_carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);

-- ========= supply --> finance (35 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `food_beverage_ecm`.`finance`.`forecast`(`forecast_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_finance_standard_cost_id` FOREIGN KEY (`finance_standard_cost_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_standard_cost`(`finance_standard_cost_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_finance_standard_cost_id` FOREIGN KEY (`finance_standard_cost_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_standard_cost`(`finance_standard_cost_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `food_beverage_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_finance_standard_cost_id` FOREIGN KEY (`finance_standard_cost_id`) REFERENCES `food_beverage_ecm`.`finance`.`finance_standard_cost`(`finance_standard_cost_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `food_beverage_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `food_beverage_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= supply --> ingredient (6 constraint(s)) =========
-- Requires: supply schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_id` FOREIGN KEY (`cost_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`cost`(`cost_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);

-- ========= supply --> inventory (10 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= supply --> manufacturing (8 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= supply --> marketing (15 constraint(s)) =========
-- Requires: supply schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_syndicated_market_data_id` FOREIGN KEY (`syndicated_market_data_id`) REFERENCES `food_beverage_ecm`.`marketing`.`syndicated_market_data`(`syndicated_market_data_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= supply --> procurement (17 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `food_beverage_ecm`.`procurement`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `food_beverage_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= supply --> product (14 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_product_standard_cost_id` FOREIGN KEY (`product_standard_cost_id`) REFERENCES `food_beverage_ecm`.`product`.`product_standard_cost`(`product_standard_cost_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_shelf_life_spec_id` FOREIGN KEY (`shelf_life_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`shelf_life_spec`(`shelf_life_spec_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= supply --> quality (4 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `food_beverage_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `food_beverage_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_receipt` ADD CONSTRAINT `fk_supply_inbound_receipt_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `food_beverage_ecm`.`quality`.`specification`(`specification_id`);

-- ========= supply --> regulatory (9 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`lane` ADD CONSTRAINT `fk_supply_lane_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);

-- ========= supply --> sales (11 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `food_beverage_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_order_id` FOREIGN KEY (`order_id`) REFERENCES `food_beverage_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_store_id` FOREIGN KEY (`store_id`) REFERENCES `food_beverage_ecm`.`sales`.`store`(`store_id`);

-- ========= supply --> trade (6 constraint(s)) =========
-- Requires: supply schema, trade schema
ALTER TABLE `food_beverage_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`safety_stock_policy` ADD CONSTRAINT `fk_supply_safety_stock_policy_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`capacity_constraint` ADD CONSTRAINT `fk_supply_capacity_constraint_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`supply`.`otif_performance` ADD CONSTRAINT `fk_supply_otif_performance_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);

-- ========= trade --> customer (17 constraint(s)) =========
-- Requires: trade schema, customer schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `food_beverage_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_bill_to_location_id` FOREIGN KEY (`bill_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`bill_to_location`(`bill_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `food_beverage_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_ship_to_location_id` FOREIGN KEY (`ship_to_location_id`) REFERENCES `food_beverage_ecm`.`customer`.`ship_to_location`(`ship_to_location_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `food_beverage_ecm`.`customer`.`segment`(`segment_id`);

-- ========= trade --> finance (29 constraint(s)) =========
-- Requires: trade schema, finance schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `food_beverage_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `food_beverage_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `food_beverage_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `food_beverage_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= trade --> ingredient (1 constraint(s)) =========
-- Requires: trade schema, ingredient schema
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);

-- ========= trade --> inventory (4 constraint(s)) =========
-- Requires: trade schema, inventory schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `food_beverage_ecm`.`inventory`.`reservation`(`reservation_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `food_beverage_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `food_beverage_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);

-- ========= trade --> marketing (9 constraint(s)) =========
-- Requires: trade schema, marketing schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `food_beverage_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_market_id` FOREIGN KEY (`market_id`) REFERENCES `food_beverage_ecm`.`marketing`.`market`(`market_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `food_beverage_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= trade --> procurement (4 constraint(s)) =========
-- Requires: trade schema, procurement schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= trade --> product (10 constraint(s)) =========
-- Requires: trade schema, product schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ADD CONSTRAINT `fk_trade_fund_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);

-- ========= trade --> quality (5 constraint(s)) =========
-- Requires: trade schema, quality schema
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `food_beverage_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `food_beverage_ecm`.`quality`.`product_recall`(`product_recall_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `food_beverage_ecm`.`quality`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_hold_record_id` FOREIGN KEY (`hold_record_id`) REFERENCES `food_beverage_ecm`.`quality`.`hold_record`(`hold_record_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `food_beverage_ecm`.`quality`.`non_conformance`(`non_conformance_id`);

-- ========= trade --> regulatory (5 constraint(s)) =========
-- Requires: trade schema, regulatory schema
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_label_approval_id` FOREIGN KEY (`label_approval_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`label_approval`(`label_approval_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`recall_event`(`recall_event_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ADD CONSTRAINT `fk_trade_retailer_agreement_gfsi_certification_id` FOREIGN KEY (`gfsi_certification_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`gfsi_certification`(`gfsi_certification_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);

-- ========= trade --> sales (2 constraint(s)) =========
-- Requires: trade schema, sales schema
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `food_beverage_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `food_beverage_ecm`.`sales`.`contract`(`contract_id`);

