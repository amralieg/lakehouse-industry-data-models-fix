-- Cross-Domain Foreign Keys for Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:45
-- Total cross-domain FK constraints: 1132
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, ecommerce, finance, fulfillment, inventory, loyalty, merchandising, order, pricing, product, promotion, returns, store, supplier, supplychain

-- ========= customer --> ecommerce (2 constraint(s)) =========
-- Requires: customer schema, ecommerce schema
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `retail_ecm`.`ecommerce`.`checkout`(`checkout_id`);

-- ========= customer --> finance (5 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= customer --> fulfillment (2 constraint(s)) =========
-- Requires: customer schema, fulfillment schema
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);

-- ========= customer --> loyalty (5 constraint(s)) =========
-- Requires: customer schema, loyalty schema
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);

-- ========= customer --> merchandising (5 constraint(s)) =========
-- Requires: customer schema, merchandising schema
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);

-- ========= customer --> order (1 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);

-- ========= customer --> pricing (6 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `retail_ecm`.`pricing`.`price_override`(`price_override_id`);
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= customer --> product (8 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_compliance_id` FOREIGN KEY (`compliance_id`) REFERENCES `retail_ecm`.`product`.`compliance`(`compliance_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= customer --> promotion (2 constraint(s)) =========
-- Requires: customer schema, promotion schema
ALTER TABLE `retail_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `retail_ecm`.`promotion`.`coupon`(`coupon_id`);

-- ========= customer --> store (6 constraint(s)) =========
-- Requires: customer schema, store schema
ALTER TABLE `retail_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`customer`.`customer_membership` ADD CONSTRAINT `fk_customer_customer_membership_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= customer --> supplier (3 constraint(s)) =========
-- Requires: customer schema, supplier schema
ALTER TABLE `retail_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= customer --> supplychain (1 constraint(s)) =========
-- Requires: customer schema, supplychain schema
ALTER TABLE `retail_ecm`.`customer`.`service_case` ADD CONSTRAINT `fk_customer_service_case_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_shipment`(`outbound_shipment_id`);

-- ========= ecommerce --> customer (13 constraint(s)) =========
-- Requires: ecommerce schema, customer schema
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= ecommerce --> finance (14 constraint(s)) =========
-- Requires: ecommerce schema, finance schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_tax_posting_id` FOREIGN KEY (`tax_posting_id`) REFERENCES `retail_ecm`.`finance`.`tax_posting`(`tax_posting_id`);

-- ========= ecommerce --> fulfillment (5 constraint(s)) =========
-- Requires: ecommerce schema, fulfillment schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= ecommerce --> inventory (6 constraint(s)) =========
-- Requires: ecommerce schema, inventory schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `retail_ecm`.`inventory`.`reservation`(`reservation_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);

-- ========= ecommerce --> loyalty (5 constraint(s)) =========
-- Requires: ecommerce schema, loyalty schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);

-- ========= ecommerce --> merchandising (7 constraint(s)) =========
-- Requires: ecommerce schema, merchandising schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);

-- ========= ecommerce --> order (4 constraint(s)) =========
-- Requires: ecommerce schema, order schema
ALTER TABLE `retail_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);

-- ========= ecommerce --> pricing (6 constraint(s)) =========
-- Requires: ecommerce schema, pricing schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `retail_ecm`.`pricing`.`price_override`(`price_override_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= ecommerce --> product (5 constraint(s)) =========
-- Requires: ecommerce schema, product schema
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_image_id` FOREIGN KEY (`image_id`) REFERENCES `retail_ecm`.`product`.`image`(`image_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= ecommerce --> promotion (11 constraint(s)) =========
-- Requires: ecommerce schema, promotion schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `retail_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `retail_ecm`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `retail_ecm`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= ecommerce --> returns (3 constraint(s)) =========
-- Requires: ecommerce schema, returns schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `retail_ecm`.`returns`.`refund`(`refund_id`);

-- ========= ecommerce --> store (7 constraint(s)) =========
-- Requires: ecommerce schema, store schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`cart_item` ADD CONSTRAINT `fk_ecommerce_cart_item_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`checkout` ADD CONSTRAINT `fk_ecommerce_checkout_sfs_fulfillment_node_id` FOREIGN KEY (`sfs_fulfillment_node_id`) REFERENCES `retail_ecm`.`store`.`sfs_fulfillment_node`(`sfs_fulfillment_node_id`);

-- ========= ecommerce --> supplier (3 constraint(s)) =========
-- Requires: ecommerce schema, supplier schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= ecommerce --> supplychain (2 constraint(s)) =========
-- Requires: ecommerce schema, supplychain schema
ALTER TABLE `retail_ecm`.`ecommerce`.`storefront` ADD CONSTRAINT `fk_ecommerce_storefront_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`ecommerce`.`digital_catalog` ADD CONSTRAINT `fk_ecommerce_digital_catalog_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);

-- ========= finance --> customer (5 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `retail_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= finance --> fulfillment (2 constraint(s)) =========
-- Requires: finance schema, fulfillment schema
ALTER TABLE `retail_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);

-- ========= finance --> order (7 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `retail_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_pos_transaction_line_id` FOREIGN KEY (`pos_transaction_line_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction_line`(`pos_transaction_line_id`);
ALTER TABLE `retail_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `retail_ecm`.`order`.`subscription`(`subscription_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_pos_transaction_line_id` FOREIGN KEY (`pos_transaction_line_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction_line`(`pos_transaction_line_id`);

-- ========= finance --> store (4 constraint(s)) =========
-- Requires: finance schema, store schema
ALTER TABLE `retail_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= finance --> supplier (3 constraint(s)) =========
-- Requires: finance schema, supplier schema
ALTER TABLE `retail_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= finance --> supplychain (9 constraint(s)) =========
-- Requires: finance schema, supplychain schema
ALTER TABLE `retail_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `retail_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= fulfillment --> customer (7 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `retail_ecm`.`customer`.`service_case`(`service_case_id`);

-- ========= fulfillment --> finance (7 constraint(s)) =========
-- Requires: fulfillment schema, finance schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= fulfillment --> inventory (2 constraint(s)) =========
-- Requires: fulfillment schema, inventory schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= fulfillment --> loyalty (3 constraint(s)) =========
-- Requires: fulfillment schema, loyalty schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= fulfillment --> merchandising (2 constraint(s)) =========
-- Requires: fulfillment schema, merchandising schema
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);

-- ========= fulfillment --> order (6 constraint(s)) =========
-- Requires: fulfillment schema, order schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);

-- ========= fulfillment --> pricing (7 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_cost_zone_id` FOREIGN KEY (`cost_zone_id`) REFERENCES `retail_ecm`.`pricing`.`cost_zone`(`cost_zone_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= fulfillment --> product (3 constraint(s)) =========
-- Requires: fulfillment schema, product schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= fulfillment --> returns (1 constraint(s)) =========
-- Requires: fulfillment schema, returns schema
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);

-- ========= fulfillment --> store (5 constraint(s)) =========
-- Requires: fulfillment schema, store schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);

-- ========= fulfillment --> supplier (2 constraint(s)) =========
-- Requires: fulfillment schema, supplier schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= fulfillment --> supplychain (11 constraint(s)) =========
-- Requires: fulfillment schema, supplychain schema
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_shipment`(`outbound_shipment_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `retail_ecm`.`supplychain`.`wave`(`wave_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_shipment`(`outbound_shipment_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `retail_ecm`.`supplychain`.`wave`(`wave_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `retail_ecm`.`supplychain`.`wave`(`wave_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ADD CONSTRAINT `fk_fulfillment_fulfillment_node_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_warehouse_task_id` FOREIGN KEY (`warehouse_task_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_task`(`warehouse_task_id`);

-- ========= inventory --> customer (3 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `retail_ecm`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= inventory --> ecommerce (2 constraint(s)) =========
-- Requires: inventory schema, ecommerce schema
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `retail_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `retail_ecm`.`ecommerce`.`checkout`(`checkout_id`);

-- ========= inventory --> finance (19 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= inventory --> fulfillment (9 constraint(s)) =========
-- Requires: inventory schema, fulfillment schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);

-- ========= inventory --> loyalty (1 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);

-- ========= inventory --> merchandising (12 constraint(s)) =========
-- Requires: inventory schema, merchandising schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `retail_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_buying_order_id` FOREIGN KEY (`buying_order_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order`(`buying_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);

-- ========= inventory --> order (5 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cancellation_id` FOREIGN KEY (`cancellation_id`) REFERENCES `retail_ecm`.`order`.`cancellation`(`cancellation_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);

-- ========= inventory --> pricing (12 constraint(s)) =========
-- Requires: inventory schema, pricing schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `retail_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `retail_ecm`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_cost_zone_id` FOREIGN KEY (`cost_zone_id`) REFERENCES `retail_ecm`.`pricing`.`cost_zone`(`cost_zone_id`);
ALTER TABLE `retail_ecm`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= inventory --> product (19 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_assortment_id` FOREIGN KEY (`assortment_id`) REFERENCES `retail_ecm`.`product`.`assortment`(`assortment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);

-- ========= inventory --> promotion (6 constraint(s)) =========
-- Requires: inventory schema, promotion schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= inventory --> store (9 constraint(s)) =========
-- Requires: inventory schema, store schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);

-- ========= inventory --> supplier (17 constraint(s)) =========
-- Requires: inventory schema, supplier schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `retail_ecm`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `retail_ecm`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_asn_vendor_id` FOREIGN KEY (`asn_vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `retail_ecm`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= inventory --> supplychain (29 constraint(s)) =========
-- Requires: inventory schema, supplychain schema
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `retail_ecm`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_inventory_transfer_id` FOREIGN KEY (`inventory_transfer_id`) REFERENCES `retail_ecm`.`supplychain`.`inventory_transfer`(`inventory_transfer_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_shipment`(`outbound_shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_ledger` ADD CONSTRAINT `fk_inventory_stock_ledger_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`inventory`.`inventory_node` ADD CONSTRAINT `fk_inventory_inventory_node_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `retail_ecm`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_inbound_appointment_id` FOREIGN KEY (`inbound_appointment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_appointment`(`inbound_appointment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `retail_ecm`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `retail_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);
ALTER TABLE `retail_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_inventory_transfer_id` FOREIGN KEY (`inventory_transfer_id`) REFERENCES `retail_ecm`.`supplychain`.`inventory_transfer`(`inventory_transfer_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_shipment`(`outbound_shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `retail_ecm`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_inbound_appointment_id` FOREIGN KEY (`inbound_appointment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_appointment`(`inbound_appointment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_inbound_appointment_id` FOREIGN KEY (`inbound_appointment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_appointment`(`inbound_appointment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);

-- ========= loyalty --> customer (1 constraint(s)) =========
-- Requires: loyalty schema, customer schema
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ADD CONSTRAINT `fk_loyalty_loyalty_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= loyalty --> ecommerce (6 constraint(s)) =========
-- Requires: loyalty schema, ecommerce schema
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ADD CONSTRAINT `fk_loyalty_loyalty_membership_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `retail_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `retail_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `retail_ecm`.`ecommerce`.`checkout`(`checkout_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= loyalty --> finance (13 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `retail_ecm`.`loyalty`.`program` ADD CONSTRAINT `fk_loyalty_program_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`program` ADD CONSTRAINT `fk_loyalty_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= loyalty --> inventory (1 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= loyalty --> merchandising (6 constraint(s)) =========
-- Requires: loyalty schema, merchandising schema
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);

-- ========= loyalty --> order (4 constraint(s)) =========
-- Requires: loyalty schema, order schema
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);

-- ========= loyalty --> pricing (7 constraint(s)) =========
-- Requires: loyalty schema, pricing schema
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `retail_ecm`.`pricing`.`rule`(`rule_id`);

-- ========= loyalty --> product (12 constraint(s)) =========
-- Requires: loyalty schema, product schema
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= loyalty --> promotion (5 constraint(s)) =========
-- Requires: loyalty schema, promotion schema
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= loyalty --> store (6 constraint(s)) =========
-- Requires: loyalty schema, store schema
ALTER TABLE `retail_ecm`.`loyalty`.`loyalty_membership` ADD CONSTRAINT `fk_loyalty_loyalty_membership_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= loyalty --> supplier (3 constraint(s)) =========
-- Requires: loyalty schema, supplier schema
ALTER TABLE `retail_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= merchandising --> finance (29 constraint(s)) =========
-- Requires: merchandising schema, finance schema
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`category` ADD CONSTRAINT `fk_merchandising_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`category` ADD CONSTRAINT `fk_merchandising_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`category` ADD CONSTRAINT `fk_merchandising_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buyer` ADD CONSTRAINT `fk_merchandising_buyer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`season` ADD CONSTRAINT `fk_merchandising_season_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= merchandising --> fulfillment (2 constraint(s)) =========
-- Requires: merchandising schema, fulfillment schema
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= merchandising --> loyalty (1 constraint(s)) =========
-- Requires: merchandising schema, loyalty schema
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `retail_ecm`.`loyalty`.`member_segment`(`member_segment_id`);

-- ========= merchandising --> pricing (1 constraint(s)) =========
-- Requires: merchandising schema, pricing schema
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= merchandising --> product (8 constraint(s)) =========
-- Requires: merchandising schema, product schema
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`category` ADD CONSTRAINT `fk_merchandising_category_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_item` ADD CONSTRAINT `fk_merchandising_assortment_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= merchandising --> promotion (1 constraint(s)) =========
-- Requires: merchandising schema, promotion schema
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= merchandising --> store (8 constraint(s)) =========
-- Requires: merchandising schema, store schema
ALTER TABLE `retail_ecm`.`merchandising`.`merch_plan` ADD CONSTRAINT `fk_merchandising_merch_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= merchandising --> supplier (4 constraint(s)) =========
-- Requires: merchandising schema, supplier schema
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`assortment_item` ADD CONSTRAINT `fk_merchandising_assortment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`markdown_event` ADD CONSTRAINT `fk_merchandising_markdown_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= merchandising --> supplychain (2 constraint(s)) =========
-- Requires: merchandising schema, supplychain schema
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order` ADD CONSTRAINT `fk_merchandising_buying_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`merchandising`.`buying_order_line` ADD CONSTRAINT `fk_merchandising_buying_order_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);

-- ========= order --> customer (12 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);

-- ========= order --> ecommerce (6 constraint(s)) =========
-- Requires: order schema, ecommerce schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_digital_catalog_id` FOREIGN KEY (`digital_catalog_id`) REFERENCES `retail_ecm`.`ecommerce`.`digital_catalog`(`digital_catalog_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `retail_ecm`.`ecommerce`.`checkout`(`checkout_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_digital_catalog_id` FOREIGN KEY (`digital_catalog_id`) REFERENCES `retail_ecm`.`ecommerce`.`digital_catalog`(`digital_catalog_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= order --> finance (13 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= order --> fulfillment (14 constraint(s)) =========
-- Requires: order schema, fulfillment schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);

-- ========= order --> inventory (2 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_stock_ledger_id` FOREIGN KEY (`stock_ledger_id`) REFERENCES `retail_ecm`.`inventory`.`stock_ledger`(`stock_ledger_id`);

-- ========= order --> loyalty (12 constraint(s)) =========
-- Requires: order schema, loyalty schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `retail_ecm`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_member_offer_id` FOREIGN KEY (`member_offer_id`) REFERENCES `retail_ecm`.`loyalty`.`member_offer`(`member_offer_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `retail_ecm`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_member_offer_id` FOREIGN KEY (`member_offer_id`) REFERENCES `retail_ecm`.`loyalty`.`member_offer`(`member_offer_id`);
ALTER TABLE `retail_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);

-- ========= order --> merchandising (9 constraint(s)) =========
-- Requires: order schema, merchandising schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_buying_order_line_id` FOREIGN KEY (`buying_order_line_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order_line`(`buying_order_line_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);

-- ========= order --> pricing (12 constraint(s)) =========
-- Requires: order schema, pricing schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `retail_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `retail_ecm`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `retail_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `retail_ecm`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `retail_ecm`.`pricing`.`rule`(`rule_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_item_bundle_id` FOREIGN KEY (`item_bundle_id`) REFERENCES `retail_ecm`.`product`.`item_bundle`(`item_bundle_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_item_bundle_id` FOREIGN KEY (`item_bundle_id`) REFERENCES `retail_ecm`.`product`.`item_bundle`(`item_bundle_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= order --> promotion (7 constraint(s)) =========
-- Requires: order schema, promotion schema
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `retail_ecm`.`promotion`.`coupon`(`coupon_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= order --> returns (1 constraint(s)) =========
-- Requires: order schema, returns schema
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);

-- ========= order --> store (12 constraint(s)) =========
-- Requires: order schema, store schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`status_history` ADD CONSTRAINT `fk_order_status_history_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `retail_ecm`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction` ADD CONSTRAINT `fk_order_pos_transaction_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `retail_ecm`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `retail_ecm`.`order`.`cancellation` ADD CONSTRAINT `fk_order_cancellation_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`gift_card` ADD CONSTRAINT `fk_order_gift_card_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`order`.`subscription` ADD CONSTRAINT `fk_order_subscription_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= order --> supplier (4 constraint(s)) =========
-- Requires: order schema, supplier schema
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`order`.`pos_transaction_line` ADD CONSTRAINT `fk_order_pos_transaction_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);

-- ========= order --> supplychain (4 constraint(s)) =========
-- Requires: order schema, supplychain schema
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_shipment`(`outbound_shipment_id`);
ALTER TABLE `retail_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `retail_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);

-- ========= pricing --> customer (1 constraint(s)) =========
-- Requires: pricing schema, customer schema
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= pricing --> finance (15 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `retail_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= pricing --> loyalty (11 constraint(s)) =========
-- Requires: pricing schema, loyalty schema
ALTER TABLE `retail_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `retail_ecm`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `retail_ecm`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);

-- ========= pricing --> merchandising (19 constraint(s)) =========
-- Requires: pricing schema, merchandising schema
ALTER TABLE `retail_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_list` ADD CONSTRAINT `fk_pricing_price_list_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_primary_margin_category_id` FOREIGN KEY (`primary_margin_category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_zone` ADD CONSTRAINT `fk_pricing_cost_zone_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);

-- ========= pricing --> order (1 constraint(s)) =========
-- Requires: pricing schema, order schema
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);

-- ========= pricing --> product (5 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `retail_ecm`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= pricing --> promotion (6 constraint(s)) =========
-- Requires: pricing schema, promotion schema
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= pricing --> returns (2 constraint(s)) =========
-- Requires: pricing schema, returns schema
ALTER TABLE `retail_ecm`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);

-- ========= pricing --> store (7 constraint(s)) =========
-- Requires: pricing schema, store schema
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`pricing`.`margin_target` ADD CONSTRAINT `fk_pricing_margin_target_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `retail_ecm`.`store`.`pos_terminal`(`pos_terminal_id`);

-- ========= pricing --> supplier (10 constraint(s)) =========
-- Requires: pricing schema, supplier schema
ALTER TABLE `retail_ecm`.`pricing`.`sku_price` ADD CONSTRAINT `fk_pricing_sku_price_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`pricing`.`rule` ADD CONSTRAINT `fk_pricing_rule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= pricing --> supplychain (1 constraint(s)) =========
-- Requires: pricing schema, supplychain schema
ALTER TABLE `retail_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `retail_ecm`.`supplychain`.`demand_forecast`(`demand_forecast_id`);

-- ========= product --> ecommerce (2 constraint(s)) =========
-- Requires: product schema, ecommerce schema
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= product --> finance (6 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `retail_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);

-- ========= product --> fulfillment (1 constraint(s)) =========
-- Requires: product schema, fulfillment schema
ALTER TABLE `retail_ecm`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= product --> loyalty (1 constraint(s)) =========
-- Requires: product schema, loyalty schema
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);

-- ========= product --> pricing (3 constraint(s)) =========
-- Requires: product schema, pricing schema
ALTER TABLE `retail_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_margin_target_id` FOREIGN KEY (`margin_target_id`) REFERENCES `retail_ecm`.`pricing`.`margin_target`(`margin_target_id`);
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);

-- ========= product --> promotion (1 constraint(s)) =========
-- Requires: product schema, promotion schema
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= product --> store (4 constraint(s)) =========
-- Requires: product schema, store schema
ALTER TABLE `retail_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`product`.`compliance` ADD CONSTRAINT `fk_product_compliance_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);

-- ========= product --> supplier (6 constraint(s)) =========
-- Requires: product schema, supplier schema
ALTER TABLE `retail_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`product`.`image` ADD CONSTRAINT `fk_product_image_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`product`.`compliance` ADD CONSTRAINT `fk_product_compliance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= promotion --> customer (6 constraint(s)) =========
-- Requires: promotion schema, customer schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= promotion --> ecommerce (4 constraint(s)) =========
-- Requires: promotion schema, ecommerce schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `retail_ecm`.`ecommerce`.`checkout`(`checkout_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= promotion --> finance (31 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);

-- ========= promotion --> fulfillment (3 constraint(s)) =========
-- Requires: promotion schema, fulfillment schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= promotion --> loyalty (5 constraint(s)) =========
-- Requires: promotion schema, loyalty schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `retail_ecm`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);

-- ========= promotion --> merchandising (16 constraint(s)) =========
-- Requires: promotion schema, merchandising schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);

-- ========= promotion --> order (2 constraint(s)) =========
-- Requires: promotion schema, order schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);

-- ========= promotion --> product (15 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `retail_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_budget` ADD CONSTRAINT `fk_promotion_promo_budget_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);

-- ========= promotion --> returns (3 constraint(s)) =========
-- Requires: promotion schema, returns schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);

-- ========= promotion --> store (3 constraint(s)) =========
-- Requires: promotion schema, store schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `retail_ecm`.`store`.`pos_terminal`(`pos_terminal_id`);

-- ========= promotion --> supplier (8 constraint(s)) =========
-- Requires: promotion schema, supplier schema
ALTER TABLE `retail_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`promotion`.`coupon` ADD CONSTRAINT `fk_promotion_coupon_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`promotion`.`rebate` ADD CONSTRAINT `fk_promotion_rebate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`promotion`.`vendor_promo_agreement` ADD CONSTRAINT `fk_promotion_vendor_promo_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`promotion`.`promo_redemption` ADD CONSTRAINT `fk_promotion_promo_redemption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= returns --> customer (11 constraint(s)) =========
-- Requires: returns schema, customer schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `retail_ecm`.`customer`.`service_case`(`service_case_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `retail_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);

-- ========= returns --> ecommerce (4 constraint(s)) =========
-- Requires: returns schema, ecommerce schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= returns --> finance (16 constraint(s)) =========
-- Requires: returns schema, finance schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_tax_posting_id` FOREIGN KEY (`tax_posting_id`) REFERENCES `retail_ecm`.`finance`.`tax_posting`(`tax_posting_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= returns --> fulfillment (13 constraint(s)) =========
-- Requires: returns schema, fulfillment schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);

-- ========= returns --> inventory (15 constraint(s)) =========
-- Requires: returns schema, inventory schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `retail_ecm`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `retail_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `retail_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_stock_ledger_id` FOREIGN KEY (`stock_ledger_id`) REFERENCES `retail_ecm`.`inventory`.`stock_ledger`(`stock_ledger_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_stock_ledger_id` FOREIGN KEY (`stock_ledger_id`) REFERENCES `retail_ecm`.`inventory`.`stock_ledger`(`stock_ledger_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `retail_ecm`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_stock_ledger_id` FOREIGN KEY (`stock_ledger_id`) REFERENCES `retail_ecm`.`inventory`.`stock_ledger`(`stock_ledger_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= returns --> loyalty (11 constraint(s)) =========
-- Requires: returns schema, loyalty schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_points_ledger_id` FOREIGN KEY (`points_ledger_id`) REFERENCES `retail_ecm`.`loyalty`.`points_ledger`(`points_ledger_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `retail_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_loyalty_membership_id` FOREIGN KEY (`loyalty_membership_id`) REFERENCES `retail_ecm`.`loyalty`.`loyalty_membership`(`loyalty_membership_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `retail_ecm`.`loyalty`.`redemption`(`redemption_id`);

-- ========= returns --> merchandising (4 constraint(s)) =========
-- Requires: returns schema, merchandising schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_buying_order_line_id` FOREIGN KEY (`buying_order_line_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order_line`(`buying_order_line_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `retail_ecm`.`merchandising`.`markdown_event`(`markdown_event_id`);

-- ========= returns --> order (15 constraint(s)) =========
-- Requires: returns schema, order schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `retail_ecm`.`order`.`subscription`(`subscription_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_pos_transaction_line_id` FOREIGN KEY (`pos_transaction_line_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction_line`(`pos_transaction_line_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `retail_ecm`.`order`.`payment`(`payment_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);

-- ========= returns --> pricing (9 constraint(s)) =========
-- Requires: returns schema, pricing schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `retail_ecm`.`pricing`.`price_override`(`price_override_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `retail_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_sku_price_id` FOREIGN KEY (`sku_price_id`) REFERENCES `retail_ecm`.`pricing`.`sku_price`(`sku_price_id`);

-- ========= returns --> product (5 constraint(s)) =========
-- Requires: returns schema, product schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= returns --> promotion (7 constraint(s)) =========
-- Requires: returns schema, promotion schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_vendor_promo_agreement_id` FOREIGN KEY (`vendor_promo_agreement_id`) REFERENCES `retail_ecm`.`promotion`.`vendor_promo_agreement`(`vendor_promo_agreement_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_promo_redemption_id` FOREIGN KEY (`promo_redemption_id`) REFERENCES `retail_ecm`.`promotion`.`promo_redemption`(`promo_redemption_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= returns --> store (13 constraint(s)) =========
-- Requires: returns schema, store schema
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `retail_ecm`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma` ADD CONSTRAINT `fk_returns_rma_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_request` ADD CONSTRAINT `fk_returns_return_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`returns`.`refund` ADD CONSTRAINT `fk_returns_refund_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `retail_ecm`.`store`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`returns`.`store_credit` ADD CONSTRAINT `fk_returns_store_credit_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= returns --> supplier (7 constraint(s)) =========
-- Requires: returns schema, supplier schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_rtv_request_id` FOREIGN KEY (`rtv_request_id`) REFERENCES `retail_ecm`.`supplier`.`rtv_request`(`rtv_request_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_disposition_vendor_id` FOREIGN KEY (`disposition_vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_rtv_request_id` FOREIGN KEY (`rtv_request_id`) REFERENCES `retail_ecm`.`supplier`.`rtv_request`(`rtv_request_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_policy` ADD CONSTRAINT `fk_returns_return_policy_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);

-- ========= returns --> supplychain (8 constraint(s)) =========
-- Requires: returns schema, supplychain schema
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`returns`.`rma_line` ADD CONSTRAINT `fk_returns_rma_line_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`returns`.`return_receipt` ADD CONSTRAINT `fk_returns_return_receipt_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`returns`.`disposition` ADD CONSTRAINT `fk_returns_disposition_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`returns`.`exchange_order` ADD CONSTRAINT `fk_returns_exchange_order_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`returns`.`restock_event` ADD CONSTRAINT `fk_returns_restock_event_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);

-- ========= store --> ecommerce (1 constraint(s)) =========
-- Requires: store schema, ecommerce schema
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_storefront_id` FOREIGN KEY (`storefront_id`) REFERENCES `retail_ecm`.`ecommerce`.`storefront`(`storefront_id`);

-- ========= store --> finance (13 constraint(s)) =========
-- Requires: store schema, finance schema
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `retail_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`store`.`license` ADD CONSTRAINT `fk_store_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`store`.`license` ADD CONSTRAINT `fk_store_license_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`store`.`license` ADD CONSTRAINT `fk_store_license_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= store --> fulfillment (1 constraint(s)) =========
-- Requires: store schema, fulfillment schema
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= store --> inventory (1 constraint(s)) =========
-- Requires: store schema, inventory schema
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `retail_ecm`.`inventory`.`adjustment`(`adjustment_id`);

-- ========= store --> loyalty (3 constraint(s)) =========
-- Requires: store schema, loyalty schema
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`store`.`format` ADD CONSTRAINT `fk_store_format_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);

-- ========= store --> merchandising (3 constraint(s)) =========
-- Requires: store schema, merchandising schema
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);

-- ========= store --> pricing (6 constraint(s)) =========
-- Requires: store schema, pricing schema
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_cost_zone_id` FOREIGN KEY (`cost_zone_id`) REFERENCES `retail_ecm`.`pricing`.`cost_zone`(`cost_zone_id`);
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `retail_ecm`.`pricing`.`price_list`(`price_list_id`);
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `retail_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= store --> product (2 constraint(s)) =========
-- Requires: store schema, product schema
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);

-- ========= store --> promotion (6 constraint(s)) =========
-- Requires: store schema, promotion schema
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ADD CONSTRAINT `fk_store_traffic_count_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `retail_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= store --> returns (1 constraint(s)) =========
-- Requires: store schema, returns schema
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);

-- ========= store --> supplier (4 constraint(s)) =========
-- Requires: store schema, supplier schema
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_item`(`vendor_item_id`);

-- ========= store --> supplychain (1 constraint(s)) =========
-- Requires: store schema, supplychain schema
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);

-- ========= supplier --> finance (14 constraint(s)) =========
-- Requires: supplier schema, finance schema
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `retail_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `retail_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `retail_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `retail_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `retail_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `retail_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supplier --> fulfillment (2 constraint(s)) =========
-- Requires: supplier schema, fulfillment schema
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);

-- ========= supplier --> inventory (6 constraint(s)) =========
-- Requires: supplier schema, inventory schema
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `retail_ecm`.`inventory`.`asn`(`asn_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `retail_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `retail_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);

-- ========= supplier --> loyalty (1 constraint(s)) =========
-- Requires: supplier schema, loyalty schema
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `retail_ecm`.`loyalty`.`program`(`program_id`);

-- ========= supplier --> merchandising (10 constraint(s)) =========
-- Requires: supplier schema, merchandising schema
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_buying_order_id` FOREIGN KEY (`buying_order_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order`(`buying_order_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_buying_order_line_id` FOREIGN KEY (`buying_order_line_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order_line`(`buying_order_line_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_buying_order_id` FOREIGN KEY (`buying_order_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order`(`buying_order_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_buying_order_line_id` FOREIGN KEY (`buying_order_line_id`) REFERENCES `retail_ecm`.`merchandising`.`buying_order_line`(`buying_order_line_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_category_id` FOREIGN KEY (`category_id`) REFERENCES `retail_ecm`.`merchandising`.`category`(`category_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);

-- ========= supplier --> order (3 constraint(s)) =========
-- Requires: supplier schema, order schema
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `retail_ecm`.`order`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `retail_ecm`.`order`.`order_line`(`order_line_id`);

-- ========= supplier --> product (4 constraint(s)) =========
-- Requires: supplier schema, product schema
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);

-- ========= supplier --> returns (5 constraint(s)) =========
-- Requires: supplier schema, returns schema
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_return_receipt_id` FOREIGN KEY (`return_receipt_id`) REFERENCES `retail_ecm`.`returns`.`return_receipt`(`return_receipt_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `retail_ecm`.`returns`.`rma`(`rma_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_return_receipt_id` FOREIGN KEY (`return_receipt_id`) REFERENCES `retail_ecm`.`returns`.`return_receipt`(`return_receipt_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_return_policy_id` FOREIGN KEY (`return_policy_id`) REFERENCES `retail_ecm`.`returns`.`return_policy`(`return_policy_id`);

-- ========= supplier --> store (4 constraint(s)) =========
-- Requires: supplier schema, store schema
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_origin_location_id` FOREIGN KEY (`origin_location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= supplier --> supplychain (12 constraint(s)) =========
-- Requires: supplier schema, supplychain schema
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);

-- ========= supplychain --> customer (4 constraint(s)) =========
-- Requires: supplychain schema, customer schema
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `retail_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `retail_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `retail_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `retail_ecm`.`customer`.`address`(`address_id`);

-- ========= supplychain --> finance (1 constraint(s)) =========
-- Requires: supplychain schema, finance schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `retail_ecm`.`finance`.`budget`(`budget_id`);

-- ========= supplychain --> fulfillment (17 constraint(s)) =========
-- Requires: supplychain schema, fulfillment schema
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ADD CONSTRAINT `fk_supplychain_inbound_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ADD CONSTRAINT `fk_supplychain_inbound_appointment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ADD CONSTRAINT `fk_supplychain_wave_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ADD CONSTRAINT `fk_supplychain_wave_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_carrier_rate_id` FOREIGN KEY (`carrier_rate_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_rate`(`carrier_rate_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);

-- ========= supplychain --> inventory (10 constraint(s)) =========
-- Requires: supplychain schema, inventory schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `retail_ecm`.`inventory`.`asn`(`asn_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `retail_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `retail_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_inventory_node_id` FOREIGN KEY (`inventory_node_id`) REFERENCES `retail_ecm`.`inventory`.`inventory_node`(`inventory_node_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `retail_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= supplychain --> merchandising (22 constraint(s)) =========
-- Requires: supplychain schema, merchandising schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `retail_ecm`.`merchandising`.`buyer`(`buyer_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ADD CONSTRAINT `fk_supplychain_wave_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_merch_plan_id` FOREIGN KEY (`merch_plan_id`) REFERENCES `retail_ecm`.`merchandising`.`merch_plan`(`merch_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_season_id` FOREIGN KEY (`season_id`) REFERENCES `retail_ecm`.`merchandising`.`season`(`season_id`);

-- ========= supplychain --> order (1 constraint(s)) =========
-- Requires: supplychain schema, order schema
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_header_id` FOREIGN KEY (`header_id`) REFERENCES `retail_ecm`.`order`.`header`(`header_id`);

-- ========= supplychain --> pricing (4 constraint(s)) =========
-- Requires: supplychain schema, pricing schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_margin_target_id` FOREIGN KEY (`margin_target_id`) REFERENCES `retail_ecm`.`pricing`.`margin_target`(`margin_target_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `retail_ecm`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= supplychain --> product (16 constraint(s)) =========
-- Requires: supplychain schema, product schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_assortment_id` FOREIGN KEY (`assortment_id`) REFERENCES `retail_ecm`.`product`.`assortment`(`assortment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `retail_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_gtin_registry_id` FOREIGN KEY (`gtin_registry_id`) REFERENCES `retail_ecm`.`product`.`gtin_registry`(`gtin_registry_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_assortment_id` FOREIGN KEY (`assortment_id`) REFERENCES `retail_ecm`.`product`.`assortment`(`assortment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_gtin_registry_id` FOREIGN KEY (`gtin_registry_id`) REFERENCES `retail_ecm`.`product`.`gtin_registry`(`gtin_registry_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_gtin_registry_id` FOREIGN KEY (`gtin_registry_id`) REFERENCES `retail_ecm`.`product`.`gtin_registry`(`gtin_registry_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_gtin_registry_id` FOREIGN KEY (`gtin_registry_id`) REFERENCES `retail_ecm`.`product`.`gtin_registry`(`gtin_registry_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `retail_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `retail_ecm`.`product`.`uom`(`uom_id`);

-- ========= supplychain --> promotion (5 constraint(s)) =========
-- Requires: supplychain schema, promotion schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ADD CONSTRAINT `fk_supplychain_wave_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `retail_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= supplychain --> store (6 constraint(s)) =========
-- Requires: supplychain schema, store schema
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ADD CONSTRAINT `fk_supplychain_demand_forecast_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_sfs_fulfillment_node_id` FOREIGN KEY (`sfs_fulfillment_node_id`) REFERENCES `retail_ecm`.`store`.`sfs_fulfillment_node`(`sfs_fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);

-- ========= supplychain --> supplier (7 constraint(s)) =========
-- Requires: supplychain schema, supplier schema
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ADD CONSTRAINT `fk_supplychain_inbound_appointment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

