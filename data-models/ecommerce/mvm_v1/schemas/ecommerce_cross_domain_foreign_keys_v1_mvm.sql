-- Cross-Domain Foreign Keys for Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:27
-- Total cross-domain FK constraints: 752
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, finance, fulfillment, inventory, logistics, marketing, marketplace, order, payment, pricing, procurement, product, seller, service

-- ========= customer --> logistics (1 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ADD CONSTRAINT `fk_customer_customer_address_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);

-- ========= customer --> marketing (4 constraint(s)) =========
-- Requires: customer schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= customer --> marketplace (3 constraint(s)) =========
-- Requires: customer schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ADD CONSTRAINT `fk_customer_wishlist_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ADD CONSTRAINT `fk_customer_wishlist_item_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);

-- ========= customer --> payment (2 constraint(s)) =========
-- Requires: customer schema, payment schema
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_wallet_id` FOREIGN KEY (`wallet_id`) REFERENCES `ecommerce_ecm`.`payment`.`wallet`(`wallet_id`);

-- ========= customer --> pricing (6 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_profile` ADD CONSTRAINT `fk_customer_customer_profile_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`customer_address` ADD CONSTRAINT `fk_customer_customer_address_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);

-- ========= customer --> product (11 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ADD CONSTRAINT `fk_customer_wishlist_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist` ADD CONSTRAINT `fk_customer_wishlist_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ADD CONSTRAINT `fk_customer_wishlist_item_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ADD CONSTRAINT `fk_customer_wishlist_item_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`wishlist_item` ADD CONSTRAINT `fk_customer_wishlist_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= customer --> seller (2 constraint(s)) =========
-- Requires: customer schema, seller schema
ALTER TABLE `ecommerce_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`customer`.`consent_event` ADD CONSTRAINT `fk_customer_consent_event_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= customer --> service (1 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `ecommerce_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= finance --> customer (3 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= finance --> order (6 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);

-- ========= finance --> payment (5 constraint(s)) =========
-- Requires: finance schema, payment schema
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);

-- ========= finance --> procurement (6 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);

-- ========= finance --> seller (3 constraint(s)) =========
-- Requires: finance schema, seller schema
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ecommerce_ecm`.`seller`.`agreement`(`agreement_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `ecommerce_ecm`.`seller`.`commission`(`commission_id`);
ALTER TABLE `ecommerce_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= finance --> service (1 constraint(s)) =========
-- Requires: finance schema, service schema
ALTER TABLE `ecommerce_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= fulfillment --> customer (8 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);

-- ========= fulfillment --> finance (8 constraint(s)) =========
-- Requires: fulfillment schema, finance schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `ecommerce_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);

-- ========= fulfillment --> inventory (8 constraint(s)) =========
-- Requires: fulfillment schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ADD CONSTRAINT `fk_fulfillment_bin_location_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`bin_location` ADD CONSTRAINT `fk_fulfillment_bin_location_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= fulfillment --> logistics (13 constraint(s)) =========
-- Requires: fulfillment schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_carrier_rate_card_id` FOREIGN KEY (`carrier_rate_card_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_rate_card`(`carrier_rate_card_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_carrier_rate_card_id` FOREIGN KEY (`carrier_rate_card_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_rate_card`(`carrier_rate_card_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);

-- ========= fulfillment --> marketing (1 constraint(s)) =========
-- Requires: fulfillment schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= fulfillment --> marketplace (2 constraint(s)) =========
-- Requires: fulfillment schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_listing_offer_id` FOREIGN KEY (`listing_offer_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_offer`(`listing_offer_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);

-- ========= fulfillment --> order (8 constraint(s)) =========
-- Requires: fulfillment schema, order schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`packing_slip` ADD CONSTRAINT `fk_fulfillment_packing_slip_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipping_label` ADD CONSTRAINT `fk_fulfillment_shipping_label_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`shipment_event` ADD CONSTRAINT `fk_fulfillment_shipment_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_delivery_confirmation_id` FOREIGN KEY (`delivery_confirmation_id`) REFERENCES `ecommerce_ecm`.`order`.`delivery_confirmation`(`delivery_confirmation_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`proof_of_delivery` ADD CONSTRAINT `fk_fulfillment_proof_of_delivery_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= fulfillment --> payment (1 constraint(s)) =========
-- Requires: fulfillment schema, payment schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= fulfillment --> pricing (6 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_override`(`price_override_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment` ADD CONSTRAINT `fk_fulfillment_fulfillment_shipment_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= fulfillment --> procurement (4 constraint(s)) =========
-- Requires: fulfillment schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `ecommerce_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);

-- ========= fulfillment --> product (6 constraint(s)) =========
-- Requires: fulfillment schema, product schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_product_listing_id` FOREIGN KEY (`product_listing_id`) REFERENCES `ecommerce_ecm`.`product`.`product_listing`(`product_listing_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`order_line` ADD CONSTRAINT `fk_fulfillment_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);

-- ========= fulfillment --> service (1 constraint(s)) =========
-- Requires: fulfillment schema, service schema
ALTER TABLE `ecommerce_ecm`.`fulfillment`.`center` ADD CONSTRAINT `fk_fulfillment_center_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= inventory --> finance (11 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ADD CONSTRAINT `fk_inventory_warehouse_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ADD CONSTRAINT `fk_inventory_warehouse_node_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= inventory --> fulfillment (5 constraint(s)) =========
-- Requires: inventory schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`sla`(`sla_id`);

-- ========= inventory --> logistics (7 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carrier_rate_card_id` FOREIGN KEY (`carrier_rate_card_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_rate_card`(`carrier_rate_card_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ADD CONSTRAINT `fk_inventory_warehouse_node_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);

-- ========= inventory --> marketing (2 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= inventory --> order (2 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);

-- ========= inventory --> payment (2 constraint(s)) =========
-- Requires: inventory schema, payment schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_payment_refund_id` FOREIGN KEY (`payment_refund_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_refund`(`payment_refund_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_payment_refund_id` FOREIGN KEY (`payment_refund_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_refund`(`payment_refund_id`);

-- ========= inventory --> procurement (5 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= inventory --> product (7 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> seller (6 constraint(s)) =========
-- Requires: inventory schema, seller schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= inventory --> service (3 constraint(s)) =========
-- Requires: inventory schema, service schema
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_rma_line_id` FOREIGN KEY (`rma_line_id`) REFERENCES `ecommerce_ecm`.`service`.`rma_line`(`rma_line_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);

-- ========= logistics --> customer (1 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);

-- ========= logistics --> finance (10 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_service` ADD CONSTRAINT `fk_logistics_carrier_service_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ADD CONSTRAINT `fk_logistics_delivery_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= logistics --> fulfillment (2 constraint(s)) =========
-- Requires: logistics schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);

-- ========= logistics --> marketing (1 constraint(s)) =========
-- Requires: logistics schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= logistics --> order (1 constraint(s)) =========
-- Requires: logistics schema, order schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= logistics --> pricing (1 constraint(s)) =========
-- Requires: logistics schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= logistics --> procurement (1 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);

-- ========= logistics --> product (2 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_package` ADD CONSTRAINT `fk_logistics_shipment_package_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= logistics --> seller (5 constraint(s)) =========
-- Requires: logistics schema, seller schema
ALTER TABLE `ecommerce_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_rate_card` ADD CONSTRAINT `fk_logistics_carrier_rate_card_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`delivery_zone` ADD CONSTRAINT `fk_logistics_delivery_zone_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ecommerce_ecm`.`seller`.`agreement`(`agreement_id`);
ALTER TABLE `ecommerce_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= marketing --> customer (4 constraint(s)) =========
-- Requires: marketing schema, customer schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_referral_referee_customer_profile_id` FOREIGN KEY (`referral_referee_customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= marketing --> finance (8 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= marketing --> fulfillment (3 constraint(s)) =========
-- Requires: marketing schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= marketing --> logistics (4 constraint(s)) =========
-- Requires: marketing schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= marketing --> marketplace (4 constraint(s)) =========
-- Requires: marketing schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_performance` ADD CONSTRAINT `fk_marketing_campaign_performance_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);

-- ========= marketing --> order (3 constraint(s)) =========
-- Requires: marketing schema, order schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`referral` ADD CONSTRAINT `fk_marketing_referral_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= marketing --> procurement (4 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);

-- ========= marketing --> product (10 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`email_event` ADD CONSTRAINT `fk_marketing_email_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`ad_group` ADD CONSTRAINT `fk_marketing_ad_group_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= marketing --> seller (4 constraint(s)) =========
-- Requires: marketing schema, seller schema
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketing`.`campaign_budget` ADD CONSTRAINT `fk_marketing_campaign_budget_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= marketplace --> customer (1 constraint(s)) =========
-- Requires: marketplace schema, customer schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);

-- ========= marketplace --> finance (19 constraint(s)) =========
-- Requires: marketplace schema, finance schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `ecommerce_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ADD CONSTRAINT `fk_marketplace_marketplace_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ADD CONSTRAINT `fk_marketplace_marketplace_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace` ADD CONSTRAINT `fk_marketplace_marketplace_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= marketplace --> fulfillment (3 constraint(s)) =========
-- Requires: marketplace schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= marketplace --> inventory (5 constraint(s)) =========
-- Requires: marketplace schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= marketplace --> logistics (8 constraint(s)) =========
-- Requires: marketplace schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);

-- ========= marketplace --> marketing (4 constraint(s)) =========
-- Requires: marketplace schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= marketplace --> order (3 constraint(s)) =========
-- Requires: marketplace schema, order schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= marketplace --> payment (3 constraint(s)) =========
-- Requires: marketplace schema, payment schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);

-- ========= marketplace --> pricing (7 constraint(s)) =========
-- Requires: marketplace schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_dynamic_price_rule_id` FOREIGN KEY (`dynamic_price_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`dynamic_price_rule`(`dynamic_price_rule_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);

-- ========= marketplace --> product (13 constraint(s)) =========
-- Requires: marketplace schema, product schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_category` ADD CONSTRAINT `fk_marketplace_listing_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);

-- ========= marketplace --> seller (8 constraint(s)) =========
-- Requires: marketplace schema, seller schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_listing` ADD CONSTRAINT `fk_marketplace_marketplace_listing_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`listing_offer` ADD CONSTRAINT `fk_marketplace_listing_offer_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `ecommerce_ecm`.`seller`.`commission`(`commission_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_transaction` ADD CONSTRAINT `fk_marketplace_marketplace_transaction_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`commission_schedule` ADD CONSTRAINT `fk_marketplace_commission_schedule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `ecommerce_ecm`.`seller`.`tier`(`tier_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`seller_settlement` ADD CONSTRAINT `fk_marketplace_seller_settlement_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`marketplace_promotion` ADD CONSTRAINT `fk_marketplace_marketplace_promotion_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= marketplace --> service (2 constraint(s)) =========
-- Requires: marketplace schema, service schema
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`marketplace`.`dispute` ADD CONSTRAINT `fk_marketplace_dispute_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`support_case`(`support_case_id`);

-- ========= order --> customer (12 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_wishlist_id` FOREIGN KEY (`wishlist_id`) REFERENCES `ecommerce_ecm`.`customer`.`wishlist`(`wishlist_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_address` ADD CONSTRAINT `fk_order_order_address_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);

-- ========= order --> finance (14 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= order --> fulfillment (5 constraint(s)) =========
-- Requires: order schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`delivery_confirmation` ADD CONSTRAINT `fk_order_delivery_confirmation_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= order --> inventory (6 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= order --> logistics (4 constraint(s)) =========
-- Requires: order schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);

-- ========= order --> marketing (9 constraint(s)) =========
-- Requires: order schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= order --> marketplace (3 constraint(s)) =========
-- Requires: order schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);

-- ========= order --> payment (12 constraint(s)) =========
-- Requires: order schema, payment schema
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `ecommerce_ecm`.`payment`.`authorization`(`authorization_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `ecommerce_ecm`.`payment`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_token_id` FOREIGN KEY (`token_id`) REFERENCES `ecommerce_ecm`.`payment`.`token`(`token_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_payment_refund_id` FOREIGN KEY (`payment_refund_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_refund`(`payment_refund_id`);

-- ========= order --> pricing (9 constraint(s)) =========
-- Requires: order schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart` ADD CONSTRAINT `fk_order_cart_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_dynamic_price_rule_id` FOREIGN KEY (`dynamic_price_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`dynamic_price_rule`(`dynamic_price_rule_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_markdown_schedule_id` FOREIGN KEY (`markdown_schedule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`markdown_schedule`(`markdown_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_promotion_rule_id` FOREIGN KEY (`promotion_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotion_rule`(`promotion_rule_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);

-- ========= order --> procurement (4 constraint(s)) =========
-- Requires: order schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `ecommerce_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_product_listing_id` FOREIGN KEY (`product_listing_id`) REFERENCES `ecommerce_ecm`.`product`.`product_listing`(`product_listing_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= order --> seller (9 constraint(s)) =========
-- Requires: order schema, seller schema
ALTER TABLE `ecommerce_ecm`.`order`.`cart_item` ADD CONSTRAINT `fk_order_cart_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `ecommerce_ecm`.`seller`.`commission`(`commission_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_gmv_settlement_id` FOREIGN KEY (`gmv_settlement_id`) REFERENCES `ecommerce_ecm`.`seller`.`gmv_settlement`(`gmv_settlement_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`order_promotion` ADD CONSTRAINT `fk_order_order_promotion_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`fulfillment_allocation` ADD CONSTRAINT `fk_order_fulfillment_allocation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= order --> service (2 constraint(s)) =========
-- Requires: order schema, service schema
ALTER TABLE `ecommerce_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`support_case`(`support_case_id`);
ALTER TABLE `ecommerce_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);

-- ========= payment --> customer (7 constraint(s)) =========
-- Requires: payment schema, customer schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ADD CONSTRAINT `fk_payment_wallet_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);

-- ========= payment --> finance (23 constraint(s)) =========
-- Requires: payment schema, finance schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ADD CONSTRAINT `fk_payment_settlement_finance_bank_account_id` FOREIGN KEY (`finance_bank_account_id`) REFERENCES `ecommerce_ecm`.`finance`.`finance_bank_account`(`finance_bank_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ADD CONSTRAINT `fk_payment_settlement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ADD CONSTRAINT `fk_payment_settlement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ADD CONSTRAINT `fk_payment_merchant_account_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ADD CONSTRAINT `fk_payment_merchant_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_finance_bank_account_id` FOREIGN KEY (`finance_bank_account_id`) REFERENCES `ecommerce_ecm`.`finance`.`finance_bank_account`(`finance_bank_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ADD CONSTRAINT `fk_payment_wallet_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ADD CONSTRAINT `fk_payment_wallet_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= payment --> fulfillment (5 constraint(s)) =========
-- Requires: payment schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_proof_of_delivery_id` FOREIGN KEY (`proof_of_delivery_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`proof_of_delivery`(`proof_of_delivery_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_proof_of_delivery_id` FOREIGN KEY (`proof_of_delivery_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`proof_of_delivery`(`proof_of_delivery_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);

-- ========= payment --> logistics (1 constraint(s)) =========
-- Requires: payment schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= payment --> marketing (4 constraint(s)) =========
-- Requires: payment schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= payment --> marketplace (5 constraint(s)) =========
-- Requires: payment schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`dispute`(`dispute_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ADD CONSTRAINT `fk_payment_merchant_account_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);

-- ========= payment --> order (3 constraint(s)) =========
-- Requires: payment schema, order schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= payment --> pricing (5 constraint(s)) =========
-- Requires: payment schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_coupon_redemption_id` FOREIGN KEY (`coupon_redemption_id`) REFERENCES `ecommerce_ecm`.`pricing`.`coupon_redemption`(`coupon_redemption_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_promotion_rule_id` FOREIGN KEY (`promotion_rule_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotion_rule`(`promotion_rule_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `ecommerce_ecm`.`pricing`.`coupon`(`coupon_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);

-- ========= payment --> product (2 constraint(s)) =========
-- Requires: payment schema, product schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= payment --> seller (4 constraint(s)) =========
-- Requires: payment schema, seller schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= payment --> service (5 constraint(s)) =========
-- Requires: payment schema, service schema
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_service_refund_id` FOREIGN KEY (`service_refund_id`) REFERENCES `ecommerce_ecm`.`service`.`service_refund`(`service_refund_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`support_case`(`support_case_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`support_case`(`support_case_id`);

-- ========= pricing --> customer (8 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);

-- ========= pricing --> finance (14 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= pricing --> inventory (4 constraint(s)) =========
-- Requires: pricing schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= pricing --> logistics (1 constraint(s)) =========
-- Requires: pricing schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);

-- ========= pricing --> marketing (9 constraint(s)) =========
-- Requires: pricing schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `ecommerce_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= pricing --> marketplace (10 constraint(s)) =========
-- Requires: pricing schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon` ADD CONSTRAINT `fk_pricing_coupon_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);

-- ========= pricing --> order (3 constraint(s)) =========
-- Requires: pricing schema, order schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);

-- ========= pricing --> procurement (3 constraint(s)) =========
-- Requires: pricing schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_supplier_price_list_id` FOREIGN KEY (`supplier_price_list_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_price_list`(`supplier_price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_supplier_price_list_id` FOREIGN KEY (`supplier_price_list_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_price_list`(`supplier_price_list_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= pricing --> product (12 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotion_rule` ADD CONSTRAINT `fk_pricing_promotion_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`coupon_redemption` ADD CONSTRAINT `fk_pricing_coupon_redemption_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_history` ADD CONSTRAINT `fk_pricing_price_history_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);

-- ========= pricing --> seller (4 constraint(s)) =========
-- Requires: pricing schema, seller schema
ALTER TABLE `ecommerce_ecm`.`pricing`.`price_list_item` ADD CONSTRAINT `fk_pricing_price_list_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`dynamic_price_rule` ADD CONSTRAINT `fk_pricing_dynamic_price_rule_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`markdown_schedule` ADD CONSTRAINT `fk_pricing_markdown_schedule_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`pricing`.`promotional_campaign` ADD CONSTRAINT `fk_pricing_promotional_campaign_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= procurement --> customer (6 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);

-- ========= procurement --> finance (11 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= procurement --> inventory (5 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= procurement --> logistics (1 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= procurement --> marketing (1 constraint(s)) =========
-- Requires: procurement schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= procurement --> marketplace (4 constraint(s)) =========
-- Requires: procurement schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);

-- ========= procurement --> payment (1 constraint(s)) =========
-- Requires: procurement schema, payment schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= procurement --> pricing (3 constraint(s)) =========
-- Requires: procurement schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);

-- ========= procurement --> product (7 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);

-- ========= procurement --> seller (6 constraint(s)) =========
-- Requires: procurement schema, seller schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`procurement`.`supplier_price_list` ADD CONSTRAINT `fk_procurement_supplier_price_list_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= procurement --> service (1 constraint(s)) =========
-- Requires: procurement schema, service schema
ALTER TABLE `ecommerce_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= product --> finance (15 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= product --> logistics (2 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_delivery_zone_id` FOREIGN KEY (`delivery_zone_id`) REFERENCES `ecommerce_ecm`.`logistics`.`delivery_zone`(`delivery_zone_id`);

-- ========= product --> marketing (1 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= product --> procurement (2 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> seller (8 constraint(s)) =========
-- Requires: product schema, seller schema
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ADD CONSTRAINT `fk_product_relation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ecommerce_ecm`.`seller`.`agreement`(`agreement_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `ecommerce_ecm`.`seller`.`commission`(`commission_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

-- ========= seller --> customer (1 constraint(s)) =========
-- Requires: seller schema, customer schema
ALTER TABLE `ecommerce_ecm`.`seller`.`onboarding` ADD CONSTRAINT `fk_seller_onboarding_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);

-- ========= seller --> finance (9 constraint(s)) =========
-- Requires: seller schema, finance schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`agreement` ADD CONSTRAINT `fk_seller_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`commission` ADD CONSTRAINT `fk_seller_commission_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`gmv_settlement` ADD CONSTRAINT `fk_seller_gmv_settlement_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`gmv_settlement` ADD CONSTRAINT `fk_seller_gmv_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`violation` ADD CONSTRAINT `fk_seller_violation_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_bank_account` ADD CONSTRAINT `fk_seller_seller_bank_account_finance_bank_account_id` FOREIGN KEY (`finance_bank_account_id`) REFERENCES `ecommerce_ecm`.`finance`.`finance_bank_account`(`finance_bank_account_id`);

-- ========= seller --> marketplace (8 constraint(s)) =========
-- Requires: seller schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`seller`.`onboarding` ADD CONSTRAINT `fk_seller_onboarding_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`agreement` ADD CONSTRAINT `fk_seller_agreement_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`commission` ADD CONSTRAINT `fk_seller_commission_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`scorecard` ADD CONSTRAINT `fk_seller_scorecard_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`gmv_settlement` ADD CONSTRAINT `fk_seller_gmv_settlement_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`gmv_settlement` ADD CONSTRAINT `fk_seller_gmv_settlement_seller_settlement_id` FOREIGN KEY (`seller_settlement_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`seller_settlement`(`seller_settlement_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`rating` ADD CONSTRAINT `fk_seller_rating_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`violation` ADD CONSTRAINT `fk_seller_violation_marketplace_id` FOREIGN KEY (`marketplace_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace`(`marketplace_id`);

-- ========= seller --> payment (2 constraint(s)) =========
-- Requires: seller schema, payment schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`gmv_settlement` ADD CONSTRAINT `fk_seller_gmv_settlement_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);

-- ========= seller --> pricing (4 constraint(s)) =========
-- Requires: seller schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`agreement` ADD CONSTRAINT `fk_seller_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`gmv_settlement` ADD CONSTRAINT `fk_seller_gmv_settlement_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`tier` ADD CONSTRAINT `fk_seller_tier_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= seller --> procurement (2 constraint(s)) =========
-- Requires: seller schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`seller`.`seller_profile` ADD CONSTRAINT `fk_seller_seller_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`onboarding` ADD CONSTRAINT `fk_seller_onboarding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= seller --> service (5 constraint(s)) =========
-- Requires: seller schema, service schema
ALTER TABLE `ecommerce_ecm`.`seller`.`onboarding` ADD CONSTRAINT `fk_seller_onboarding_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`agreement` ADD CONSTRAINT `fk_seller_agreement_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `ecommerce_ecm`.`service`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`violation` ADD CONSTRAINT `fk_seller_violation_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`violation` ADD CONSTRAINT `fk_seller_violation_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`support_case`(`support_case_id`);
ALTER TABLE `ecommerce_ecm`.`seller`.`tier` ADD CONSTRAINT `fk_seller_tier_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);

-- ========= service --> customer (18 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_account_id` FOREIGN KEY (`account_id`) REFERENCES `ecommerce_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ADD CONSTRAINT `fk_service_sla_policy_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `ecommerce_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_customer_profile_id` FOREIGN KEY (`customer_profile_id`) REFERENCES `ecommerce_ecm`.`customer`.`customer_profile`(`customer_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `ecommerce_ecm`.`customer`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `ecommerce_ecm`.`customer`.`segment`(`segment_id`);

-- ========= service --> finance (16 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `ecommerce_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `ecommerce_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ecommerce_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `ecommerce_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_tax_record_id` FOREIGN KEY (`tax_record_id`) REFERENCES `ecommerce_ecm`.`finance`.`tax_record`(`tax_record_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`team` ADD CONSTRAINT `fk_service_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`team` ADD CONSTRAINT `fk_service_team_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ADD CONSTRAINT `fk_service_sla_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ecommerce_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= service --> fulfillment (8 constraint(s)) =========
-- Requires: service schema, fulfillment schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_center_id` FOREIGN KEY (`center_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`center`(`center_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_proof_of_delivery_id` FOREIGN KEY (`proof_of_delivery_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`proof_of_delivery`(`proof_of_delivery_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`order_line`(`order_line_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_fulfillment_shipment_id` FOREIGN KEY (`fulfillment_shipment_id`) REFERENCES `ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`(`fulfillment_shipment_id`);

-- ========= service --> inventory (3 constraint(s)) =========
-- Requires: service schema, inventory schema
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= service --> logistics (6 constraint(s)) =========
-- Requires: service schema, logistics schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `ecommerce_ecm`.`logistics`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `ecommerce_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= service --> marketing (7 constraint(s)) =========
-- Requires: service schema, marketing schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ADD CONSTRAINT `fk_service_sla_policy_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `ecommerce_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ecommerce_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= service --> marketplace (9 constraint(s)) =========
-- Requires: service schema, marketplace schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_marketplace_promotion_id` FOREIGN KEY (`marketplace_promotion_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_promotion`(`marketplace_promotion_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_seller_settlement_id` FOREIGN KEY (`seller_settlement_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`seller_settlement`(`seller_settlement_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`dispute`(`dispute_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_marketplace_transaction_id` FOREIGN KEY (`marketplace_transaction_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`marketplace_transaction`(`marketplace_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_listing_category_id` FOREIGN KEY (`listing_category_id`) REFERENCES `ecommerce_ecm`.`marketplace`.`listing_category`(`listing_category_id`);

-- ========= service --> order (9 constraint(s)) =========
-- Requires: service schema, order schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_delivery_confirmation_id` FOREIGN KEY (`delivery_confirmation_id`) REFERENCES `ecommerce_ecm`.`order`.`delivery_confirmation`(`delivery_confirmation_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_line_id` FOREIGN KEY (`line_id`) REFERENCES `ecommerce_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_header_id` FOREIGN KEY (`header_id`) REFERENCES `ecommerce_ecm`.`order`.`header`(`header_id`);

-- ========= service --> payment (2 constraint(s)) =========
-- Requires: service schema, payment schema
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);

-- ========= service --> pricing (9 constraint(s)) =========
-- Requires: service schema, pricing schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_coupon_redemption_id` FOREIGN KEY (`coupon_redemption_id`) REFERENCES `ecommerce_ecm`.`pricing`.`coupon_redemption`(`coupon_redemption_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_override`(`price_override_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_promotional_campaign_id` FOREIGN KEY (`promotional_campaign_id`) REFERENCES `ecommerce_ecm`.`pricing`.`promotional_campaign`(`promotional_campaign_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_coupon_redemption_id` FOREIGN KEY (`coupon_redemption_id`) REFERENCES `ecommerce_ecm`.`pricing`.`coupon_redemption`(`coupon_redemption_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `ecommerce_ecm`.`pricing`.`price_override`(`price_override_id`);

-- ========= service --> procurement (5 constraint(s)) =========
-- Requires: service schema, procurement schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ecommerce_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ecommerce_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `ecommerce_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `ecommerce_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);

-- ========= service --> product (11 constraint(s)) =========
-- Requires: service schema, product schema
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_product_listing_id` FOREIGN KEY (`product_listing_id`) REFERENCES `ecommerce_ecm`.`product`.`product_listing`(`product_listing_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`support_case` ADD CONSTRAINT `fk_service_support_case_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);

-- ========= service --> seller (3 constraint(s)) =========
-- Requires: service schema, seller schema
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ADD CONSTRAINT `fk_service_rma_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_seller_profile_id` FOREIGN KEY (`seller_profile_id`) REFERENCES `ecommerce_ecm`.`seller`.`seller_profile`(`seller_profile_id`);

