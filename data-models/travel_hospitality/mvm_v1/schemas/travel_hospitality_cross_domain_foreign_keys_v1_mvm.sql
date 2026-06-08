-- Cross-Domain Foreign Keys for Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:14
-- Total cross-domain FK constraints: 1134
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: channel, event, experience, finance, fnb, guest, housekeeping, inventory, loyalty, marketing, property, reservation, revenue, spa

-- ========= channel --> event (1 constraint(s)) =========
-- Requires: channel schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_event_group_block_id` FOREIGN KEY (`event_group_block_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_group_block`(`event_group_block_id`);

-- ========= channel --> finance (12 constraint(s)) =========
-- Requires: channel schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);

-- ========= channel --> guest (7 constraint(s)) =========
-- Requires: channel schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= channel --> inventory (7 constraint(s)) =========
-- Requires: channel schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_allotment_id` FOREIGN KEY (`allotment_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`allotment`(`allotment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`rate_parity_audit` ADD CONSTRAINT `fk_channel_rate_parity_audit_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= channel --> loyalty (1 constraint(s)) =========
-- Requires: channel schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);

-- ========= channel --> marketing (8 constraint(s)) =========
-- Requires: channel schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`ota_partner` ADD CONSTRAINT `fk_channel_ota_partner_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`rate_parity_audit` ADD CONSTRAINT `fk_channel_rate_parity_audit_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);

-- ========= channel --> property (11 constraint(s)) =========
-- Requires: channel schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`rate_parity_audit` ADD CONSTRAINT `fk_channel_rate_parity_audit_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `travel_hospitality_ecm`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= channel --> reservation (2 constraint(s)) =========
-- Requires: channel schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= channel --> revenue (14 constraint(s)) =========
-- Requires: channel schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`booking_source` ADD CONSTRAINT `fk_channel_booking_source_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`strategy`(`strategy_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`rate_parity_audit` ADD CONSTRAINT `fk_channel_rate_parity_audit_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_negotiated_rate_id` FOREIGN KEY (`negotiated_rate_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`negotiated_rate`(`negotiated_rate_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`strategy`(`strategy_id`);

-- ========= event --> channel (8 constraint(s)) =========
-- Requires: event schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= event --> experience (6 constraint(s)) =========
-- Requires: event schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_amenity_fulfillment_id` FOREIGN KEY (`amenity_fulfillment_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`amenity_fulfillment`(`amenity_fulfillment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_experience_special_request_id` FOREIGN KEY (`experience_special_request_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`experience_special_request`(`experience_special_request_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);

-- ========= event --> finance (16 constraint(s)) =========
-- Requires: event schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_tax_posting_id` FOREIGN KEY (`tax_posting_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`tax_posting`(`tax_posting_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_tax_posting_id` FOREIGN KEY (`tax_posting_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`tax_posting`(`tax_posting_id`);

-- ========= event --> fnb (7 constraint(s)) =========
-- Requires: event schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_banquet_menu_package_id` FOREIGN KEY (`banquet_menu_package_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_menu_package`(`banquet_menu_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_banquet_menu_package_id` FOREIGN KEY (`banquet_menu_package_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_menu_package`(`banquet_menu_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= event --> guest (2 constraint(s)) =========
-- Requires: event schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);

-- ========= event --> inventory (1 constraint(s)) =========
-- Requires: event schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= event --> loyalty (8 constraint(s)) =========
-- Requires: event schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`account` ADD CONSTRAINT `fk_event_account_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);

-- ========= event --> marketing (15 constraint(s)) =========
-- Requires: event schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`account` ADD CONSTRAINT `fk_event_account_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_survey_program_id` FOREIGN KEY (`survey_program_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`survey_program`(`survey_program_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`content_asset`(`content_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_offer_redemption_id` FOREIGN KEY (`offer_redemption_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`offer_redemption`(`offer_redemption_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_survey_response_id` FOREIGN KEY (`survey_response_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`survey_response`(`survey_response_id`);

-- ========= event --> property (20 constraint(s)) =========
-- Requires: event schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`account` ADD CONSTRAINT `fk_event_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= event --> reservation (6 constraint(s)) =========
-- Requires: event schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= event --> revenue (1 constraint(s)) =========
-- Requires: event schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= event --> spa (7 constraint(s)) =========
-- Requires: event schema, spa schema
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);

-- ========= experience --> channel (9 constraint(s)) =========
-- Requires: experience schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`nps_survey` ADD CONSTRAINT `fk_experience_nps_survey_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`touchpoint` ADD CONSTRAINT `fk_experience_touchpoint_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= experience --> event (2 constraint(s)) =========
-- Requires: experience schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `travel_hospitality_ecm`.`event`.`beo`(`beo_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);

-- ========= experience --> finance (6 constraint(s)) =========
-- Requires: experience schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= experience --> fnb (16 constraint(s)) =========
-- Requires: experience schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_room_service_order_id` FOREIGN KEY (`room_service_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`room_service_order`(`room_service_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_void_transaction_id` FOREIGN KEY (`void_transaction_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`void_transaction`(`void_transaction_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`discount`(`discount_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_room_service_order_id` FOREIGN KEY (`room_service_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`room_service_order`(`room_service_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_room_service_order_id` FOREIGN KEY (`room_service_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`room_service_order`(`room_service_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= experience --> guest (18 constraint(s)) =========
-- Requires: experience schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`nps_survey` ADD CONSTRAINT `fk_experience_nps_survey_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`program` ADD CONSTRAINT `fk_experience_program_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`touchpoint` ADD CONSTRAINT `fk_experience_touchpoint_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`survey_template` ADD CONSTRAINT `fk_experience_survey_template_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);

-- ========= experience --> housekeeping (2 constraint(s)) =========
-- Requires: experience schema, housekeeping schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);

-- ========= experience --> inventory (13 constraint(s)) =========
-- Requires: experience schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);

-- ========= experience --> loyalty (8 constraint(s)) =========
-- Requires: experience schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_reward_catalog_id` FOREIGN KEY (`reward_catalog_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`reward_catalog`(`reward_catalog_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);

-- ========= experience --> property (29 constraint(s)) =========
-- Requires: experience schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);

-- ========= experience --> reservation (10 constraint(s)) =========
-- Requires: experience schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_cancellation_id` FOREIGN KEY (`cancellation_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation`(`cancellation_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_reservation_special_request_id` FOREIGN KEY (`reservation_special_request_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_special_request`(`reservation_special_request_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_reservation_special_request_id` FOREIGN KEY (`reservation_special_request_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_special_request`(`reservation_special_request_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_booking_package_id` FOREIGN KEY (`booking_package_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`booking_package`(`booking_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);

-- ========= experience --> revenue (8 constraint(s)) =========
-- Requires: experience schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`nps_survey` ADD CONSTRAINT `fk_experience_nps_survey_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`program` ADD CONSTRAINT `fk_experience_program_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_competitive_set_id` FOREIGN KEY (`competitive_set_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`competitive_set`(`competitive_set_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`experience`.`survey_template` ADD CONSTRAINT `fk_experience_survey_template_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= finance --> channel (1 constraint(s)) =========
-- Requires: finance schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`ota_partner`(`ota_partner_id`);

-- ========= finance --> experience (1 constraint(s)) =========
-- Requires: finance schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);

-- ========= finance --> fnb (13 constraint(s)) =========
-- Requires: finance schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`discount`(`discount_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_pos_check_line_id` FOREIGN KEY (`pos_check_line_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check_line`(`pos_check_line_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_room_service_order_id` FOREIGN KEY (`room_service_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`room_service_order`(`room_service_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_void_transaction_id` FOREIGN KEY (`void_transaction_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`void_transaction`(`void_transaction_id`);

-- ========= finance --> guest (7 constraint(s)) =========
-- Requires: finance schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);

-- ========= finance --> marketing (4 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= finance --> property (28 constraint(s)) =========
-- Requires: finance schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `travel_hospitality_ecm`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `travel_hospitality_ecm`.`property`.`certification`(`certification_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `travel_hospitality_ecm`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `travel_hospitality_ecm`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `travel_hospitality_ecm`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= finance --> reservation (4 constraint(s)) =========
-- Requires: finance schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_booking_package_id` FOREIGN KEY (`booking_package_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`booking_package`(`booking_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);

-- ========= fnb --> channel (3 constraint(s)) =========
-- Requires: fnb schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);

-- ========= fnb --> event (3 constraint(s)) =========
-- Requires: fnb schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `travel_hospitality_ecm`.`event`.`beo`(`beo_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);

-- ========= fnb --> finance (16 constraint(s)) =========
-- Requires: fnb schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);

-- ========= fnb --> guest (8 constraint(s)) =========
-- Requires: fnb schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);

-- ========= fnb --> inventory (3 constraint(s)) =========
-- Requires: fnb schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_block`(`room_block_id`);

-- ========= fnb --> loyalty (5 constraint(s)) =========
-- Requires: fnb schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= fnb --> marketing (10 constraint(s)) =========
-- Requires: fnb schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);

-- ========= fnb --> property (9 constraint(s)) =========
-- Requires: fnb schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`revenue_center` ADD CONSTRAINT `fk_fnb_revenue_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= fnb --> reservation (3 constraint(s)) =========
-- Requires: fnb schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);

-- ========= guest --> channel (4 constraint(s)) =========
-- Requires: guest schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);

-- ========= guest --> event (3 constraint(s)) =========
-- Requires: guest schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `travel_hospitality_ecm`.`event`.`account`(`account_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);

-- ========= guest --> fnb (2 constraint(s)) =========
-- Requires: guest schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= guest --> inventory (5 constraint(s)) =========
-- Requires: guest schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);

-- ========= guest --> loyalty (8 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= guest --> marketing (4 constraint(s)) =========
-- Requires: guest schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);

-- ========= guest --> property (9 constraint(s)) =========
-- Requires: guest schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= guest --> reservation (6 constraint(s)) =========
-- Requires: guest schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= guest --> revenue (4 constraint(s)) =========
-- Requires: guest schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= guest --> spa (1 constraint(s)) =========
-- Requires: guest schema, spa schema
ALTER TABLE `travel_hospitality_ecm`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);

-- ========= housekeeping --> event (13 constraint(s)) =========
-- Requires: housekeeping schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `travel_hospitality_ecm`.`event`.`beo`(`beo_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_space_allocation_id` FOREIGN KEY (`space_allocation_id`) REFERENCES `travel_hospitality_ecm`.`event`.`space_allocation`(`space_allocation_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `travel_hospitality_ecm`.`event`.`beo`(`beo_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_space_allocation_id` FOREIGN KEY (`space_allocation_id`) REFERENCES `travel_hospitality_ecm`.`event`.`space_allocation`(`space_allocation_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `travel_hospitality_ecm`.`event`.`beo`(`beo_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `travel_hospitality_ecm`.`event`.`beo`(`beo_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);

-- ========= housekeeping --> experience (13 constraint(s)) =========
-- Requires: housekeeping schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_amenity_fulfillment_id` FOREIGN KEY (`amenity_fulfillment_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`amenity_fulfillment`(`amenity_fulfillment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_experience_special_request_id` FOREIGN KEY (`experience_special_request_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`experience_special_request`(`experience_special_request_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_amenity_fulfillment_id` FOREIGN KEY (`amenity_fulfillment_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`amenity_fulfillment`(`amenity_fulfillment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_amenity_fulfillment_id` FOREIGN KEY (`amenity_fulfillment_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`amenity_fulfillment`(`amenity_fulfillment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_experience_special_request_id` FOREIGN KEY (`experience_special_request_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`experience_special_request`(`experience_special_request_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);

-- ========= housekeeping --> finance (11 constraint(s)) =========
-- Requires: housekeeping schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= housekeeping --> fnb (8 constraint(s)) =========
-- Requires: housekeeping schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_room_service_order_id` FOREIGN KEY (`room_service_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`room_service_order`(`room_service_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= housekeeping --> guest (11 constraint(s)) =========
-- Requires: housekeeping schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_note_id` FOREIGN KEY (`note_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`note`(`note_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`vip_designation`(`vip_designation_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`preference`(`preference_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`vip_designation`(`vip_designation_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_identity_document_id` FOREIGN KEY (`identity_document_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`identity_document`(`identity_document_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);

-- ========= housekeeping --> inventory (11 constraint(s)) =========
-- Requires: housekeeping schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_out_of_order_id` FOREIGN KEY (`out_of_order_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`out_of_order`(`out_of_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);

-- ========= housekeeping --> loyalty (1 constraint(s)) =========
-- Requires: housekeeping schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ADD CONSTRAINT `fk_housekeeping_cleaning_standard_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= housekeeping --> marketing (1 constraint(s)) =========
-- Requires: housekeeping schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ADD CONSTRAINT `fk_housekeeping_cleaning_standard_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= housekeeping --> property (13 constraint(s)) =========
-- Requires: housekeeping schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= housekeeping --> reservation (8 constraint(s)) =========
-- Requires: housekeeping schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_reservation_special_request_id` FOREIGN KEY (`reservation_special_request_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_special_request`(`reservation_special_request_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= housekeeping --> revenue (4 constraint(s)) =========
-- Requires: housekeeping schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`strategy`(`strategy_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ADD CONSTRAINT `fk_housekeeping_cleaning_standard_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= housekeeping --> spa (12 constraint(s)) =========
-- Requires: housekeeping schema, spa schema
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);

-- ========= inventory --> channel (5 constraint(s)) =========
-- Requires: inventory schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= inventory --> event (3 constraint(s)) =========
-- Requires: inventory schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_group_block_id` FOREIGN KEY (`event_group_block_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_group_block`(`event_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_event_group_block_id` FOREIGN KEY (`event_group_block_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_group_block`(`event_group_block_id`);

-- ========= inventory --> experience (2 constraint(s)) =========
-- Requires: inventory schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);

-- ========= inventory --> finance (9 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= inventory --> fnb (1 constraint(s)) =========
-- Requires: inventory schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`inventory_item`(`inventory_item_id`);

-- ========= inventory --> guest (4 constraint(s)) =========
-- Requires: inventory schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= inventory --> housekeeping (1 constraint(s)) =========
-- Requires: inventory schema, housekeeping schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);

-- ========= inventory --> loyalty (5 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= inventory --> marketing (10 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= inventory --> property (14 constraint(s)) =========
-- Requires: inventory schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= inventory --> reservation (1 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= inventory --> revenue (18 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`strategy`(`strategy_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_group_evaluation_id` FOREIGN KEY (`group_evaluation_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`group_evaluation`(`group_evaluation_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_negotiated_rate_id` FOREIGN KEY (`negotiated_rate_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`negotiated_rate`(`negotiated_rate_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_group_evaluation_id` FOREIGN KEY (`group_evaluation_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`group_evaluation`(`group_evaluation_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> channel (8 constraint(s)) =========
-- Requires: loyalty schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`enrollment` ADD CONSTRAINT `fk_loyalty_enrollment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= loyalty --> event (5 constraint(s)) =========
-- Requires: loyalty schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);

-- ========= loyalty --> experience (5 constraint(s)) =========
-- Requires: loyalty schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_guest_experience_enrollment_id` FOREIGN KEY (`guest_experience_enrollment_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment`(`guest_experience_enrollment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_guest_experience_enrollment_id` FOREIGN KEY (`guest_experience_enrollment_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_experience_enrollment`(`guest_experience_enrollment_id`);

-- ========= loyalty --> finance (10 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);

-- ========= loyalty --> fnb (7 constraint(s)) =========
-- Requires: loyalty schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= loyalty --> guest (2 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_profile_id` FOREIGN KEY (`member_profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);

-- ========= loyalty --> inventory (1 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= loyalty --> marketing (13 constraint(s)) =========
-- Requires: loyalty schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`enrollment` ADD CONSTRAINT `fk_loyalty_enrollment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`enrollment` ADD CONSTRAINT `fk_loyalty_enrollment_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);

-- ========= loyalty --> property (15 constraint(s)) =========
-- Requires: loyalty schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_property_id` FOREIGN KEY (`member_property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`enrollment` ADD CONSTRAINT `fk_loyalty_enrollment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);

-- ========= loyalty --> reservation (1 constraint(s)) =========
-- Requires: loyalty schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`enrollment` ADD CONSTRAINT `fk_loyalty_enrollment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= loyalty --> revenue (1 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> spa (9 constraint(s)) =========
-- Requires: loyalty schema, spa schema
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);

-- ========= marketing --> channel (4 constraint(s)) =========
-- Requires: marketing schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= marketing --> experience (16 constraint(s)) =========
-- Requires: marketing schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ADD CONSTRAINT `fk_marketing_campaign_offer_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`communication_template` ADD CONSTRAINT `fk_marketing_communication_template_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);

-- ========= marketing --> finance (7 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);

-- ========= marketing --> fnb (6 constraint(s)) =========
-- Requires: marketing schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= marketing --> guest (10 constraint(s)) =========
-- Requires: marketing schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);

-- ========= marketing --> housekeeping (1 constraint(s)) =========
-- Requires: marketing schema, housekeeping schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_lost_and_found_id` FOREIGN KEY (`lost_and_found_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`lost_and_found`(`lost_and_found_id`);

-- ========= marketing --> inventory (3 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= marketing --> loyalty (8 constraint(s)) =========
-- Requires: marketing schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`program_config`(`program_config_id`);

-- ========= marketing --> property (7 constraint(s)) =========
-- Requires: marketing schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= marketing --> reservation (7 constraint(s)) =========
-- Requires: marketing schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ADD CONSTRAINT `fk_marketing_campaign_offer_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_cancellation_id` FOREIGN KEY (`cancellation_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation`(`cancellation_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_travel_agent_id` FOREIGN KEY (`travel_agent_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`travel_agent`(`travel_agent_id`);

-- ========= marketing --> revenue (10 constraint(s)) =========
-- Requires: marketing schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_offer` ADD CONSTRAINT `fk_marketing_campaign_offer_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_segment` ADD CONSTRAINT `fk_marketing_guest_segment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= marketing --> spa (14 constraint(s)) =========
-- Requires: marketing schema, spa schema
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_treatment_menu_id` FOREIGN KEY (`treatment_menu_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);

-- ========= property --> channel (2 constraint(s)) =========
-- Requires: property schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_gds_connection_id` FOREIGN KEY (`gds_connection_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`gds_connection`(`gds_connection_id`);

-- ========= property --> finance (5 constraint(s)) =========
-- Requires: property schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`seasonal_calendar` ADD CONSTRAINT `fk_property_seasonal_calendar_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= property --> fnb (3 constraint(s)) =========
-- Requires: property schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= property --> housekeeping (4 constraint(s)) =========
-- Requires: property schema, housekeeping schema
ALTER TABLE `travel_hospitality_ecm`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);

-- ========= property --> marketing (4 constraint(s)) =========
-- Requires: property schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`property`.`property` ADD CONSTRAINT `fk_property_property_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`property`.`seasonal_calendar` ADD CONSTRAINT `fk_property_seasonal_calendar_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= reservation --> channel (6 constraint(s)) =========
-- Requires: reservation schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= reservation --> event (1 constraint(s)) =========
-- Requires: reservation schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);

-- ========= reservation --> finance (4 constraint(s)) =========
-- Requires: reservation schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);

-- ========= reservation --> fnb (1 constraint(s)) =========
-- Requires: reservation schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_banquet_menu_package_id` FOREIGN KEY (`banquet_menu_package_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_menu_package`(`banquet_menu_package_id`);

-- ========= reservation --> guest (5 constraint(s)) =========
-- Requires: reservation schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);

-- ========= reservation --> inventory (5 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= reservation --> loyalty (6 constraint(s)) =========
-- Requires: reservation schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_benefit_entitlement_id` FOREIGN KEY (`benefit_entitlement_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`benefit_entitlement`(`benefit_entitlement_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_reward_catalog_id` FOREIGN KEY (`reward_catalog_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`reward_catalog`(`reward_catalog_id`);

-- ========= reservation --> marketing (5 constraint(s)) =========
-- Requires: reservation schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);

-- ========= reservation --> property (11 constraint(s)) =========
-- Requires: reservation schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_outlet`(`property_outlet_id`);

-- ========= reservation --> revenue (10 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`strategy`(`strategy_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_group_evaluation_id` FOREIGN KEY (`group_evaluation_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`group_evaluation`(`group_evaluation_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= reservation --> spa (1 constraint(s)) =========
-- Requires: reservation schema, spa schema
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);

-- ========= revenue --> channel (11 constraint(s)) =========
-- Requires: revenue schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= revenue --> event (17 constraint(s)) =========
-- Requires: revenue schema, event schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_catering_menu_id` FOREIGN KEY (`catering_menu_id`) REFERENCES `travel_hospitality_ecm`.`event`.`catering_menu`(`catering_menu_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_event_group_block_id` FOREIGN KEY (`event_group_block_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_group_block`(`event_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_account_id` FOREIGN KEY (`account_id`) REFERENCES `travel_hospitality_ecm`.`event`.`account`(`account_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `travel_hospitality_ecm`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `travel_hospitality_ecm`.`event`.`inquiry`(`inquiry_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `travel_hospitality_ecm`.`event`.`proposal`(`proposal_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_event_group_block_id` FOREIGN KEY (`event_group_block_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_group_block`(`event_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `travel_hospitality_ecm`.`event`.`account`(`account_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_event_contract_id` FOREIGN KEY (`event_contract_id`) REFERENCES `travel_hospitality_ecm`.`event`.`event_contract`(`event_contract_id`);

-- ========= revenue --> experience (9 constraint(s)) =========
-- Requires: revenue schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_gss_score_id` FOREIGN KEY (`gss_score_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`gss_score`(`gss_score_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_gss_score_id` FOREIGN KEY (`gss_score_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`gss_score`(`gss_score_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_gss_score_id` FOREIGN KEY (`gss_score_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`gss_score`(`gss_score_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);

-- ========= revenue --> finance (22 constraint(s)) =========
-- Requires: revenue schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_hma_contract_id` FOREIGN KEY (`hma_contract_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_hma_contract_id` FOREIGN KEY (`hma_contract_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`hma_contract`(`hma_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= revenue --> fnb (12 constraint(s)) =========
-- Requires: revenue schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_banquet_menu_package_id` FOREIGN KEY (`banquet_menu_package_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`banquet_menu_package`(`banquet_menu_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`menu`(`menu_id`);

-- ========= revenue --> guest (2 constraint(s)) =========
-- Requires: revenue schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= revenue --> inventory (8 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= revenue --> loyalty (20 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= revenue --> marketing (12 constraint(s)) =========
-- Requires: revenue schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`competitive_set` ADD CONSTRAINT `fk_revenue_competitive_set_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= revenue --> property (27 constraint(s)) =========
-- Requires: revenue schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `travel_hospitality_ecm`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`competitive_set` ADD CONSTRAINT `fk_revenue_competitive_set_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`competitive_set` ADD CONSTRAINT `fk_revenue_competitive_set_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `travel_hospitality_ecm`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `travel_hospitality_ecm`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `travel_hospitality_ecm`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `travel_hospitality_ecm`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);

-- ========= revenue --> reservation (5 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_travel_agent_id` FOREIGN KEY (`travel_agent_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`travel_agent`(`travel_agent_id`);

-- ========= spa --> channel (6 constraint(s)) =========
-- Requires: spa schema, channel schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `travel_hospitality_ecm`.`channel`.`channel`(`channel_id`);

-- ========= spa --> experience (13 constraint(s)) =========
-- Requires: spa schema, experience schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_guest_interaction_id` FOREIGN KEY (`guest_interaction_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_interaction`(`guest_interaction_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_guest_interaction_id` FOREIGN KEY (`guest_interaction_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_interaction`(`guest_interaction_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_guest_interaction_id` FOREIGN KEY (`guest_interaction_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`guest_interaction`(`guest_interaction_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_program_id` FOREIGN KEY (`program_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`program`(`program_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_survey_template_id` FOREIGN KEY (`survey_template_id`) REFERENCES `travel_hospitality_ecm`.`experience`.`survey_template`(`survey_template_id`);

-- ========= spa --> finance (24 constraint(s)) =========
-- Requires: spa schema, finance schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `travel_hospitality_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= spa --> fnb (3 constraint(s)) =========
-- Requires: spa schema, fnb schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `travel_hospitality_ecm`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= spa --> guest (13 constraint(s)) =========
-- Requires: spa schema, guest schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_appointment_profile_id` FOREIGN KEY (`appointment_profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `travel_hospitality_ecm`.`guest`.`segment`(`segment_id`);

-- ========= spa --> housekeeping (1 constraint(s)) =========
-- Requires: spa schema, housekeeping schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);

-- ========= spa --> inventory (6 constraint(s)) =========
-- Requires: spa schema, inventory schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);

-- ========= spa --> loyalty (7 constraint(s)) =========
-- Requires: spa schema, loyalty schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_member_id` FOREIGN KEY (`member_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `travel_hospitality_ecm`.`loyalty`.`tier`(`tier_id`);

-- ========= spa --> marketing (18 constraint(s)) =========
-- Requires: spa schema, marketing schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`content_asset`(`content_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_attribution_event_id` FOREIGN KEY (`attribution_event_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`attribution_event`(`attribution_event_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`content_asset`(`content_asset_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_attribution_event_id` FOREIGN KEY (`attribution_event_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`attribution_event`(`attribution_event_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `travel_hospitality_ecm`.`marketing`.`guest_segment`(`guest_segment_id`);

-- ========= spa --> property (15 constraint(s)) =========
-- Requires: spa schema, property schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_property_id` FOREIGN KEY (`property_id`) REFERENCES `travel_hospitality_ecm`.`property`.`property`(`property_id`);

-- ========= spa --> reservation (8 constraint(s)) =========
-- Requires: spa schema, reservation schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= spa --> revenue (8 constraint(s)) =========
-- Requires: spa schema, revenue schema
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

