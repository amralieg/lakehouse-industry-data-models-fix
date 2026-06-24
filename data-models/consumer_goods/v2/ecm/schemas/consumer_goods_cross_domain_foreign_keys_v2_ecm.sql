-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:25
-- Total cross-domain FK constraints: 918
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: consumer, customer, distribution, finance, inventory, logistics, manufacturing, marketing, procurement, product, promotion, quality, regulatory, research, sales, shared, supply, sustainability, workforce

-- ========= consumer --> customer (1 constraint(s)) =========
-- Requires: consumer schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= consumer --> distribution (3 constraint(s)) =========
-- Requires: consumer schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= consumer --> finance (5 constraint(s)) =========
-- Requires: consumer schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= consumer --> inventory (4 constraint(s)) =========
-- Requires: consumer schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= consumer --> logistics (4 constraint(s)) =========
-- Requires: consumer schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= consumer --> marketing (21 constraint(s)) =========
-- Requires: consumer schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ADD CONSTRAINT `fk_consumer_communication_preference_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_market_research_study_id` FOREIGN KEY (`market_research_study_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`market_research_study`(`market_research_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ADD CONSTRAINT `fk_consumer_preference_center_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ADD CONSTRAINT `fk_consumer_panel_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= consumer --> procurement (2 constraint(s)) =========
-- Requires: consumer schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);

-- ========= consumer --> product (6 constraint(s)) =========
-- Requires: consumer schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= consumer --> promotion (3 constraint(s)) =========
-- Requires: consumer schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= consumer --> quality (2 constraint(s)) =========
-- Requires: consumer schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);

-- ========= consumer --> regulatory (4 constraint(s)) =========
-- Requires: consumer schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= consumer --> research (3 constraint(s)) =========
-- Requires: consumer schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_consumer_test_id` FOREIGN KEY (`consumer_test_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`consumer_test`(`consumer_test_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_study_protocol_id` FOREIGN KEY (`study_protocol_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`study_protocol`(`study_protocol_id`);

-- ========= consumer --> sales (8 constraint(s)) =========
-- Requires: consumer schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_account_call_id` FOREIGN KEY (`account_call_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_call`(`account_call_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`opportunity`(`opportunity_id`);

-- ========= consumer --> supply (1 constraint(s)) =========
-- Requires: consumer schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_atp_record_id` FOREIGN KEY (`atp_record_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`atp_record`(`atp_record_id`);

-- ========= consumer --> sustainability (3 constraint(s)) =========
-- Requires: consumer schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident`(`environmental_incident_id`);

-- ========= consumer --> workforce (7 constraint(s)) =========
-- Requires: consumer schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> sales (1 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ADD CONSTRAINT `fk_customer_channel_classification_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= distribution --> finance (4 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= distribution --> inventory (12 constraint(s)) =========
-- Requires: distribution schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_inventory_replenishment_order_id` FOREIGN KEY (`inventory_replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order`(`inventory_replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_intransit_shipment_id` FOREIGN KEY (`intransit_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment`(`intransit_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_inventory_cycle_count_id` FOREIGN KEY (`inventory_cycle_count_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count`(`inventory_cycle_count_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`recall_event`(`recall_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= distribution --> logistics (16 constraint(s)) =========
-- Requires: distribution schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= distribution --> manufacturing (5 constraint(s)) =========
-- Requires: distribution schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_distribution_manufacturing_facility_id` FOREIGN KEY (`distribution_manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= distribution --> marketing (3 constraint(s)) =========
-- Requires: distribution schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= distribution --> procurement (6 constraint(s)) =========
-- Requires: distribution schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= distribution --> product (9 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ADD CONSTRAINT `fk_distribution_distribution_offset_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= distribution --> promotion (4 constraint(s)) =========
-- Requires: distribution schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= distribution --> regulatory (3 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);

-- ========= distribution --> research (4 constraint(s)) =========
-- Requires: distribution schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= distribution --> sales (11 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_outbound_sales_order_id` FOREIGN KEY (`outbound_sales_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_return_order_id` FOREIGN KEY (`return_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`return_order`(`return_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= distribution --> supply (1 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= distribution --> sustainability (2 constraint(s)) =========
-- Requires: distribution schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ADD CONSTRAINT `fk_distribution_distribution_offset_allocation_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);

-- ========= distribution --> workforce (25 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ADD CONSTRAINT `fk_distribution_distribution_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_receiving_clerk_employee_id` FOREIGN KEY (`receiving_clerk_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`putaway_task` ADD CONSTRAINT `fk_distribution_putaway_task_putaway_employee_id` FOREIGN KEY (`putaway_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_employee_id` FOREIGN KEY (`primary_pick_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_primary_pack_employee_id` FOREIGN KEY (`primary_pack_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_distribution_counted_by_employee_id` FOREIGN KEY (`distribution_counted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_primary_distribution_counter_employee_id` FOREIGN KEY (`primary_distribution_counter_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_route` ADD CONSTRAINT `fk_distribution_distribution_dsd_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_dsd_delivery` ADD CONSTRAINT `fk_distribution_distribution_dsd_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dsd_delivery_line` ADD CONSTRAINT `fk_distribution_dsd_delivery_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`dock_appointment` ADD CONSTRAINT `fk_distribution_dock_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`load_plan` ADD CONSTRAINT `fk_distribution_load_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_receiving_clerk_employee_id` FOREIGN KEY (`receiving_clerk_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_offset_allocation` ADD CONSTRAINT `fk_distribution_distribution_offset_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> manufacturing (4 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= finance --> marketing (3 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_marketing_budget_id` FOREIGN KEY (`marketing_budget_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_budget`(`marketing_budget_id`);

-- ========= finance --> procurement (7 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ADD CONSTRAINT `fk_finance_party_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= finance --> product (7 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cogs_allocation` ADD CONSTRAINT `fk_finance_cogs_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_standard_sku_id` FOREIGN KEY (`standard_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`material_ledger_posting` ADD CONSTRAINT `fk_finance_material_ledger_posting_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= finance --> promotion (1 constraint(s)) =========
-- Requires: finance schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_promotion_accrual_id` FOREIGN KEY (`promotion_accrual_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual`(`promotion_accrual_id`);

-- ========= finance --> research (2 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= finance --> sales (11 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`party` ADD CONSTRAINT `fk_finance_party_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= finance --> sustainability (4 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);

-- ========= finance --> workforce (27 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_created_by_employee_id` FOREIGN KEY (`journal_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_primary_finance_employee_id` FOREIGN KEY (`primary_finance_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_primary_finance_employee_id` FOREIGN KEY (`primary_finance_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`finance_accrual` ADD CONSTRAINT `fk_finance_finance_accrual_tertiary_finance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_finance_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_primary_sox_employee_id` FOREIGN KEY (`primary_sox_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_sox_control_owner_employee_id` FOREIGN KEY (`sox_control_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_tertiary_sox_tester_employee_id` FOREIGN KEY (`tertiary_sox_tester_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_employee_id` FOREIGN KEY (`payment_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_run_by_employee_id` FOREIGN KEY (`payment_run_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`revenue_contract` ADD CONSTRAINT `fk_finance_revenue_contract_revenue_employee_id` FOREIGN KEY (`revenue_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> distribution (1 constraint(s)) =========
-- Requires: inventory schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= inventory --> finance (1 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= inventory --> logistics (1 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= inventory --> manufacturing (1 constraint(s)) =========
-- Requires: inventory schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= inventory --> procurement (3 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= inventory --> product (13 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= inventory --> regulatory (1 constraint(s)) =========
-- Requires: inventory schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`product_recall`(`product_recall_id`);

-- ========= inventory --> sales (2 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);

-- ========= inventory --> workforce (12 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_inventory_counted_by_employee_id` FOREIGN KEY (`inventory_counted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_stock_initiated_by_employee_id` FOREIGN KEY (`stock_initiated_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_stock_release_approved_by_employee_id` FOREIGN KEY (`stock_release_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_stock_initiated_by_employee_id` FOREIGN KEY (`stock_initiated_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= logistics --> distribution (1 constraint(s)) =========
-- Requires: logistics schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` ADD CONSTRAINT `fk_logistics_consolidation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= logistics --> product (1 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> distribution (1 constraint(s)) =========
-- Requires: manufacturing schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= manufacturing --> finance (5 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= manufacturing --> inventory (1 constraint(s)) =========
-- Requires: manufacturing schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= manufacturing --> marketing (2 constraint(s)) =========
-- Requires: manufacturing schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= manufacturing --> procurement (2 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= manufacturing --> product (15 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_primary_manufacturing_sku_id` FOREIGN KEY (`primary_manufacturing_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_to_sku_id` FOREIGN KEY (`to_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= manufacturing --> promotion (1 constraint(s)) =========
-- Requires: manufacturing schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_promotion_id` FOREIGN KEY (`trade_promotion_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`trade_promotion`(`trade_promotion_id`);

-- ========= manufacturing --> quality (4 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);

-- ========= manufacturing --> regulatory (2 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);

-- ========= manufacturing --> research (2 constraint(s)) =========
-- Requires: manufacturing schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);

-- ========= manufacturing --> sales (5 constraint(s)) =========
-- Requires: manufacturing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= manufacturing --> supply (1 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= manufacturing --> sustainability (2 constraint(s)) =========
-- Requires: manufacturing schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_energy_certificate_id` FOREIGN KEY (`energy_certificate_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate`(`energy_certificate_id`);

-- ========= manufacturing --> workforce (22 constraint(s)) =========
-- Requires: manufacturing schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ADD CONSTRAINT `fk_manufacturing_manufacturing_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_tertiary_routing_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_routing_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_primary_batch_employee_id` FOREIGN KEY (`primary_batch_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_primary_downtime_employee_id` FOREIGN KEY (`primary_downtime_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_tertiary_yield_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_yield_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_gmp_reported_by_employee_id` FOREIGN KEY (`gmp_reported_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_primary_gmp_detected_by_employee_id` FOREIGN KEY (`primary_gmp_detected_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_confirmed_by_employee_id` FOREIGN KEY (`production_confirmed_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> consumer (3 constraint(s)) =========
-- Requires: marketing schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= marketing --> distribution (2 constraint(s)) =========
-- Requires: marketing schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= marketing --> finance (7 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= marketing --> inventory (1 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= marketing --> procurement (3 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ADD CONSTRAINT `fk_marketing_agency_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= marketing --> product (19 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ADD CONSTRAINT `fk_marketing_sov_measurement_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_attribution_sku_id` FOREIGN KEY (`attribution_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= marketing --> promotion (1 constraint(s)) =========
-- Requires: marketing schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= marketing --> regulatory (2 constraint(s)) =========
-- Requires: marketing schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ADD CONSTRAINT `fk_marketing_campaign_submission_link_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`submission`(`submission_id`);

-- ========= marketing --> research (3 constraint(s)) =========
-- Requires: marketing schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= marketing --> sales (6 constraint(s)) =========
-- Requires: marketing schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= marketing --> supply (1 constraint(s)) =========
-- Requires: marketing schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= marketing --> sustainability (5 constraint(s)) =========
-- Requires: marketing schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ADD CONSTRAINT `fk_marketing_marketing_offset_allocation_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`(`carbon_offset_id`);

-- ========= marketing --> workforce (25 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ADD CONSTRAINT `fk_marketing_consumer_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ADD CONSTRAINT `fk_marketing_sov_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_campaign_employee_id` FOREIGN KEY (`campaign_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_campaign_replacement_for_employee_id` FOREIGN KEY (`campaign_replacement_for_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> workforce (6 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= product --> consumer (1 constraint(s)) =========
-- Requires: product schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= product --> finance (3 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> logistics (1 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);

-- ========= product --> manufacturing (2 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= product --> marketing (1 constraint(s)) =========
-- Requires: product schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= product --> procurement (6 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= product --> regulatory (1 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`sds`(`sds_id`);

-- ========= product --> research (6 constraint(s)) =========
-- Requires: product schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_innovation_brief_id` FOREIGN KEY (`innovation_brief_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`innovation_brief`(`innovation_brief_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_research_formulation_id` FOREIGN KEY (`research_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_formulation`(`research_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ADD CONSTRAINT `fk_product_product_formulation_ingredient_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_claim_substantiation_id` FOREIGN KEY (`claim_substantiation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`claim_substantiation`(`claim_substantiation_id`);

-- ========= product --> sales (1 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_customer_vmi_agreement_id` FOREIGN KEY (`customer_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement`(`customer_vmi_agreement_id`);

-- ========= product --> workforce (10 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ADD CONSTRAINT `fk_product_product_formulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ADD CONSTRAINT `fk_product_product_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= promotion --> consumer (3 constraint(s)) =========
-- Requires: promotion schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);

-- ========= promotion --> customer (6 constraint(s)) =========
-- Requires: promotion schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= promotion --> finance (11 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_finance_accrual_id` FOREIGN KEY (`finance_accrual_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`finance_accrual`(`finance_accrual_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= promotion --> inventory (2 constraint(s)) =========
-- Requires: promotion schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= promotion --> marketing (11 constraint(s)) =========
-- Requires: promotion schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ADD CONSTRAINT `fk_promotion_flight_allocation_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign_flight`(`campaign_flight_id`);

-- ========= promotion --> procurement (2 constraint(s)) =========
-- Requires: promotion schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);

-- ========= promotion --> product (14 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_sku_group_id` FOREIGN KEY (`sku_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);

-- ========= promotion --> quality (1 constraint(s)) =========
-- Requires: promotion schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);

-- ========= promotion --> regulatory (2 constraint(s)) =========
-- Requires: promotion schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_label_version_id` FOREIGN KEY (`label_version_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);

-- ========= promotion --> research (5 constraint(s)) =========
-- Requires: promotion schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= promotion --> sales (24 constraint(s)) =========
-- Requires: promotion schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`event_sku` ADD CONSTRAINT `fk_promotion_event_sku_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`funding_agreement` ADD CONSTRAINT `fk_promotion_funding_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ADD CONSTRAINT `fk_promotion_rebate_settlement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`flight_allocation` ADD CONSTRAINT `fk_promotion_flight_allocation_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= promotion --> sustainability (1 constraint(s)) =========
-- Requires: promotion schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= promotion --> workforce (27 constraint(s)) =========
-- Requires: promotion schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_promotion` ADD CONSTRAINT `fk_promotion_trade_promotion_primary_trade_employee_id` FOREIGN KEY (`primary_trade_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_event` ADD CONSTRAINT `fk_promotion_promotion_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_calendar` ADD CONSTRAINT `fk_promotion_trade_calendar_tertiary_trade_created_by_employee_id` FOREIGN KEY (`tertiary_trade_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation` ADD CONSTRAINT `fk_promotion_trade_spend_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_accrual` ADD CONSTRAINT `fk_promotion_promotion_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_deduction` ADD CONSTRAINT `fk_promotion_promotion_deduction_tertiary_promotion_modified_by_user_employee_id` FOREIGN KEY (`tertiary_promotion_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`deduction_settlement` ADD CONSTRAINT `fk_promotion_deduction_settlement_tertiary_deduction_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_deduction_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promotion_rebate_agreement` ADD CONSTRAINT `fk_promotion_promotion_rebate_agreement_tertiary_promotion_created_by_employee_id` FOREIGN KEY (`tertiary_promotion_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ADD CONSTRAINT `fk_promotion_rebate_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`rebate_settlement` ADD CONSTRAINT `fk_promotion_rebate_settlement_tertiary_rebate_created_by_employee_id` FOREIGN KEY (`tertiary_rebate_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`post_event_analysis` ADD CONSTRAINT `fk_promotion_post_event_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`promoted_price` ADD CONSTRAINT `fk_promotion_promoted_price_tertiary_promoted_last_modified_by_employee_id` FOREIGN KEY (`tertiary_promoted_last_modified_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`lift_measurement` ADD CONSTRAINT `fk_promotion_lift_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`tpo_scenario` ADD CONSTRAINT `fk_promotion_tpo_scenario_tertiary_tpo_approved_by_user_employee_id` FOREIGN KEY (`tertiary_tpo_approved_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`retailer_compliance` ADD CONSTRAINT `fk_promotion_retailer_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`baseline_volume` ADD CONSTRAINT `fk_promotion_baseline_volume_tertiary_baseline_created_by_user_employee_id` FOREIGN KEY (`tertiary_baseline_created_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`pos_redemption` ADD CONSTRAINT `fk_promotion_pos_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`promotion`.`consumer_offer` ADD CONSTRAINT `fk_promotion_consumer_offer_tertiary_consumer_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_consumer_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> consumer (1 constraint(s)) =========
-- Requires: quality schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= quality --> inventory (1 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= quality --> manufacturing (11 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= quality --> procurement (4 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= quality --> product (12 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= quality --> research (1 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_research_stability_study_id` FOREIGN KEY (`research_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`research_stability_study`(`research_stability_study_id`);

-- ========= quality --> sales (1 constraint(s)) =========
-- Requires: quality schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= quality --> workforce (31 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_nonconformance_reported_by_employee_id` FOREIGN KEY (`nonconformance_reported_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_capa_assigned_to_employee_id` FOREIGN KEY (`capa_assigned_to_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_capa_initiated_by_employee_id` FOREIGN KEY (`capa_initiated_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ADD CONSTRAINT `fk_quality_quality_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_regulatory_released_by_employee_id` FOREIGN KEY (`regulatory_released_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_lab_requested_by_employee_id` FOREIGN KEY (`lab_requested_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_notification_created_by_employee_id` FOREIGN KEY (`notification_created_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_change_initiated_by_employee_id` FOREIGN KEY (`change_initiated_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ADD CONSTRAINT `fk_quality_laboratory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= regulatory --> finance (8 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= regulatory --> inventory (1 constraint(s)) =========
-- Requires: regulatory schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= regulatory --> logistics (1 constraint(s)) =========
-- Requires: regulatory schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= regulatory --> manufacturing (4 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ADD CONSTRAINT `fk_regulatory_epa_registration_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= regulatory --> procurement (3 constraint(s)) =========
-- Requires: regulatory schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`reach_substance` ADD CONSTRAINT `fk_regulatory_reach_substance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= regulatory --> product (22 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_label_spec_id` FOREIGN KEY (`label_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`label_spec`(`label_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`epa_registration` ADD CONSTRAINT `fk_regulatory_epa_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= regulatory --> research (2 constraint(s)) =========
-- Requires: regulatory schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_claim_substantiation_id` FOREIGN KEY (`claim_substantiation_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`claim_substantiation`(`claim_substantiation_id`);

-- ========= regulatory --> sustainability (1 constraint(s)) =========
-- Requires: regulatory schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);

-- ========= regulatory --> workforce (27 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration` ADD CONSTRAINT `fk_regulatory_regulatory_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_submission_submitted_by_employee_id` FOREIGN KEY (`submission_submitted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_primary_contact_employee_id` FOREIGN KEY (`primary_contact_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_label_approved_by_employee_id` FOREIGN KEY (`label_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_compliance_responsible_owner_employee_id` FOREIGN KEY (`compliance_responsible_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_primary_compliance_assessor_employee_id` FOREIGN KEY (`primary_compliance_assessor_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record` ADD CONSTRAINT `fk_regulatory_ifra_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event` ADD CONSTRAINT `fk_regulatory_surveillance_event_surveillance_responsible_employee_id` FOREIGN KEY (`surveillance_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_product_recall_coordinator_employee_id` FOREIGN KEY (`product_recall_coordinator_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`action` ADD CONSTRAINT `fk_regulatory_action_primary_regulatory_action_responsible_party_employee_id` FOREIGN KEY (`primary_regulatory_action_responsible_party_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing` ADD CONSTRAINT `fk_regulatory_cpsc_filing_cpsc_submitted_by_employee_id` FOREIGN KEY (`cpsc_submitted_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_change_responsible_employee_id` FOREIGN KEY (`change_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`regulatory`.`change` ADD CONSTRAINT `fk_regulatory_change_primary_regulatory_change_responsible_owner_employee_id` FOREIGN KEY (`primary_regulatory_change_responsible_owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= research --> consumer (5 constraint(s)) =========
-- Requires: research schema, consumer schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test_result` ADD CONSTRAINT `fk_research_consumer_test_result_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`respondent` ADD CONSTRAINT `fk_research_respondent_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`panel_session` ADD CONSTRAINT `fk_research_panel_session_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);

-- ========= research --> manufacturing (2 constraint(s)) =========
-- Requires: research schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= research --> marketing (2 constraint(s)) =========
-- Requires: research schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= research --> procurement (2 constraint(s)) =========
-- Requires: research schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`inci_library` ADD CONSTRAINT `fk_research_inci_library_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_sample` ADD CONSTRAINT `fk_research_research_sample_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= research --> product (13 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);

-- ========= research --> quality (1 constraint(s)) =========
-- Requires: research schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);

-- ========= research --> regulatory (1 constraint(s)) =========
-- Requires: research schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_regulatory_claim_id` FOREIGN KEY (`regulatory_claim_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_claim`(`regulatory_claim_id`);

-- ========= research --> sustainability (4 constraint(s)) =========
-- Requires: research schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_product_lca_id` FOREIGN KEY (`product_lca_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`product_lca`(`product_lca_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`prototype` ADD CONSTRAINT `fk_research_prototype_packaging_profile_id` FOREIGN KEY (`packaging_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`(`packaging_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= research --> workforce (25 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`rd_project` ADD CONSTRAINT `fk_research_rd_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ADD CONSTRAINT `fk_research_stage_gate_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stage_gate_milestone` ADD CONSTRAINT `fk_research_stage_gate_milestone_tertiary_stage_modified_by_user_employee_id` FOREIGN KEY (`tertiary_stage_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation` ADD CONSTRAINT `fk_research_research_formulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_formulation_ingredient` ADD CONSTRAINT `fk_research_research_formulation_ingredient_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`lab_test` ADD CONSTRAINT `fk_research_lab_test_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_stability_study` ADD CONSTRAINT `fk_research_research_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`stability_timepoint` ADD CONSTRAINT `fk_research_stability_timepoint_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`consumer_test` ADD CONSTRAINT `fk_research_consumer_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`sensory_evaluation` ADD CONSTRAINT `fk_research_sensory_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_filing` ADD CONSTRAINT `fk_research_patent_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`regulatory_dossier` ADD CONSTRAINT `fk_research_regulatory_dossier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`claim_substantiation` ADD CONSTRAINT `fk_research_claim_substantiation_tertiary_claim_regulatory_reviewer_employee_id` FOREIGN KEY (`tertiary_claim_regulatory_reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_tertiary_innovation_approved_by_employee_id` FOREIGN KEY (`tertiary_innovation_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`innovation_brief` ADD CONSTRAINT `fk_research_innovation_brief_tertiary_quinary_innovation_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_innovation_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`raw_material_spec` ADD CONSTRAINT `fk_research_raw_material_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`research_packaging_spec` ADD CONSTRAINT `fk_research_research_packaging_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`safety_assessment` ADD CONSTRAINT `fk_research_safety_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`scale_up_trial` ADD CONSTRAINT `fk_research_scale_up_trial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`study_protocol` ADD CONSTRAINT `fk_research_study_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`research`.`patent_family` ADD CONSTRAINT `fk_research_patent_family_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> procurement (1 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_procurement_vmi_agreement_id` FOREIGN KEY (`procurement_vmi_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement`(`procurement_vmi_agreement_id`);

-- ========= sales --> product (5 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ADD CONSTRAINT `fk_sales_planogram_compliance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= sales --> workforce (3 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ADD CONSTRAINT `fk_sales_account_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ADD CONSTRAINT `fk_sales_account_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= shared --> product (2 constraint(s)) =========
-- Requires: shared schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`currency` ADD CONSTRAINT `fk_shared_currency_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`language` ADD CONSTRAINT `fk_shared_language_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= shared --> regulatory (1 constraint(s)) =========
-- Requires: shared schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ADD CONSTRAINT `fk_shared_region_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= supply --> customer (2 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_channel_classification_id` FOREIGN KEY (`channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= supply --> distribution (4 constraint(s)) =========
-- Requires: supply schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= supply --> finance (6 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supply --> inventory (1 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= supply --> logistics (6 constraint(s)) =========
-- Requires: supply schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);

-- ========= supply --> manufacturing (4 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= supply --> marketing (2 constraint(s)) =========
-- Requires: supply schema, marketing schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= supply --> procurement (3 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= supply --> product (20 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ADD CONSTRAINT `fk_supply_forecast_accuracy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ADD CONSTRAINT `fk_supply_inventory_projection_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_primary_demand_sku_id` FOREIGN KEY (`primary_demand_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ADD CONSTRAINT `fk_supply_atp_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= supply --> promotion (4 constraint(s)) =========
-- Requires: supply schema, promotion schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `vibe_consumer_goods_v1`.`promotion`.`promotion_event`(`promotion_event_id`);

-- ========= supply --> regulatory (4 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_regulatory_registration_id` FOREIGN KEY (`regulatory_registration_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`(`regulatory_registration_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);

-- ========= supply --> research (4 constraint(s)) =========
-- Requires: supply schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`rd_project`(`rd_project_id`);

-- ========= supply --> sales (4 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= supply --> sustainability (2 constraint(s)) =========
-- Requires: supply schema, sustainability schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_esg_commitment_id` FOREIGN KEY (`esg_commitment_id`) REFERENCES `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`(`esg_commitment_id`);

-- ========= supply --> workforce (25 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_tertiary_forecast_modified_by_user_employee_id` FOREIGN KEY (`tertiary_forecast_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ADD CONSTRAINT `fk_supply_forecast_accuracy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_tertiary_quinary_sop_last_modified_by_employee_id` FOREIGN KEY (`tertiary_quinary_sop_last_modified_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ADD CONSTRAINT `fk_supply_sop_cycle_tertiary_sop_supply_planner_employee_id` FOREIGN KEY (`tertiary_sop_supply_planner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_tertiary_consensus_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_consensus_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_tertiary_risk_created_by_user_employee_id` FOREIGN KEY (`tertiary_risk_created_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_tertiary_planning_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_planning_last_modified_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ADD CONSTRAINT `fk_supply_inventory_projection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ADD CONSTRAINT `fk_supply_drp_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> distribution (5 constraint(s)) =========
-- Requires: sustainability schema, distribution schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= sustainability --> logistics (1 constraint(s)) =========
-- Requires: sustainability schema, logistics schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= sustainability --> manufacturing (11 constraint(s)) =========
-- Requires: sustainability schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`water_consumption` ADD CONSTRAINT `fk_sustainability_water_consumption_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ADD CONSTRAINT `fk_sustainability_environmental_permit_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ADD CONSTRAINT `fk_sustainability_energy_certificate_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ADD CONSTRAINT `fk_sustainability_esg_audit_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

-- ========= sustainability --> procurement (10 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`waste_generation` ADD CONSTRAINT `fk_sustainability_waste_generation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_sourcing_supplier_id` FOREIGN KEY (`sourcing_supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ADD CONSTRAINT `fk_sustainability_supplier_esg_eval_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`energy_certificate` ADD CONSTRAINT `fk_sustainability_energy_certificate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ADD CONSTRAINT `fk_sustainability_deforestation_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_audit` ADD CONSTRAINT `fk_sustainability_esg_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= sustainability --> product (5 constraint(s)) =========
-- Requires: sustainability schema, product schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`packaging_profile` ADD CONSTRAINT `fk_sustainability_packaging_profile_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment` ADD CONSTRAINT `fk_sustainability_deforestation_assessment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);

-- ========= sustainability --> quality (1 constraint(s)) =========
-- Requires: sustainability schema, quality schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);

-- ========= sustainability --> regulatory (3 constraint(s)) =========
-- Requires: sustainability schema, regulatory schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ADD CONSTRAINT `fk_sustainability_esg_commitment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ADD CONSTRAINT `fk_sustainability_environmental_permit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_surveillance_event_id` FOREIGN KEY (`surveillance_event_id`) REFERENCES `vibe_consumer_goods_v1`.`regulatory`.`surveillance_event`(`surveillance_event_id`);

-- ========= sustainability --> research (1 constraint(s)) =========
-- Requires: sustainability schema, research schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification` ADD CONSTRAINT `fk_sustainability_sourcing_certification_raw_material_spec_id` FOREIGN KEY (`raw_material_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`research`.`raw_material_spec`(`raw_material_spec_id`);

-- ========= sustainability --> shared (1 constraint(s)) =========
-- Requires: sustainability schema, shared schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= sustainability --> supply (1 constraint(s)) =========
-- Requires: sustainability schema, supply schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= sustainability --> workforce (12 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ADD CONSTRAINT `fk_sustainability_esg_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`esg_commitment` ADD CONSTRAINT `fk_sustainability_esg_commitment_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_permit` ADD CONSTRAINT `fk_sustainability_environmental_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`circular_initiative` ADD CONSTRAINT `fk_sustainability_circular_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ADD CONSTRAINT `fk_sustainability_supplier_esg_eval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval` ADD CONSTRAINT `fk_sustainability_supplier_esg_eval_supplier_evaluator_employee_id` FOREIGN KEY (`supplier_evaluator_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`social_impact_program` ADD CONSTRAINT `fk_sustainability_social_impact_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`commitment_progress` ADD CONSTRAINT `fk_sustainability_commitment_progress_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity` ADD CONSTRAINT `fk_sustainability_supply_chain_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment` ADD CONSTRAINT `fk_sustainability_materiality_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= workforce --> finance (1 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_consumer_goods_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> manufacturing (1 constraint(s)) =========
-- Requires: workforce schema, manufacturing schema
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);

