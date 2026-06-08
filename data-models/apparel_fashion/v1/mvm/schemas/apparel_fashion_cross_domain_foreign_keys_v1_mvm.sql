-- Cross-Domain Foreign Keys for Business: Apparel Fashion | Version: v1_mvm
-- Generated on: 2026-05-05 18:07:25
-- Total cross-domain FK constraints: 942
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, finance, inventory, logistics, marketing, merchandising, order, product, production, sourcing, store, supplier

-- ========= customer --> finance (8 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= customer --> logistics (1 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= customer --> marketing (5 constraint(s)) =========
-- Requires: customer schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);

-- ========= customer --> merchandising (12 constraint(s)) =========
-- Requires: customer schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`channel`(`channel_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_book`(`price_book_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_region_id` FOREIGN KEY (`region_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`region`(`region_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`channel`(`channel_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_book`(`price_book_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_region_id` FOREIGN KEY (`region_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`region`(`region_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ADD CONSTRAINT `fk_customer_size_profile_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);

-- ========= customer --> order (4 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);

-- ========= customer --> product (1 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ADD CONSTRAINT `fk_customer_size_profile_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);

-- ========= customer --> production (1 constraint(s)) =========
-- Requires: customer schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= customer --> store (8 constraint(s)) =========
-- Requires: customer schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ADD CONSTRAINT `fk_customer_size_profile_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= customer --> supplier (4 constraint(s)) =========
-- Requires: customer schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= finance --> customer (5 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= finance --> inventory (5 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`asn`(`asn_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= finance --> order (4 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_order_purchase_order_line_id` FOREIGN KEY (`order_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order_line`(`order_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);

-- ========= finance --> product (5 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= finance --> sourcing (4 constraint(s)) =========
-- Requires: finance schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= finance --> store (1 constraint(s)) =========
-- Requires: finance schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= finance --> supplier (9 constraint(s)) =========
-- Requires: finance schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_vendor_bank_account_id` FOREIGN KEY (`vendor_bank_account_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_bank_account`(`vendor_bank_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_vendor_bank_account_id` FOREIGN KEY (`vendor_bank_account_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_bank_account`(`vendor_bank_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= inventory --> customer (4 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`service_request`(`service_request_id`);

-- ========= inventory --> finance (4 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);

-- ========= inventory --> logistics (36 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_duty_calculation_id` FOREIGN KEY (`duty_calculation_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`duty_calculation`(`duty_calculation_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_packing_list_id` FOREIGN KEY (`packing_list_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`packing_list`(`packing_list_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_packing_list_id` FOREIGN KEY (`packing_list_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`packing_list`(`packing_list_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_packing_list_id` FOREIGN KEY (`packing_list_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`packing_list`(`packing_list_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);

-- ========= inventory --> marketing (8 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= inventory --> merchandising (38 constraint(s)) =========
-- Requires: inventory schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_price_change_event_id` FOREIGN KEY (`price_change_event_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_change_event`(`price_change_event_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_size_curve_id` FOREIGN KEY (`size_curve_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`size_curve`(`size_curve_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_size_curve_id` FOREIGN KEY (`size_curve_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`size_curve`(`size_curve_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_price_change_event_id` FOREIGN KEY (`price_change_event_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_change_event`(`price_change_event_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_price_master_id` FOREIGN KEY (`price_master_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_master`(`price_master_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_buy_plan_id` FOREIGN KEY (`buy_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan`(`buy_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);

-- ========= inventory --> order (4 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);

-- ========= inventory --> product (15 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_cost_sheet_id` FOREIGN KEY (`cost_sheet_id`) REFERENCES `apparel_fashion_ecm`.`product`.`cost_sheet`(`cost_sheet_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> production (10 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= inventory --> sourcing (10 constraint(s)) =========
-- Requires: inventory schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_lab_dip_id` FOREIGN KEY (`lab_dip_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`lab_dip`(`lab_dip_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);

-- ========= inventory --> store (18 constraint(s)) =========
-- Requires: inventory schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_return_transaction_id` FOREIGN KEY (`return_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`return_transaction`(`return_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_ship_from_store_id` FOREIGN KEY (`ship_from_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`ship_from_store`(`ship_from_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `apparel_fashion_ecm`.`store`.`planogram`(`planogram_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_bopis_order_id` FOREIGN KEY (`bopis_order_id`) REFERENCES `apparel_fashion_ecm`.`store`.`bopis_order`(`bopis_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_markdown_event_id` FOREIGN KEY (`markdown_event_id`) REFERENCES `apparel_fashion_ecm`.`store`.`markdown_event`(`markdown_event_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= inventory --> supplier (10 constraint(s)) =========
-- Requires: inventory schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= logistics --> customer (2 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= logistics --> finance (26 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ADD CONSTRAINT `fk_logistics_hs_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ADD CONSTRAINT `fk_logistics_third_party_logistics_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ADD CONSTRAINT `fk_logistics_third_party_logistics_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ADD CONSTRAINT `fk_logistics_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ADD CONSTRAINT `fk_logistics_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= logistics --> merchandising (3 constraint(s)) =========
-- Requires: logistics schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= logistics --> product (5 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= logistics --> production (18 constraint(s)) =========
-- Requires: logistics schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `apparel_fashion_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_delivery_window_id` FOREIGN KEY (`delivery_window_id`) REFERENCES `apparel_fashion_ecm`.`production`.`delivery_window`(`delivery_window_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `apparel_fashion_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= logistics --> sourcing (14 constraint(s)) =========
-- Requires: logistics schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_tna_calendar_id` FOREIGN KEY (`tna_calendar_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`tna_calendar`(`tna_calendar_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_sourcing_tna_milestone_id` FOREIGN KEY (`sourcing_tna_milestone_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone`(`sourcing_tna_milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);

-- ========= logistics --> supplier (11 constraint(s)) =========
-- Requires: logistics schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ADD CONSTRAINT `fk_logistics_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= marketing --> customer (13 constraint(s)) =========
-- Requires: marketing schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_consent_id` FOREIGN KEY (`consent_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`consent`(`consent_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= marketing --> finance (14 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= marketing --> inventory (3 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= marketing --> logistics (3 constraint(s)) =========
-- Requires: marketing schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);

-- ========= marketing --> order (1 constraint(s)) =========
-- Requires: marketing schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);

-- ========= marketing --> product (25 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= marketing --> production (3 constraint(s)) =========
-- Requires: marketing schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_pp_sample_id` FOREIGN KEY (`pp_sample_id`) REFERENCES `apparel_fashion_ecm`.`production`.`pp_sample`(`pp_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_pp_sample_id` FOREIGN KEY (`pp_sample_id`) REFERENCES `apparel_fashion_ecm`.`production`.`pp_sample`(`pp_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= marketing --> sourcing (5 constraint(s)) =========
-- Requires: marketing schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_tna_calendar_id` FOREIGN KEY (`tna_calendar_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`tna_calendar`(`tna_calendar_id`);

-- ========= marketing --> store (5 constraint(s)) =========
-- Requires: marketing schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= marketing --> supplier (8 constraint(s)) =========
-- Requires: marketing schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_factory_certification_id` FOREIGN KEY (`factory_certification_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`factory_certification`(`factory_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= merchandising --> customer (12 constraint(s)) =========
-- Requires: merchandising schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`size_curve` ADD CONSTRAINT `fk_merchandising_size_curve_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_book` ADD CONSTRAINT `fk_merchandising_price_book_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_book` ADD CONSTRAINT `fk_merchandising_price_book_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`division` ADD CONSTRAINT `fk_merchandising_division_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`channel` ADD CONSTRAINT `fk_merchandising_channel_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= merchandising --> finance (40 constraint(s)) =========
-- Requires: merchandising schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy` ADD CONSTRAINT `fk_merchandising_merchandise_hierarchy_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_book` ADD CONSTRAINT `fk_merchandising_price_book_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`division` ADD CONSTRAINT `fk_merchandising_division_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`division` ADD CONSTRAINT `fk_merchandising_division_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`channel` ADD CONSTRAINT `fk_merchandising_channel_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`channel` ADD CONSTRAINT `fk_merchandising_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`region` ADD CONSTRAINT `fk_merchandising_region_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`region` ADD CONSTRAINT `fk_merchandising_region_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`region` ADD CONSTRAINT `fk_merchandising_region_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= merchandising --> logistics (10 constraint(s)) =========
-- Requires: merchandising schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy` ADD CONSTRAINT `fk_merchandising_merchandise_hierarchy_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_duty_calculation_id` FOREIGN KEY (`duty_calculation_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`duty_calculation`(`duty_calculation_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`region` ADD CONSTRAINT `fk_merchandising_region_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);

-- ========= merchandising --> marketing (9 constraint(s)) =========
-- Requires: merchandising schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= merchandising --> product (19 constraint(s)) =========
-- Requires: merchandising schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`size_curve` ADD CONSTRAINT `fk_merchandising_size_curve_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_book` ADD CONSTRAINT `fk_merchandising_price_book_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);

-- ========= merchandising --> production (4 constraint(s)) =========
-- Requires: merchandising schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_factory_capacity_id` FOREIGN KEY (`factory_capacity_id`) REFERENCES `apparel_fashion_ecm`.`production`.`factory_capacity`(`factory_capacity_id`);

-- ========= merchandising --> sourcing (13 constraint(s)) =========
-- Requires: merchandising schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_tna_calendar_id` FOREIGN KEY (`tna_calendar_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`tna_calendar`(`tna_calendar_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_vendor_quote_id` FOREIGN KEY (`vendor_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_quote`(`vendor_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_rfq_line_id` FOREIGN KEY (`rfq_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq_line`(`rfq_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`size_curve` ADD CONSTRAINT `fk_merchandising_size_curve_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);

-- ========= merchandising --> store (10 constraint(s)) =========
-- Requires: merchandising schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`size_curve` ADD CONSTRAINT `fk_merchandising_size_curve_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_book` ADD CONSTRAINT `fk_merchandising_price_book_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`cluster`(`cluster_id`);

-- ========= merchandising --> supplier (6 constraint(s)) =========
-- Requires: merchandising schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= order --> customer (14 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ADD CONSTRAINT `fk_order_allocation_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= order --> finance (5 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);

-- ========= order --> inventory (12 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_primary_order_warehouse_location_id` FOREIGN KEY (`primary_order_warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`reservation`(`reservation_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= order --> logistics (7 constraint(s)) =========
-- Requires: order schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= order --> marketing (4 constraint(s)) =========
-- Requires: order schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= order --> merchandising (15 constraint(s)) =========
-- Requires: order schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`channel`(`channel_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_book`(`price_book_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_price_master_id` FOREIGN KEY (`price_master_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_master`(`price_master_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_buy_plan_id` FOREIGN KEY (`buy_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan`(`buy_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_division_id` FOREIGN KEY (`division_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`division`(`division_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`channel`(`channel_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`channel`(`channel_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ADD CONSTRAINT `fk_order_allocation_rule_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation_rule` ADD CONSTRAINT `fk_order_allocation_rule_size_curve_id` FOREIGN KEY (`size_curve_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`size_curve`(`size_curve_id`);

-- ========= order --> product (13 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_backorder_substitute_sku_id` FOREIGN KEY (`backorder_substitute_sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= order --> production (8 constraint(s)) =========
-- Requires: order schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_delivery_window_id` FOREIGN KEY (`delivery_window_id`) REFERENCES `apparel_fashion_ecm`.`production`.`delivery_window`(`delivery_window_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);

-- ========= order --> sourcing (4 constraint(s)) =========
-- Requires: order schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_rfq_line_id` FOREIGN KEY (`rfq_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq_line`(`rfq_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);

-- ========= order --> store (5 constraint(s)) =========
-- Requires: order schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= order --> supplier (9 constraint(s)) =========
-- Requires: order schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_capacity_profile_id` FOREIGN KEY (`capacity_profile_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`capacity_profile`(`capacity_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= product --> customer (7 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ADD CONSTRAINT `fk_product_msrp_price_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= product --> finance (25 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ADD CONSTRAINT `fk_product_msrp_price_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> logistics (6 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_duty_calculation_id` FOREIGN KEY (`duty_calculation_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`duty_calculation`(`duty_calculation_id`);

-- ========= product --> merchandising (5 constraint(s)) =========
-- Requires: product schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= product --> production (1 constraint(s)) =========
-- Requires: product schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `apparel_fashion_ecm`.`production`.`routing`(`routing_id`);

-- ========= product --> supplier (7 constraint(s)) =========
-- Requires: product schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= production --> customer (5 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= production --> finance (15 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ADD CONSTRAINT `fk_production_work_order_operation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ADD CONSTRAINT `fk_production_production_factory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ADD CONSTRAINT `fk_production_production_factory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= production --> inventory (2 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= production --> merchandising (11 constraint(s)) =========
-- Requires: production schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_buy_plan_id` FOREIGN KEY (`buy_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan`(`buy_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_buy_plan_id` FOREIGN KEY (`buy_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan`(`buy_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_buy_plan_line_id` FOREIGN KEY (`buy_plan_line_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan_line`(`buy_plan_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_collection_plan_id` FOREIGN KEY (`collection_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`collection_plan`(`collection_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= production --> product (25 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`line` ADD CONSTRAINT `fk_production_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);

-- ========= production --> sourcing (4 constraint(s)) =========
-- Requires: production schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);

-- ========= production --> supplier (9 constraint(s)) =========
-- Requires: production schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= sourcing --> finance (8 constraint(s)) =========
-- Requires: sourcing schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= sourcing --> inventory (1 constraint(s)) =========
-- Requires: sourcing schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= sourcing --> logistics (7 constraint(s)) =========
-- Requires: sourcing schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_freight_booking_id` FOREIGN KEY (`freight_booking_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`freight_booking`(`freight_booking_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= sourcing --> merchandising (2 constraint(s)) =========
-- Requires: sourcing schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= sourcing --> product (41 constraint(s)) =========
-- Requires: sourcing schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_bom_line_id` FOREIGN KEY (`bom_line_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sample`(`sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= sourcing --> production (16 constraint(s)) =========
-- Requires: sourcing schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `apparel_fashion_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_delivery_window_id` FOREIGN KEY (`delivery_window_id`) REFERENCES `apparel_fashion_ecm`.`production`.`delivery_window`(`delivery_window_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `apparel_fashion_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `apparel_fashion_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_bulk_fabric_receipt_id` FOREIGN KEY (`bulk_fabric_receipt_id`) REFERENCES `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt`(`bulk_fabric_receipt_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_production_tna_milestone_id` FOREIGN KEY (`production_tna_milestone_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_tna_milestone`(`production_tna_milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_pp_sample_id` FOREIGN KEY (`pp_sample_id`) REFERENCES `apparel_fashion_ecm`.`production`.`pp_sample`(`pp_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_pp_sample_id` FOREIGN KEY (`pp_sample_id`) REFERENCES `apparel_fashion_ecm`.`production`.`pp_sample`(`pp_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_bulk_fabric_receipt_id` FOREIGN KEY (`bulk_fabric_receipt_id`) REFERENCES `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt`(`bulk_fabric_receipt_id`);

-- ========= sourcing --> supplier (14 constraint(s)) =========
-- Requires: sourcing schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`tna_calendar` ADD CONSTRAINT `fk_sourcing_tna_calendar_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= store --> customer (12 constraint(s)) =========
-- Requires: store schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= store --> finance (11 constraint(s)) =========
-- Requires: store schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= store --> logistics (8 constraint(s)) =========
-- Requires: store schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);

-- ========= store --> marketing (9 constraint(s)) =========
-- Requires: store schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= store --> merchandising (17 constraint(s)) =========
-- Requires: store schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_price_change_event_id` FOREIGN KEY (`price_change_event_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_change_event`(`price_change_event_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_price_master_id` FOREIGN KEY (`price_master_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_master`(`price_master_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_price_change_event_id` FOREIGN KEY (`price_change_event_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_change_event`(`price_change_event_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_region_id` FOREIGN KEY (`region_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`region`(`region_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= store --> order (8 constraint(s)) =========
-- Requires: store schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `apparel_fashion_ecm`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);

-- ========= store --> product (18 constraint(s)) =========
-- Requires: store schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);

-- ========= store --> production (1 constraint(s)) =========
-- Requires: store schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= store --> sourcing (3 constraint(s)) =========
-- Requires: store schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= store --> supplier (2 constraint(s)) =========
-- Requires: store schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= supplier --> finance (13 constraint(s)) =========
-- Requires: supplier schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ADD CONSTRAINT `fk_supplier_vendor_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_certification` ADD CONSTRAINT `fk_supplier_factory_certification_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ADD CONSTRAINT `fk_supplier_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= supplier --> merchandising (10 constraint(s)) =========
-- Requires: supplier schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_certification` ADD CONSTRAINT `fk_supplier_factory_certification_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ADD CONSTRAINT `fk_supplier_risk_assessment_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_buy_plan_id` FOREIGN KEY (`buy_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan`(`buy_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= supplier --> product (2 constraint(s)) =========
-- Requires: supplier schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`material_supplier` ADD CONSTRAINT `fk_supplier_material_supplier_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= supplier --> production (5 constraint(s)) =========
-- Requires: supplier schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `apparel_fashion_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

