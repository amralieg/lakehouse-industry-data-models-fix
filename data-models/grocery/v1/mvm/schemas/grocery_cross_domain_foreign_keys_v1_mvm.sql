-- Cross-Domain Foreign Keys for Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:53
-- Total cross-domain FK constraints: 906
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: assortment, customer, finance, fulfillment, inventory, loyalty, payment, pharmacy, pricing, product, promotion, store, supply, vendor

-- ========= assortment --> finance (4 constraint(s)) =========
-- Requires: assortment schema, finance schema
ALTER TABLE `grocery_ecm`.`assortment`.`category` ADD CONSTRAINT `fk_assortment_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ADD CONSTRAINT `fk_assortment_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ADD CONSTRAINT `fk_assortment_fixture_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `grocery_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ADD CONSTRAINT `fk_assortment_fixture_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `grocery_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= assortment --> product (3 constraint(s)) =========
-- Requires: assortment schema, product schema
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= assortment --> promotion (1 constraint(s)) =========
-- Requires: assortment schema, promotion schema
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= assortment --> store (9 constraint(s)) =========
-- Requires: assortment schema, store schema
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ADD CONSTRAINT `fk_assortment_plan_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ADD CONSTRAINT `fk_assortment_store_cluster_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ADD CONSTRAINT `fk_assortment_store_cluster_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ADD CONSTRAINT `fk_assortment_fixture_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ADD CONSTRAINT `fk_assortment_fixture_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= assortment --> vendor (8 constraint(s)) =========
-- Requires: assortment schema, vendor schema
ALTER TABLE `grocery_ecm`.`assortment`.`category` ADD CONSTRAINT `fk_assortment_category_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_cost_schedule_id` FOREIGN KEY (`cost_schedule_id`) REFERENCES `grocery_ecm`.`vendor`.`cost_schedule`(`cost_schedule_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);

-- ========= customer --> assortment (3 constraint(s)) =========
-- Requires: customer schema, assortment schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= customer --> finance (4 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`customer`.`benefit_enrollment` ADD CONSTRAINT `fk_customer_benefit_enrollment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= customer --> fulfillment (4 constraint(s)) =========
-- Requires: customer schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`delivery_route`(`delivery_route_id`);

-- ========= customer --> loyalty (7 constraint(s)) =========
-- Requires: customer schema, loyalty schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `grocery_ecm`.`customer`.`benefit_enrollment` ADD CONSTRAINT `fk_customer_benefit_enrollment_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);

-- ========= customer --> payment (1 constraint(s)) =========
-- Requires: customer schema, payment schema
ALTER TABLE `grocery_ecm`.`customer`.`benefit_enrollment` ADD CONSTRAINT `fk_customer_benefit_enrollment_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);

-- ========= customer --> pharmacy (5 constraint(s)) =========
-- Requires: customer schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_insurance_plan_id` FOREIGN KEY (`insurance_plan_id`) REFERENCES `grocery_ecm`.`pharmacy`.`insurance_plan`(`insurance_plan_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_prescriber_id` FOREIGN KEY (`prescriber_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescriber`(`prescriber_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);

-- ========= customer --> pricing (3 constraint(s)) =========
-- Requires: customer schema, pricing schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);

-- ========= customer --> product (1 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= customer --> promotion (2 constraint(s)) =========
-- Requires: customer schema, promotion schema
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= customer --> store (12 constraint(s)) =========
-- Requires: customer schema, store schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`contact_info` ADD CONSTRAINT `fk_customer_contact_info_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`benefit_enrollment` ADD CONSTRAINT `fk_customer_benefit_enrollment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= customer --> supply (2 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);

-- ========= finance --> assortment (2 constraint(s)) =========
-- Requires: finance schema, assortment schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= finance --> fulfillment (7 constraint(s)) =========
-- Requires: finance schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `grocery_ecm`.`fulfillment`.`order`(`order_id`);
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `grocery_ecm`.`fulfillment`.`vehicle`(`vehicle_id`);

-- ========= finance --> payment (2 constraint(s)) =========
-- Requires: finance schema, payment schema
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);

-- ========= finance --> pricing (1 constraint(s)) =========
-- Requires: finance schema, pricing schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= finance --> store (1 constraint(s)) =========
-- Requires: finance schema, store schema
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= finance --> supply (2 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `grocery_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= finance --> vendor (3 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= fulfillment --> assortment (6 constraint(s)) =========
-- Requires: fulfillment schema, assortment schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);

-- ========= fulfillment --> customer (5 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= fulfillment --> finance (2 constraint(s)) =========
-- Requires: fulfillment schema, finance schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`delivery_route` ADD CONSTRAINT `fk_fulfillment_delivery_route_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= fulfillment --> inventory (11 constraint(s)) =========
-- Requires: fulfillment schema, inventory schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_receiving_record_id` FOREIGN KEY (`receiving_record_id`) REFERENCES `grocery_ecm`.`inventory`.`receiving_record`(`receiving_record_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `grocery_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `grocery_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_temperature_zone_id` FOREIGN KEY (`temperature_zone_id`) REFERENCES `grocery_ecm`.`inventory`.`temperature_zone`(`temperature_zone_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_temperature_zone_id` FOREIGN KEY (`temperature_zone_id`) REFERENCES `grocery_ecm`.`inventory`.`temperature_zone`(`temperature_zone_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ADD CONSTRAINT `fk_fulfillment_vehicle_temperature_zone_id` FOREIGN KEY (`temperature_zone_id`) REFERENCES `grocery_ecm`.`inventory`.`temperature_zone`(`temperature_zone_id`);

-- ========= fulfillment --> loyalty (2 constraint(s)) =========
-- Requires: fulfillment schema, loyalty schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_member_offer_id` FOREIGN KEY (`member_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`member_offer`(`member_offer_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ADD CONSTRAINT `fk_fulfillment_sla_policy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `grocery_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= fulfillment --> pharmacy (7 constraint(s)) =========
-- Requires: fulfillment schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_rx_fill_id` FOREIGN KEY (`rx_fill_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_fill`(`rx_fill_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= fulfillment --> pricing (6 constraint(s)) =========
-- Requires: fulfillment schema, pricing schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_channel_price_id` FOREIGN KEY (`channel_price_id`) REFERENCES `grocery_ecm`.`pricing`.`channel_price`(`channel_price_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `grocery_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_tpr_id` FOREIGN KEY (`tpr_id`) REFERENCES `grocery_ecm`.`pricing`.`tpr`(`tpr_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= fulfillment --> product (8 constraint(s)) =========
-- Requires: fulfillment schema, product schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);

-- ========= fulfillment --> promotion (5 constraint(s)) =========
-- Requires: fulfillment schema, promotion schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`order` ADD CONSTRAINT `fk_fulfillment_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_offer_item_id` FOREIGN KEY (`offer_item_id`) REFERENCES `grocery_ecm`.`promotion`.`offer_item`(`offer_item_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= fulfillment --> store (1 constraint(s)) =========
-- Requires: fulfillment schema, store schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= fulfillment --> supply (3 constraint(s)) =========
-- Requires: fulfillment schema, supply schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `grocery_ecm`.`supply`.`transport_route`(`transport_route_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= fulfillment --> vendor (3 constraint(s)) =========
-- Requires: fulfillment schema, vendor schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= inventory --> assortment (12 constraint(s)) =========
-- Requires: inventory schema, assortment schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `grocery_ecm`.`assortment`.`fixture`(`fixture_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= inventory --> customer (1 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= inventory --> finance (15 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= inventory --> fulfillment (3 constraint(s)) =========
-- Requires: inventory schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_wms_task_id` FOREIGN KEY (`wms_task_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wms_task`(`wms_task_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_slot_location_id` FOREIGN KEY (`slot_location_id`) REFERENCES `grocery_ecm`.`fulfillment`.`slot_location`(`slot_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);

-- ========= inventory --> loyalty (1 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);

-- ========= inventory --> pharmacy (3 constraint(s)) =========
-- Requires: inventory schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= inventory --> pricing (10 constraint(s)) =========
-- Requires: inventory schema, pricing schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `grocery_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `grocery_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `grocery_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= inventory --> product (14 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= inventory --> promotion (9 constraint(s)) =========
-- Requires: inventory schema, promotion schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_tpr_event_id` FOREIGN KEY (`tpr_event_id`) REFERENCES `grocery_ecm`.`promotion`.`tpr_event`(`tpr_event_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_tpr_event_id` FOREIGN KEY (`tpr_event_id`) REFERENCES `grocery_ecm`.`promotion`.`tpr_event`(`tpr_event_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_tpr_event_id` FOREIGN KEY (`tpr_event_id`) REFERENCES `grocery_ecm`.`promotion`.`tpr_event`(`tpr_event_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= inventory --> store (21 constraint(s)) =========
-- Requires: inventory schema, store schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_mfc_profile_id` FOREIGN KEY (`mfc_profile_id`) REFERENCES `grocery_ecm`.`store`.`mfc_profile`(`mfc_profile_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= inventory --> supply (17 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `grocery_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_allocation_plan_id` FOREIGN KEY (`allocation_plan_id`) REFERENCES `grocery_ecm`.`supply`.`allocation_plan`(`allocation_plan_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `grocery_ecm`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `grocery_ecm`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `grocery_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `grocery_ecm`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `grocery_ecm`.`supply`.`transport_route`(`transport_route_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_vendor_lead_time_id` FOREIGN KEY (`vendor_lead_time_id`) REFERENCES `grocery_ecm`.`supply`.`vendor_lead_time`(`vendor_lead_time_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_direct_store_delivery_id` FOREIGN KEY (`direct_store_delivery_id`) REFERENCES `grocery_ecm`.`supply`.`direct_store_delivery`(`direct_store_delivery_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `grocery_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `grocery_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> vendor (15 constraint(s)) =========
-- Requires: inventory schema, vendor schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);

-- ========= loyalty --> assortment (5 constraint(s)) =========
-- Requires: loyalty schema, assortment schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);

-- ========= loyalty --> customer (4 constraint(s)) =========
-- Requires: loyalty schema, customer schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ADD CONSTRAINT `fk_loyalty_household_member_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);

-- ========= loyalty --> finance (10 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_account` ADD CONSTRAINT `fk_loyalty_points_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `grocery_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= loyalty --> fulfillment (1 constraint(s)) =========
-- Requires: loyalty schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_order_id` FOREIGN KEY (`order_id`) REFERENCES `grocery_ecm`.`fulfillment`.`order`(`order_id`);

-- ========= loyalty --> payment (5 constraint(s)) =========
-- Requires: loyalty schema, payment schema
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);

-- ========= loyalty --> pharmacy (2 constraint(s)) =========
-- Requires: loyalty schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= loyalty --> pricing (3 constraint(s)) =========
-- Requires: loyalty schema, pricing schema
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);

-- ========= loyalty --> product (4 constraint(s)) =========
-- Requires: loyalty schema, product schema
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);

-- ========= loyalty --> promotion (8 constraint(s)) =========
-- Requires: loyalty schema, promotion schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_digital_coupon_id` FOREIGN KEY (`digital_coupon_id`) REFERENCES `grocery_ecm`.`promotion`.`digital_coupon`(`digital_coupon_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= loyalty --> store (6 constraint(s)) =========
-- Requires: loyalty schema, store schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_membership_store_location_id` FOREIGN KEY (`membership_store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ADD CONSTRAINT `fk_loyalty_household_member_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= loyalty --> supply (1 constraint(s)) =========
-- Requires: loyalty schema, supply schema
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);

-- ========= loyalty --> vendor (4 constraint(s)) =========
-- Requires: loyalty schema, vendor schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_trade_allowance_id` FOREIGN KEY (`trade_allowance_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_allowance`(`trade_allowance_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);

-- ========= payment --> customer (6 constraint(s)) =========
-- Requires: payment schema, customer schema
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= payment --> finance (14 constraint(s)) =========
-- Requires: payment schema, finance schema
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ADD CONSTRAINT `fk_payment_tender_type_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= payment --> fulfillment (4 constraint(s)) =========
-- Requires: payment schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `grocery_ecm`.`fulfillment`.`order`(`order_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_fulfillment_order_line_id` FOREIGN KEY (`fulfillment_order_line_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_order_line`(`fulfillment_order_line_id`);

-- ========= payment --> inventory (1 constraint(s)) =========
-- Requires: payment schema, inventory schema
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_shrink_record_id` FOREIGN KEY (`shrink_record_id`) REFERENCES `grocery_ecm`.`inventory`.`shrink_record`(`shrink_record_id`);

-- ========= payment --> loyalty (1 constraint(s)) =========
-- Requires: payment schema, loyalty schema
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_loyalty_redemption_id` FOREIGN KEY (`loyalty_redemption_id`) REFERENCES `grocery_ecm`.`loyalty`.`loyalty_redemption`(`loyalty_redemption_id`);

-- ========= payment --> pharmacy (1 constraint(s)) =========
-- Requires: payment schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_rx_fill_id` FOREIGN KEY (`rx_fill_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_fill`(`rx_fill_id`);

-- ========= payment --> pricing (5 constraint(s)) =========
-- Requires: payment schema, pricing schema
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_channel_price_id` FOREIGN KEY (`channel_price_id`) REFERENCES `grocery_ecm`.`pricing`.`channel_price`(`channel_price_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `grocery_ecm`.`pricing`.`markdown`(`markdown_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_tpr_id` FOREIGN KEY (`tpr_id`) REFERENCES `grocery_ecm`.`pricing`.`tpr`(`tpr_id`);

-- ========= payment --> promotion (1 constraint(s)) =========
-- Requires: payment schema, promotion schema
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= payment --> store (8 constraint(s)) =========
-- Requires: payment schema, store schema
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= payment --> supply (2 constraint(s)) =========
-- Requires: payment schema, supply schema
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_direct_store_delivery_id` FOREIGN KEY (`direct_store_delivery_id`) REFERENCES `grocery_ecm`.`supply`.`direct_store_delivery`(`direct_store_delivery_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `grocery_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);

-- ========= payment --> vendor (2 constraint(s)) =========
-- Requires: payment schema, vendor schema
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);

-- ========= pharmacy --> assortment (4 constraint(s)) =========
-- Requires: pharmacy schema, assortment schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `grocery_ecm`.`assortment`.`fixture`(`fixture_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);

-- ========= pharmacy --> customer (2 constraint(s)) =========
-- Requires: pharmacy schema, customer schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= pharmacy --> finance (10 constraint(s)) =========
-- Requires: pharmacy schema, finance schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ADD CONSTRAINT `fk_pharmacy_insurance_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `grocery_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= pharmacy --> inventory (2 constraint(s)) =========
-- Requires: pharmacy schema, inventory schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= pharmacy --> loyalty (2 constraint(s)) =========
-- Requires: pharmacy schema, loyalty schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);

-- ========= pharmacy --> payment (1 constraint(s)) =========
-- Requires: pharmacy schema, payment schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);

-- ========= pharmacy --> pricing (2 constraint(s)) =========
-- Requires: pharmacy schema, pricing schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_price_override_id` FOREIGN KEY (`price_override_id`) REFERENCES `grocery_ecm`.`pricing`.`price_override`(`price_override_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= pharmacy --> product (1 constraint(s)) =========
-- Requires: pharmacy schema, product schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_rx_order_id` FOREIGN KEY (`rx_order_id`) REFERENCES `grocery_ecm`.`product`.`rx_order`(`rx_order_id`);

-- ========= pharmacy --> promotion (3 constraint(s)) =========
-- Requires: pharmacy schema, promotion schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_promotion_redemption_id` FOREIGN KEY (`promotion_redemption_id`) REFERENCES `grocery_ecm`.`promotion`.`promotion_redemption`(`promotion_redemption_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= pharmacy --> store (1 constraint(s)) =========
-- Requires: pharmacy schema, store schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= pharmacy --> vendor (8 constraint(s)) =========
-- Requires: pharmacy schema, vendor schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_compliance_record_id` FOREIGN KEY (`compliance_record_id`) REFERENCES `grocery_ecm`.`vendor`.`compliance_record`(`compliance_record_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_cost_schedule_id` FOREIGN KEY (`cost_schedule_id`) REFERENCES `grocery_ecm`.`vendor`.`cost_schedule`(`cost_schedule_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);

-- ========= pricing --> assortment (12 constraint(s)) =========
-- Requires: pricing schema, assortment schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);

-- ========= pricing --> finance (9 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_zone` ADD CONSTRAINT `fk_pricing_price_zone_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= pricing --> payment (1 constraint(s)) =========
-- Requires: pricing schema, payment schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);

-- ========= pricing --> product (10 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);

-- ========= pricing --> promotion (2 constraint(s)) =========
-- Requires: pricing schema, promotion schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= pricing --> store (5 constraint(s)) =========
-- Requires: pricing schema, store schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= pricing --> vendor (12 constraint(s)) =========
-- Requires: pricing schema, vendor schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_trade_allowance_id` FOREIGN KEY (`trade_allowance_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_allowance`(`trade_allowance_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);

-- ========= product --> assortment (3 constraint(s)) =========
-- Requires: product schema, assortment schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= product --> customer (12 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_contact_info_id` FOREIGN KEY (`contact_info_id`) REFERENCES `grocery_ecm`.`customer`.`contact_info`(`contact_info_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_pharmacy_patient_id` FOREIGN KEY (`pharmacy_patient_id`) REFERENCES `grocery_ecm`.`customer`.`pharmacy_patient`(`pharmacy_patient_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= product --> finance (48 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`private_label` ADD CONSTRAINT `fk_product_private_label_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ADD CONSTRAINT `fk_product_drug_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ADD CONSTRAINT `fk_product_drug_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> fulfillment (22 constraint(s)) =========
-- Requires: product schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `grocery_ecm`.`fulfillment`.`vehicle`(`vehicle_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);

-- ========= product --> loyalty (2 constraint(s)) =========
-- Requires: product schema, loyalty schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);

-- ========= product --> payment (14 constraint(s)) =========
-- Requires: product schema, payment schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `grocery_ecm`.`payment`.`authorization`(`authorization_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `grocery_ecm`.`payment`.`chargeback`(`chargeback_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `grocery_ecm`.`payment`.`refund`(`refund_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);

-- ========= product --> pharmacy (12 constraint(s)) =========
-- Requires: product schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_rx_claim_id` FOREIGN KEY (`rx_claim_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_claim`(`rx_claim_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_insurance_plan_id` FOREIGN KEY (`insurance_plan_id`) REFERENCES `grocery_ecm`.`pharmacy`.`insurance_plan`(`insurance_plan_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_rx_claim_id` FOREIGN KEY (`rx_claim_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_claim`(`rx_claim_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ADD CONSTRAINT `fk_product_drug_item_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);

-- ========= product --> pricing (3 constraint(s)) =========
-- Requires: product schema, pricing schema
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `grocery_ecm`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);

-- ========= product --> promotion (8 constraint(s)) =========
-- Requires: product schema, promotion schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_ad_circular_id` FOREIGN KEY (`ad_circular_id`) REFERENCES `grocery_ecm`.`promotion`.`ad_circular`(`ad_circular_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= product --> store (13 constraint(s)) =========
-- Requires: product schema, store schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_service_capability_id` FOREIGN KEY (`service_capability_id`) REFERENCES `grocery_ecm`.`store`.`service_capability`(`service_capability_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_mfc_profile_id` FOREIGN KEY (`mfc_profile_id`) REFERENCES `grocery_ecm`.`store`.`mfc_profile`(`mfc_profile_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_service_capability_id` FOREIGN KEY (`service_capability_id`) REFERENCES `grocery_ecm`.`store`.`service_capability`(`service_capability_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= product --> vendor (23 constraint(s)) =========
-- Requires: product schema, vendor schema
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ADD CONSTRAINT `fk_product_upc_barcode_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ADD CONSTRAINT `fk_product_upc_barcode_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ADD CONSTRAINT `fk_product_plu_code_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ADD CONSTRAINT `fk_product_item_attribute_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ADD CONSTRAINT `fk_product_allergen_declaration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`private_label` ADD CONSTRAINT `fk_product_private_label_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_brand_co_manufacturer_vendor_supplier_id` FOREIGN KEY (`brand_co_manufacturer_vendor_supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_brand_supplier_id` FOREIGN KEY (`brand_supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_cost_schedule_id` FOREIGN KEY (`cost_schedule_id`) REFERENCES `grocery_ecm`.`vendor`.`cost_schedule`(`cost_schedule_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`drug_item` ADD CONSTRAINT `fk_product_drug_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);

-- ========= promotion --> assortment (23 constraint(s)) =========
-- Requires: promotion schema, assortment schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= promotion --> customer (11 constraint(s)) =========
-- Requires: promotion schema, customer schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= promotion --> finance (18 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `grocery_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `grocery_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `grocery_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `grocery_ecm`.`finance`.`payment_run`(`payment_run_id`);

-- ========= promotion --> fulfillment (1 constraint(s)) =========
-- Requires: promotion schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_order_id` FOREIGN KEY (`order_id`) REFERENCES `grocery_ecm`.`fulfillment`.`order`(`order_id`);

-- ========= promotion --> loyalty (8 constraint(s)) =========
-- Requires: promotion schema, loyalty schema
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `grocery_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_member_offer_id` FOREIGN KEY (`member_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`member_offer`(`member_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_points_transaction_id` FOREIGN KEY (`points_transaction_id`) REFERENCES `grocery_ecm`.`loyalty`.`points_transaction`(`points_transaction_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `grocery_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= promotion --> payment (4 constraint(s)) =========
-- Requires: promotion schema, payment schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);

-- ========= promotion --> pharmacy (2 constraint(s)) =========
-- Requires: promotion schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);

-- ========= promotion --> pricing (8 constraint(s)) =========
-- Requires: promotion schema, pricing schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_tpr_id` FOREIGN KEY (`tpr_id`) REFERENCES `grocery_ecm`.`pricing`.`tpr`(`tpr_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_tpr_id` FOREIGN KEY (`tpr_id`) REFERENCES `grocery_ecm`.`pricing`.`tpr`(`tpr_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);

-- ========= promotion --> product (4 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);

-- ========= promotion --> store (11 constraint(s)) =========
-- Requires: promotion schema, store schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= promotion --> vendor (20 constraint(s)) =========
-- Requires: promotion schema, vendor schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_trade_allowance_id` FOREIGN KEY (`trade_allowance_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_allowance`(`trade_allowance_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_trade_allowance_id` FOREIGN KEY (`trade_allowance_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_allowance`(`trade_allowance_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_trade_allowance_id` FOREIGN KEY (`trade_allowance_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_allowance`(`trade_allowance_id`);

-- ========= store --> assortment (2 constraint(s)) =========
-- Requires: store schema, assortment schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= store --> finance (16 constraint(s)) =========
-- Requires: store schema, finance schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ADD CONSTRAINT `fk_store_service_capability_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`lease` ADD CONSTRAINT `fk_store_lease_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`lease` ADD CONSTRAINT `fk_store_lease_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`store`.`lease` ADD CONSTRAINT `fk_store_lease_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`store`.`banner` ADD CONSTRAINT `fk_store_banner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`store`.`division` ADD CONSTRAINT `fk_store_division_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= store --> fulfillment (3 constraint(s)) =========
-- Requires: store schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ADD CONSTRAINT `fk_store_service_capability_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);

-- ========= store --> loyalty (2 constraint(s)) =========
-- Requires: store schema, loyalty schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `grocery_ecm`.`store`.`banner` ADD CONSTRAINT `fk_store_banner_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);

-- ========= store --> payment (2 constraint(s)) =========
-- Requires: store schema, payment schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);

-- ========= store --> pharmacy (3 constraint(s)) =========
-- Requires: store schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ADD CONSTRAINT `fk_store_operating_hours_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ADD CONSTRAINT `fk_store_service_capability_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= store --> pricing (3 constraint(s)) =========
-- Requires: store schema, pricing schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`store`.`region` ADD CONSTRAINT `fk_store_region_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);

-- ========= store --> product (1 constraint(s)) =========
-- Requires: store schema, product schema
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);

-- ========= store --> supply (3 constraint(s)) =========
-- Requires: store schema, supply schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`store`.`region` ADD CONSTRAINT `fk_store_region_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= store --> vendor (4 constraint(s)) =========
-- Requires: store schema, vendor schema
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ADD CONSTRAINT `fk_store_service_capability_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);

-- ========= supply --> assortment (10 constraint(s)) =========
-- Requires: supply schema, assortment schema
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= supply --> finance (26 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `grocery_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `grocery_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `grocery_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ADD CONSTRAINT `fk_supply_dc_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ADD CONSTRAINT `fk_supply_dc_facility_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= supply --> fulfillment (18 constraint(s)) =========
-- Requires: supply schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_slot_location_id` FOREIGN KEY (`slot_location_id`) REFERENCES `grocery_ecm`.`fulfillment`.`slot_location`(`slot_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);

-- ========= supply --> inventory (1 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `grocery_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);

-- ========= supply --> loyalty (3 constraint(s)) =========
-- Requires: supply schema, loyalty schema
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);

-- ========= supply --> payment (1 constraint(s)) =========
-- Requires: supply schema, payment schema
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);

-- ========= supply --> pharmacy (5 constraint(s)) =========
-- Requires: supply schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);

-- ========= supply --> pricing (8 constraint(s)) =========
-- Requires: supply schema, pricing schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);

-- ========= supply --> product (10 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_private_label_id` FOREIGN KEY (`private_label_id`) REFERENCES `grocery_ecm`.`product`.`private_label`(`private_label_id`);

-- ========= supply --> promotion (6 constraint(s)) =========
-- Requires: supply schema, promotion schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_vendor_funding_id` FOREIGN KEY (`vendor_funding_id`) REFERENCES `grocery_ecm`.`promotion`.`vendor_funding`(`vendor_funding_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_ad_circular_id` FOREIGN KEY (`ad_circular_id`) REFERENCES `grocery_ecm`.`promotion`.`ad_circular`(`ad_circular_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_vendor_funding_id` FOREIGN KEY (`vendor_funding_id`) REFERENCES `grocery_ecm`.`promotion`.`vendor_funding`(`vendor_funding_id`);

-- ========= supply --> store (13 constraint(s)) =========
-- Requires: supply schema, store schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_primary_replenishment_store_location_id` FOREIGN KEY (`primary_replenishment_store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_primary_dc_store_location_id` FOREIGN KEY (`primary_dc_store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= supply --> vendor (21 constraint(s)) =========
-- Requires: supply schema, vendor schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_cost_schedule_id` FOREIGN KEY (`cost_schedule_id`) REFERENCES `grocery_ecm`.`vendor`.`cost_schedule`(`cost_schedule_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_compliance_record_id` FOREIGN KEY (`compliance_record_id`) REFERENCES `grocery_ecm`.`vendor`.`compliance_record`(`compliance_record_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);

-- ========= vendor --> finance (14 constraint(s)) =========
-- Requires: vendor schema, finance schema
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ADD CONSTRAINT `fk_vendor_supplier_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ADD CONSTRAINT `fk_vendor_vendor_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `grocery_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= vendor --> fulfillment (1 constraint(s)) =========
-- Requires: vendor schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);

-- ========= vendor --> loyalty (1 constraint(s)) =========
-- Requires: vendor schema, loyalty schema
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_reward_offer_id` FOREIGN KEY (`reward_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`reward_offer`(`reward_offer_id`);

-- ========= vendor --> pricing (2 constraint(s)) =========
-- Requires: vendor schema, pricing schema
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_tpr_id` FOREIGN KEY (`tpr_id`) REFERENCES `grocery_ecm`.`pricing`.`tpr`(`tpr_id`);

-- ========= vendor --> product (4 constraint(s)) =========
-- Requires: vendor schema, product schema
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ADD CONSTRAINT `fk_vendor_vendor_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `grocery_ecm`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ADD CONSTRAINT `fk_vendor_compliance_record_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

