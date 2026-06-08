-- Cross-Domain Foreign Keys for Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:15
-- Total cross-domain FK constraints: 1042
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: consumer, distribution, finance, inventory, logistics, manufacturing, marketing, procurement, product, promotion, quality, regulatory, sales, supply

-- ========= consumer --> distribution (9 constraint(s)) =========
-- Requires: consumer schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_pick_task_id` FOREIGN KEY (`pick_task_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`pick_task`(`pick_task_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= consumer --> finance (21 constraint(s)) =========
-- Requires: consumer schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `consumer_goods_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `consumer_goods_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `consumer_goods_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);

-- ========= consumer --> inventory (9 constraint(s)) =========
-- Requires: consumer schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`recall_event`(`recall_event_id`);

-- ========= consumer --> logistics (7 constraint(s)) =========
-- Requires: consumer schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_proof_of_delivery_id` FOREIGN KEY (`proof_of_delivery_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`proof_of_delivery`(`proof_of_delivery_id`);

-- ========= consumer --> manufacturing (3 constraint(s)) =========
-- Requires: consumer schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= consumer --> marketing (13 constraint(s)) =========
-- Requires: consumer schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= consumer --> procurement (1 constraint(s)) =========
-- Requires: consumer schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);

-- ========= consumer --> product (12 constraint(s)) =========
-- Requires: consumer schema, product schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= consumer --> promotion (8 constraint(s)) =========
-- Requires: consumer schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`consumer_offer`(`consumer_offer_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`consumer_offer`(`consumer_offer_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`consumer_offer`(`consumer_offer_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`consumer_offer`(`consumer_offer_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`consumer_offer`(`consumer_offer_id`);

-- ========= consumer --> quality (5 constraint(s)) =========
-- Requires: consumer schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `consumer_goods_ecm`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `consumer_goods_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);

-- ========= consumer --> regulatory (8 constraint(s)) =========
-- Requires: consumer schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= consumer --> sales (10 constraint(s)) =========
-- Requires: consumer schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `consumer_goods_ecm`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_account_call_id` FOREIGN KEY (`account_call_id`) REFERENCES `consumer_goods_ecm`.`sales`.`account_call`(`account_call_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= consumer --> supply (2 constraint(s)) =========
-- Requires: consumer schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_atp_record_id` FOREIGN KEY (`atp_record_id`) REFERENCES `consumer_goods_ecm`.`supply`.`atp_record`(`atp_record_id`);
ALTER TABLE `consumer_goods_ecm`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);

-- ========= distribution --> finance (19 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `consumer_goods_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `consumer_goods_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= distribution --> inventory (10 constraint(s)) =========
-- Requires: distribution schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_inventory_cycle_count_id` FOREIGN KEY (`inventory_cycle_count_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_cycle_count`(`inventory_cycle_count_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_stock_adjustment_id` FOREIGN KEY (`stock_adjustment_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_adjustment`(`stock_adjustment_id`);

-- ========= distribution --> logistics (21 constraint(s)) =========
-- Requires: distribution schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_route_id` FOREIGN KEY (`route_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_route_id` FOREIGN KEY (`route_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`route`(`route_id`);

-- ========= distribution --> manufacturing (5 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= distribution --> marketing (3 constraint(s)) =========
-- Requires: distribution schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= distribution --> procurement (7 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= distribution --> product (6 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `consumer_goods_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= distribution --> promotion (5 constraint(s)) =========
-- Requires: distribution schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= distribution --> quality (1 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= distribution --> regulatory (16 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ADD CONSTRAINT `fk_distribution_distribution_storage_location_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);

-- ========= distribution --> sales (6 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= finance --> distribution (4 constraint(s)) =========
-- Requires: finance schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);

-- ========= finance --> inventory (3 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);

-- ========= finance --> manufacturing (3 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= finance --> marketing (2 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= finance --> procurement (9 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`spend_category`(`spend_category_id`);

-- ========= finance --> product (9 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= finance --> regulatory (3 constraint(s)) =========
-- Requires: finance schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);

-- ========= finance --> sales (12 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= inventory --> finance (10 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= inventory --> logistics (4 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);

-- ========= inventory --> manufacturing (8 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= inventory --> marketing (7 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= inventory --> procurement (11 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= inventory --> product (15 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `consumer_goods_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_bom_line_id` FOREIGN KEY (`bom_line_id`) REFERENCES `consumer_goods_ecm`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `consumer_goods_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> promotion (4 constraint(s)) =========
-- Requires: inventory schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);

-- ========= inventory --> quality (4 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `consumer_goods_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `consumer_goods_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `consumer_goods_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= inventory --> regulatory (15 constraint(s)) =========
-- Requires: inventory schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_dossier_id` FOREIGN KEY (`dossier_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`dossier`(`dossier_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_compliance_assessment_id` FOREIGN KEY (`compliance_assessment_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_assessment`(`compliance_assessment_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);

-- ========= inventory --> sales (4 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);

-- ========= inventory --> supply (4 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `consumer_goods_ecm`.`supply`.`safety_stock`(`safety_stock_id`);

-- ========= logistics --> distribution (4 constraint(s)) =========
-- Requires: logistics schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_primary_logistics_distribution_facility_id` FOREIGN KEY (`primary_logistics_distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= logistics --> finance (8 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `consumer_goods_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `consumer_goods_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `consumer_goods_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= logistics --> inventory (6 constraint(s)) =========
-- Requires: logistics schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= logistics --> manufacturing (4 constraint(s)) =========
-- Requires: logistics schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= logistics --> marketing (3 constraint(s)) =========
-- Requires: logistics schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= logistics --> procurement (3 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= logistics --> product (3 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_pack_hierarchy_id` FOREIGN KEY (`pack_hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`pack_hierarchy`(`pack_hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `consumer_goods_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= logistics --> promotion (4 constraint(s)) =========
-- Requires: logistics schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_event_sku_id` FOREIGN KEY (`event_sku_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event_sku`(`event_sku_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);

-- ========= logistics --> quality (1 constraint(s)) =========
-- Requires: logistics schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= logistics --> regulatory (7 constraint(s)) =========
-- Requires: logistics schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= logistics --> sales (12 constraint(s)) =========
-- Requires: logistics schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);

-- ========= logistics --> supply (8 constraint(s)) =========
-- Requires: logistics schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_lane_supply_network_node_id` FOREIGN KEY (`lane_supply_network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_supply_replenishment_order_id` FOREIGN KEY (`supply_replenishment_order_id`) REFERENCES `consumer_goods_ecm`.`supply`.`supply_replenishment_order`(`supply_replenishment_order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_supply_replenishment_order_id` FOREIGN KEY (`supply_replenishment_order_id`) REFERENCES `consumer_goods_ecm`.`supply`.`supply_replenishment_order`(`supply_replenishment_order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_supply_replenishment_order_id` FOREIGN KEY (`supply_replenishment_order_id`) REFERENCES `consumer_goods_ecm`.`supply`.`supply_replenishment_order`(`supply_replenishment_order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_supply_replenishment_order_id` FOREIGN KEY (`supply_replenishment_order_id`) REFERENCES `consumer_goods_ecm`.`supply`.`supply_replenishment_order`(`supply_replenishment_order_id`);

-- ========= manufacturing --> consumer (1 constraint(s)) =========
-- Requires: manufacturing schema, consumer schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `consumer_goods_ecm`.`consumer`.`subscription`(`subscription_id`);

-- ========= manufacturing --> distribution (2 constraint(s)) =========
-- Requires: manufacturing schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= manufacturing --> finance (15 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `consumer_goods_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `consumer_goods_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `consumer_goods_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= manufacturing --> inventory (6 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);

-- ========= manufacturing --> marketing (4 constraint(s)) =========
-- Requires: manufacturing schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= manufacturing --> procurement (8 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= manufacturing --> product (15 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `consumer_goods_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `consumer_goods_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> promotion (4 constraint(s)) =========
-- Requires: manufacturing schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= manufacturing --> quality (5 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `consumer_goods_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= manufacturing --> regulatory (6 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);

-- ========= manufacturing --> sales (6 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= manufacturing --> supply (6 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `consumer_goods_ecm`.`supply`.`safety_stock`(`safety_stock_id`);

-- ========= marketing --> consumer (1 constraint(s)) =========
-- Requires: marketing schema, consumer schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `consumer_goods_ecm`.`consumer`.`segment`(`segment_id`);

-- ========= marketing --> finance (21 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= marketing --> procurement (3 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`spend_category`(`spend_category_id`);

-- ========= marketing --> product (11 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`consumer_segment` ADD CONSTRAINT `fk_marketing_consumer_segment_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= marketing --> promotion (2 constraint(s)) =========
-- Requires: marketing schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);

-- ========= marketing --> regulatory (4 constraint(s)) =========
-- Requires: marketing schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_regulatory_claim_id` FOREIGN KEY (`regulatory_claim_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`regulatory_claim`(`regulatory_claim_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_regulatory_claim_id` FOREIGN KEY (`regulatory_claim_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`regulatory_claim`(`regulatory_claim_id`);

-- ========= marketing --> sales (10 constraint(s)) =========
-- Requires: marketing schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `consumer_goods_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= procurement --> finance (11 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> inventory (3 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= procurement --> logistics (1 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= procurement --> manufacturing (7 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= procurement --> marketing (7 constraint(s)) =========
-- Requires: procurement schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= procurement --> product (4 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= procurement --> quality (5 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);

-- ========= procurement --> regulatory (9 constraint(s)) =========
-- Requires: procurement schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);

-- ========= procurement --> sales (1 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);

-- ========= procurement --> supply (5 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `consumer_goods_ecm`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `consumer_goods_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= product --> distribution (1 constraint(s)) =========
-- Requires: product schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`product`.`pack_hierarchy` ADD CONSTRAINT `fk_product_pack_hierarchy_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= product --> finance (12 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> manufacturing (3 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= product --> marketing (2 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= product --> procurement (15 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> quality (11 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);

-- ========= product --> regulatory (13 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);

-- ========= product --> supply (1 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= promotion --> consumer (1 constraint(s)) =========
-- Requires: promotion schema, consumer schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `consumer_goods_ecm`.`consumer`.`segment`(`segment_id`);

-- ========= promotion --> distribution (1 constraint(s)) =========
-- Requires: promotion schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);

-- ========= promotion --> finance (35 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `consumer_goods_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `consumer_goods_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= promotion --> inventory (4 constraint(s)) =========
-- Requires: promotion schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_oos_event_id` FOREIGN KEY (`oos_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`oos_event`(`oos_event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_oos_event_id` FOREIGN KEY (`oos_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`oos_event`(`oos_event_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_oos_event_id` FOREIGN KEY (`oos_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`oos_event`(`oos_event_id`);

-- ========= promotion --> logistics (1 constraint(s)) =========
-- Requires: promotion schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_proof_of_delivery_id` FOREIGN KEY (`proof_of_delivery_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`proof_of_delivery`(`proof_of_delivery_id`);

-- ========= promotion --> marketing (13 constraint(s)) =========
-- Requires: promotion schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_market_research_study_id` FOREIGN KEY (`market_research_study_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`market_research_study`(`market_research_study_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);

-- ========= promotion --> procurement (4 constraint(s)) =========
-- Requires: promotion schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);

-- ========= promotion --> product (14 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);

-- ========= promotion --> regulatory (9 constraint(s)) =========
-- Requires: promotion schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= promotion --> sales (23 constraint(s)) =========
-- Requires: promotion schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `consumer_goods_ecm`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event` ADD CONSTRAINT `fk_promotion_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `consumer_goods_ecm`.`sales`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction` ADD CONSTRAINT `fk_promotion_deduction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_price_list_item_id` FOREIGN KEY (`price_list_item_id`) REFERENCES `consumer_goods_ecm`.`sales`.`price_list_item`(`price_list_item_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_account_call_id` FOREIGN KEY (`account_call_id`) REFERENCES `consumer_goods_ecm`.`sales`.`account_call`(`account_call_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= quality --> consumer (1 constraint(s)) =========
-- Requires: quality schema, consumer schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `consumer_goods_ecm`.`consumer`.`shopper`(`shopper_id`);

-- ========= quality --> distribution (15 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);

-- ========= quality --> finance (7 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (11 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);

-- ========= quality --> logistics (3 constraint(s)) =========
-- Requires: quality schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= quality --> manufacturing (2 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= quality --> marketing (5 constraint(s)) =========
-- Requires: quality schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= quality --> procurement (22 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= quality --> product (10 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_specification_sku_id` FOREIGN KEY (`specification_sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= quality --> promotion (2 constraint(s)) =========
-- Requires: quality schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_consumer_offer_id` FOREIGN KEY (`consumer_offer_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`consumer_offer`(`consumer_offer_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);

-- ========= quality --> regulatory (9 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= quality --> sales (5 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

-- ========= regulatory --> finance (8 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ADD CONSTRAINT `fk_regulatory_registration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ADD CONSTRAINT `fk_regulatory_registration_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= regulatory --> manufacturing (2 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ADD CONSTRAINT `fk_regulatory_registration_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= regulatory --> marketing (1 constraint(s)) =========
-- Requires: regulatory schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_market_research_study_id` FOREIGN KEY (`market_research_study_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`market_research_study`(`market_research_study_id`);

-- ========= regulatory --> procurement (5 constraint(s)) =========
-- Requires: regulatory schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= regulatory --> product (11 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ADD CONSTRAINT `fk_regulatory_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `consumer_goods_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `consumer_goods_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= sales --> distribution (5 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= sales --> finance (21 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `consumer_goods_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= sales --> inventory (6 constraint(s)) =========
-- Requires: sales schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_oos_event_id` FOREIGN KEY (`oos_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`oos_event`(`oos_event_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= sales --> manufacturing (2 constraint(s)) =========
-- Requires: sales schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= sales --> marketing (16 constraint(s)) =========
-- Requires: sales schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= sales --> procurement (3 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= sales --> product (9 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_category_id` FOREIGN KEY (`category_id`) REFERENCES `consumer_goods_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= sales --> promotion (2 constraint(s)) =========
-- Requires: sales schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);

-- ========= sales --> quality (3 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `consumer_goods_ecm`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);

-- ========= sales --> regulatory (5 constraint(s)) =========
-- Requires: sales schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);

-- ========= sales --> supply (2 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);

-- ========= supply --> distribution (3 constraint(s)) =========
-- Requires: supply schema, distribution schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_distribution_shipment_id` FOREIGN KEY (`distribution_shipment_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_shipment`(`distribution_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_inventory_position_id` FOREIGN KEY (`inventory_position_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inventory_position`(`inventory_position_id`);

-- ========= supply --> finance (12 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `consumer_goods_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `consumer_goods_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `consumer_goods_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_standard_cost_id` FOREIGN KEY (`standard_cost_id`) REFERENCES `consumer_goods_ecm`.`finance`.`standard_cost`(`standard_cost_id`);

-- ========= supply --> inventory (4 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= supply --> logistics (9 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);

-- ========= supply --> manufacturing (4 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`planned_order`(`planned_order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= supply --> marketing (6 constraint(s)) =========
-- Requires: supply schema, marketing schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `consumer_goods_ecm`.`marketing`.`consumer_segment`(`consumer_segment_id`);

-- ========= supply --> procurement (9 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_approved_supplier_list_id` FOREIGN KEY (`approved_supplier_list_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`approved_supplier_list`(`approved_supplier_list_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `consumer_goods_ecm`.`procurement`.`supplier_contract`(`supplier_contract_id`);

-- ========= supply --> product (14 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `consumer_goods_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `consumer_goods_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `consumer_goods_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `consumer_goods_ecm`.`product`.`sku`(`sku_id`);

-- ========= supply --> promotion (14 constraint(s)) =========
-- Requires: supply schema, promotion schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_baseline_volume_id` FOREIGN KEY (`baseline_volume_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`baseline_volume`(`baseline_volume_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_calendar`(`trade_calendar_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_promotion`(`trade_promotion_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_event_sku_id` FOREIGN KEY (`event_sku_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event_sku`(`event_sku_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_baseline_volume_id` FOREIGN KEY (`baseline_volume_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`baseline_volume`(`baseline_volume_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_event_id` FOREIGN KEY (`event_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`event`(`event_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` ADD CONSTRAINT `fk_supply_planning_period_trade_calendar_id` FOREIGN KEY (`trade_calendar_id`) REFERENCES `consumer_goods_ecm`.`promotion`.`trade_calendar`(`trade_calendar_id`);

-- ========= supply --> quality (7 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `consumer_goods_ecm`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `consumer_goods_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `consumer_goods_ecm`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);

-- ========= supply --> regulatory (11 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= supply --> sales (9 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);

