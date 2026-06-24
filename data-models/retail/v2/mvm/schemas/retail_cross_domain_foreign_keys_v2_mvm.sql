-- Cross-Domain Foreign Keys for Business: Retail | Version: v2_mvm
-- Generated on: 2026-06-24 00:49:14
-- Total cross-domain FK constraints: 571
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, ecommerce, fulfillment, inventory, order, pricing, product, promotion, returns, store, supplier, supplychain

-- ========= customer --> pricing (4 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ADD CONSTRAINT `fk_customer_corporate_account_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`membership` ADD CONSTRAINT `fk_customer_membership_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);

-- ========= customer --> product (1 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= customer --> promotion (1 constraint(s)) =========
-- Requires: customer schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= customer --> returns (1 constraint(s)) =========
-- Requires: customer schema, returns schema
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_retail_v1`.`returns`.`rma`(`rma_id`);

-- ========= customer --> store (7 constraint(s)) =========
-- Requires: customer schema, store schema
ALTER TABLE `vibe_retail_v1`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_retail_v1`.`store`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`corporate_account` ADD CONSTRAINT `fk_customer_corporate_account_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= ecommerce --> customer (11 constraint(s)) =========
-- Requires: ecommerce schema, customer schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_retail_v1`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`promotion_banner` ADD CONSTRAINT `fk_ecommerce_promotion_banner_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_retail_v1`.`customer`.`segment`(`segment_id`);

-- ========= ecommerce --> fulfillment (2 constraint(s)) =========
-- Requires: ecommerce schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= ecommerce --> inventory (2 constraint(s)) =========
-- Requires: ecommerce schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= ecommerce --> order (5 constraint(s)) =========
-- Requires: ecommerce schema, order schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);

-- ========= ecommerce --> pricing (9 constraint(s)) =========
-- Requires: ecommerce schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);

-- ========= ecommerce --> product (7 constraint(s)) =========
-- Requires: ecommerce schema, product schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_retail_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_retail_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`promotion_banner` ADD CONSTRAINT `fk_ecommerce_promotion_banner_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);

-- ========= ecommerce --> promotion (13 constraint(s)) =========
-- Requires: ecommerce schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `vibe_retail_v1`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`promotion_banner` ADD CONSTRAINT `fk_ecommerce_promotion_banner_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`promotion_banner` ADD CONSTRAINT `fk_ecommerce_promotion_banner_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= ecommerce --> returns (2 constraint(s)) =========
-- Requires: ecommerce schema, returns schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `vibe_retail_v1`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `vibe_retail_v1`.`returns`.`return_policy`(`return_policy_id`);

-- ========= ecommerce --> store (12 constraint(s)) =========
-- Requires: ecommerce schema, store schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_format_id` FOREIGN KEY (`format_id`) REFERENCES `vibe_retail_v1`.`store`.`format`(`format_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_sfs_fulfillment_node_id` FOREIGN KEY (`sfs_fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`store`.`sfs_fulfillment_node`(`sfs_fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_sfs_fulfillment_node_id` FOREIGN KEY (`sfs_fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`store`.`sfs_fulfillment_node`(`sfs_fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= ecommerce --> supplier (4 constraint(s)) =========
-- Requires: ecommerce schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`ecommerce`.`marketplace_listing` ADD CONSTRAINT `fk_ecommerce_marketplace_listing_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= fulfillment --> customer (8 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_order_fulfillment_profile_id` FOREIGN KEY (`order_fulfillment_profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`bopis_appointment` ADD CONSTRAINT `fk_fulfillment_bopis_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);

-- ========= fulfillment --> inventory (3 constraint(s)) =========
-- Requires: fulfillment schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `vibe_retail_v1`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `vibe_retail_v1`.`inventory`.`inventory_node`(`inventory_node_id`);

-- ========= fulfillment --> order (13 constraint(s)) =========
-- Requires: fulfillment schema, order schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_primary_fulfillment_order_header_id` FOREIGN KEY (`primary_fulfillment_order_header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_retail_v1`.`order`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`bopis_appointment` ADD CONSTRAINT `fk_fulfillment_bopis_appointment_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`bopis_appointment` ADD CONSTRAINT `fk_fulfillment_bopis_appointment_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);

-- ========= fulfillment --> pricing (5 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);

-- ========= fulfillment --> product (5 constraint(s)) =========
-- Requires: fulfillment schema, product schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_gtin_registry_id` FOREIGN KEY (`gtin_registry_id`) REFERENCES `vibe_retail_v1`.`product`.`gtin_registry`(`gtin_registry_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_item_variant_id` FOREIGN KEY (`item_variant_id`) REFERENCES `vibe_retail_v1`.`product`.`item_variant`(`item_variant_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= fulfillment --> promotion (1 constraint(s)) =========
-- Requires: fulfillment schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);

-- ========= fulfillment --> store (6 constraint(s)) =========
-- Requires: fulfillment schema, store schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`bopis_appointment` ADD CONSTRAINT `fk_fulfillment_bopis_appointment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= fulfillment --> supplier (7 constraint(s)) =========
-- Requires: fulfillment schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`carrier` ADD CONSTRAINT `fk_fulfillment_carrier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= fulfillment --> supplychain (10 constraint(s)) =========
-- Requires: fulfillment schema, supplychain schema
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`fulfillment`.`drop_ship_order` ADD CONSTRAINT `fk_fulfillment_drop_ship_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> customer (2 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_retail_v1`.`customer`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);

-- ========= inventory --> ecommerce (2 constraint(s)) =========
-- Requires: inventory schema, ecommerce schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`checkout`(`checkout_id`);

-- ========= inventory --> fulfillment (11 constraint(s)) =========
-- Requires: inventory schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_bopis_appointment_id` FOREIGN KEY (`bopis_appointment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`bopis_appointment`(`bopis_appointment_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= inventory --> order (3 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);

-- ========= inventory --> pricing (12 constraint(s)) =========
-- Requires: inventory schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `vibe_retail_v1`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_cost_zone_id` FOREIGN KEY (`cost_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_zone`(`cost_zone_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= inventory --> product (22 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_gtin_registry_id` FOREIGN KEY (`gtin_registry_id`) REFERENCES `vibe_retail_v1`.`product`.`gtin_registry`(`gtin_registry_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);

-- ========= inventory --> promotion (6 constraint(s)) =========
-- Requires: inventory schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);

-- ========= inventory --> store (8 constraint(s)) =========
-- Requires: inventory schema, store schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= inventory --> supplier (13 constraint(s)) =========
-- Requires: inventory schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= inventory --> supplychain (19 constraint(s)) =========
-- Requires: inventory schema, supplychain schema
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `vibe_retail_v1`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);

-- ========= order --> customer (16 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_retail_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_retail_v1`.`customer`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_retail_v1`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`promise` ADD CONSTRAINT `fk_order_promise_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card_transaction` ADD CONSTRAINT `fk_order_gift_card_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_retail_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_retail_v1`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);

-- ========= order --> ecommerce (6 constraint(s)) =========
-- Requires: order schema, ecommerce schema
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_marketplace_listing_id` FOREIGN KEY (`marketplace_listing_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`marketplace_listing`(`marketplace_listing_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_digital_catalog_id` FOREIGN KEY (`digital_catalog_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`digital_catalog`(`digital_catalog_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promotion_banner_id` FOREIGN KEY (`promotion_banner_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`promotion_banner`(`promotion_banner_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card_transaction` ADD CONSTRAINT `fk_order_gift_card_transaction_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= order --> fulfillment (10 constraint(s)) =========
-- Requires: order schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`promise` ADD CONSTRAINT `fk_order_promise_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`promise` ADD CONSTRAINT `fk_order_promise_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`promise` ADD CONSTRAINT `fk_order_promise_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= order --> inventory (1 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `vibe_retail_v1`.`inventory`.`lot`(`lot_id`);

-- ========= order --> pricing (8 constraint(s)) =========
-- Requires: order schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `vibe_retail_v1`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `vibe_retail_v1`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `vibe_retail_v1`.`pricing`.`rule`(`rule_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= order --> promotion (9 constraint(s)) =========
-- Requires: order schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `vibe_retail_v1`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `vibe_retail_v1`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_rebate_id` FOREIGN KEY (`rebate_id`) REFERENCES `vibe_retail_v1`.`promotion`.`rebate`(`rebate_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= order --> store (10 constraint(s)) =========
-- Requires: order schema, store schema
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_retail_v1`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_retail_v1`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`promise` ADD CONSTRAINT `fk_order_promise_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card_transaction` ADD CONSTRAINT `fk_order_gift_card_transaction_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`gift_card_transaction` ADD CONSTRAINT `fk_order_gift_card_transaction_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_retail_v1`.`store`.`pos_terminal`(`pos_terminal_id`);

-- ========= order --> supplier (3 constraint(s)) =========
-- Requires: order schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_vendor_allowance_id` FOREIGN KEY (`vendor_allowance_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_allowance`(`vendor_allowance_id`);

-- ========= order --> supplychain (3 constraint(s)) =========
-- Requires: order schema, supplychain schema
ALTER TABLE `vibe_retail_v1`.`order`.`header` ADD CONSTRAINT `fk_order_header_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`promise` ADD CONSTRAINT `fk_order_promise_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_retail_v1`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);

-- ========= pricing --> inventory (1 constraint(s)) =========
-- Requires: pricing schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= pricing --> product (5 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `vibe_retail_v1`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= pricing --> promotion (17 constraint(s)) =========
-- Requires: pricing schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= pricing --> store (5 constraint(s)) =========
-- Requires: pricing schema, store schema
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_approval` ADD CONSTRAINT `fk_pricing_price_approval_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);

-- ========= pricing --> supplier (8 constraint(s)) =========
-- Requires: pricing schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_vendor_allowance_id` FOREIGN KEY (`vendor_allowance_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_allowance`(`vendor_allowance_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_vendor_allowance_id` FOREIGN KEY (`vendor_allowance_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_allowance`(`vendor_allowance_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_zone` ADD CONSTRAINT `fk_pricing_cost_zone_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);

-- ========= pricing --> supplychain (3 constraint(s)) =========
-- Requires: pricing schema, supplychain schema
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `vibe_retail_v1`.`pricing`.`cost_zone` ADD CONSTRAINT `fk_pricing_cost_zone_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);

-- ========= product --> ecommerce (1 constraint(s)) =========
-- Requires: product schema, ecommerce schema
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= product --> fulfillment (1 constraint(s)) =========
-- Requires: product schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= product --> pricing (2 constraint(s)) =========
-- Requires: product schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);

-- ========= product --> store (2 constraint(s)) =========
-- Requires: product schema, store schema
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= product --> supplier (4 constraint(s)) =========
-- Requires: product schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);

-- ========= promotion --> customer (1 constraint(s)) =========
-- Requires: promotion schema, customer schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);

-- ========= promotion --> fulfillment (2 constraint(s)) =========
-- Requires: promotion schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= promotion --> order (3 constraint(s)) =========
-- Requires: promotion schema, order schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);

-- ========= promotion --> product (13 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_retail_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_retail_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_retail_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= promotion --> returns (1 constraint(s)) =========
-- Requires: promotion schema, returns schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `vibe_retail_v1`.`returns`.`return_policy`(`return_policy_id`);

-- ========= promotion --> store (11 constraint(s)) =========
-- Requires: promotion schema, store schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_format_id` FOREIGN KEY (`format_id`) REFERENCES `vibe_retail_v1`.`store`.`format`(`format_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_retail_v1`.`store`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_retail_v1`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);

-- ========= promotion --> supplier (9 constraint(s)) =========
-- Requires: promotion schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`circular_ad` ADD CONSTRAINT `fk_promotion_circular_ad_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);

-- ========= returns --> customer (10 constraint(s)) =========
-- Requires: returns schema, customer schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `vibe_retail_v1`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_retail_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_retail_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_retail_v1`.`customer`.`profile`(`profile_id`);

-- ========= returns --> ecommerce (4 constraint(s)) =========
-- Requires: returns schema, ecommerce schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_digital_payment_id` FOREIGN KEY (`digital_payment_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`digital_payment`(`digital_payment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_digital_payment_id` FOREIGN KEY (`digital_payment_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`digital_payment`(`digital_payment_id`);

-- ========= returns --> fulfillment (11 constraint(s)) =========
-- Requires: returns schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= returns --> inventory (13 constraint(s)) =========
-- Requires: returns schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_retail_v1`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `vibe_retail_v1`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_retail_v1`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `vibe_retail_v1`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_retail_v1`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `vibe_retail_v1`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_stock_ledger_id` FOREIGN KEY (`stock_ledger_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_ledger`(`stock_ledger_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `vibe_retail_v1`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_stock_transfer_id` FOREIGN KEY (`stock_transfer_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= returns --> order (13 constraint(s)) =========
-- Requires: returns schema, order schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_retail_v1`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_retail_v1`.`order`.`payment`(`payment_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_header_id` FOREIGN KEY (`header_id`) REFERENCES `vibe_retail_v1`.`order`.`header`(`header_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `vibe_retail_v1`.`order`.`pos_transaction`(`pos_transaction_id`);

-- ========= returns --> pricing (9 constraint(s)) =========
-- Requires: returns schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `vibe_retail_v1`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);

-- ========= returns --> product (8 constraint(s)) =========
-- Requires: returns schema, product schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_retail_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= returns --> promotion (3 constraint(s)) =========
-- Requires: returns schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_promo_redemption_id` FOREIGN KEY (`promo_redemption_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_redemption`(`promo_redemption_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= returns --> store (12 constraint(s)) =========
-- Requires: returns schema, store schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `vibe_retail_v1`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_format_id` FOREIGN KEY (`format_id`) REFERENCES `vibe_retail_v1`.`store`.`format`(`format_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= returns --> supplier (6 constraint(s)) =========
-- Requires: returns schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_disposition_vendor_id` FOREIGN KEY (`disposition_vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= returns --> supplychain (5 constraint(s)) =========
-- Requires: returns schema, supplychain schema
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`outbound_order`(`outbound_order_id`);

-- ========= store --> fulfillment (2 constraint(s)) =========
-- Requires: store schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= store --> pricing (5 constraint(s)) =========
-- Requires: store schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`store`.`location` ADD CONSTRAINT `fk_store_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`department` ADD CONSTRAINT `fk_store_department_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`region` ADD CONSTRAINT `fk_store_region_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= store --> product (1 constraint(s)) =========
-- Requires: store schema, product schema
ALTER TABLE `vibe_retail_v1`.`store`.`department` ADD CONSTRAINT `fk_store_department_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);

-- ========= store --> promotion (1 constraint(s)) =========
-- Requires: store schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_calendar`(`promo_calendar_id`);

-- ========= store --> supplier (3 constraint(s)) =========
-- Requires: store schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ADD CONSTRAINT `fk_store_fixture_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`department` ADD CONSTRAINT `fk_store_department_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);

-- ========= supplier --> inventory (2 constraint(s)) =========
-- Requires: supplier schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_retail_v1`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `vibe_retail_v1`.`inventory`.`inventory_node`(`inventory_node_id`);

-- ========= supplier --> product (3 constraint(s)) =========
-- Requires: supplier schema, product schema
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);

-- ========= supplier --> promotion (5 constraint(s)) =========
-- Requires: supplier schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_circular_ad_id` FOREIGN KEY (`circular_ad_id`) REFERENCES `vibe_retail_v1`.`promotion`.`circular_ad`(`circular_ad_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);

-- ========= supplier --> returns (1 constraint(s)) =========
-- Requires: supplier schema, returns schema
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `vibe_retail_v1`.`returns`.`rma`(`rma_id`);

-- ========= supplier --> store (4 constraint(s)) =========
-- Requires: supplier schema, store schema
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_retail_v1`.`store`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);

-- ========= supplier --> supplychain (7 constraint(s)) =========
-- Requires: supplier schema, supplychain schema
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_retail_v1`.`supplychain`.`purchase_order`(`purchase_order_id`);

-- ========= supplychain --> ecommerce (1 constraint(s)) =========
-- Requires: supplychain schema, ecommerce schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `vibe_retail_v1`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= supplychain --> fulfillment (4 constraint(s)) =========
-- Requires: supplychain schema, fulfillment schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_retail_v1`.`fulfillment`.`carrier`(`carrier_id`);

-- ========= supplychain --> inventory (2 constraint(s)) =========
-- Requires: supplychain schema, inventory schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `vibe_retail_v1`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_retail_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= supplychain --> pricing (5 constraint(s)) =========
-- Requires: supplychain schema, pricing schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_retail_v1`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `vibe_retail_v1`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= supplychain --> product (8 constraint(s)) =========
-- Requires: supplychain schema, product schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);

-- ========= supplychain --> promotion (5 constraint(s)) =========
-- Requires: supplychain schema, promotion schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `vibe_retail_v1`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `vibe_retail_v1`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= supplychain --> store (10 constraint(s)) =========
-- Requires: supplychain schema, store schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`dc_facility` ADD CONSTRAINT `fk_supplychain_dc_facility_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`dc_facility` ADD CONSTRAINT `fk_supplychain_dc_facility_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`outbound_order_line` ADD CONSTRAINT `fk_supplychain_outbound_order_line_source_location_id` FOREIGN KEY (`source_location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);

-- ========= supplychain --> supplier (10 constraint(s)) =========
-- Requires: supplychain schema, supplier schema
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_vendor_address_id` FOREIGN KEY (`vendor_address_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_address`(`vendor_address_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);

