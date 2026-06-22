-- Cross-Domain Foreign Keys for Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-22 19:42:22
-- Total cross-domain FK constraints: 372
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: channel, event, fnb, guest, housekeeping, inventory, loyalty, property, reservation, revenue

-- ========= channel --> fnb (1 constraint(s)) =========
-- Requires: channel schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= channel --> guest (2 constraint(s)) =========
-- Requires: channel schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= channel --> inventory (4 constraint(s)) =========
-- Requires: channel schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_primary_channel_room_type_id` FOREIGN KEY (`primary_channel_room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= channel --> loyalty (1 constraint(s)) =========
-- Requires: channel schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= channel --> property (11 constraint(s)) =========
-- Requires: channel schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= channel --> reservation (1 constraint(s)) =========
-- Requires: channel schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= channel --> revenue (5 constraint(s)) =========
-- Requires: channel schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`inventory_allocation` ADD CONSTRAINT `fk_channel_inventory_allocation_rate_restriction_id` FOREIGN KEY (`rate_restriction_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction`(`rate_restriction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= event --> channel (5 constraint(s)) =========
-- Requires: event schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= event --> fnb (3 constraint(s)) =========
-- Requires: event schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= event --> guest (2 constraint(s)) =========
-- Requires: event schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= event --> loyalty (6 constraint(s)) =========
-- Requires: event schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= event --> property (17 constraint(s)) =========
-- Requires: event schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`space_allocation` ADD CONSTRAINT `fk_event_space_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= event --> reservation (2 constraint(s)) =========
-- Requires: event schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= fnb --> channel (1 constraint(s)) =========
-- Requires: fnb schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_booking`(`channel_booking_id`);

-- ========= fnb --> event (1 constraint(s)) =========
-- Requires: fnb schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);

-- ========= fnb --> guest (8 constraint(s)) =========
-- Requires: fnb schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`vip_designation`(`vip_designation_id`);

-- ========= fnb --> inventory (3 constraint(s)) =========
-- Requires: fnb schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);

-- ========= fnb --> loyalty (3 constraint(s)) =========
-- Requires: fnb schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= fnb --> property (9 constraint(s)) =========
-- Requires: fnb schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ADD CONSTRAINT `fk_fnb_revenue_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= fnb --> reservation (2 constraint(s)) =========
-- Requires: fnb schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= guest --> channel (4 constraint(s)) =========
-- Requires: guest schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);

-- ========= guest --> event (2 constraint(s)) =========
-- Requires: guest schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= guest --> inventory (8 constraint(s)) =========
-- Requires: guest schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= guest --> loyalty (3 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= guest --> property (10 constraint(s)) =========
-- Requires: guest schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= guest --> reservation (2 constraint(s)) =========
-- Requires: guest schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= guest --> revenue (7 constraint(s)) =========
-- Requires: guest schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= housekeeping --> event (7 constraint(s)) =========
-- Requires: housekeeping schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_beo_id` FOREIGN KEY (`beo_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`beo`(`beo_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= housekeeping --> fnb (7 constraint(s)) =========
-- Requires: housekeeping schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= housekeeping --> guest (14 constraint(s)) =========
-- Requires: housekeeping schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`preference`(`preference_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`vip_designation`(`vip_designation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`vip_designation`(`vip_designation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`vip_designation`(`vip_designation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= housekeeping --> inventory (8 constraint(s)) =========
-- Requires: housekeeping schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= housekeeping --> property (15 constraint(s)) =========
-- Requires: housekeeping schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= housekeeping --> reservation (4 constraint(s)) =========
-- Requires: housekeeping schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= housekeeping --> revenue (2 constraint(s)) =========
-- Requires: housekeeping schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);

-- ========= inventory --> channel (4 constraint(s)) =========
-- Requires: inventory schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= inventory --> event (1 constraint(s)) =========
-- Requires: inventory schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= inventory --> guest (3 constraint(s)) =========
-- Requires: inventory schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);

-- ========= inventory --> housekeeping (3 constraint(s)) =========
-- Requires: inventory schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`work_order`(`work_order_id`);

-- ========= inventory --> loyalty (3 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= inventory --> property (14 constraint(s)) =========
-- Requires: inventory schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= inventory --> reservation (1 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= inventory --> revenue (9 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> channel (6 constraint(s)) =========
-- Requires: loyalty schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= loyalty --> event (2 constraint(s)) =========
-- Requires: loyalty schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= loyalty --> fnb (4 constraint(s)) =========
-- Requires: loyalty schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= loyalty --> guest (4 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);

-- ========= loyalty --> inventory (3 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member_preference` ADD CONSTRAINT `fk_loyalty_member_preference_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= loyalty --> property (10 constraint(s)) =========
-- Requires: loyalty schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member_preference` ADD CONSTRAINT `fk_loyalty_member_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= loyalty --> reservation (1 constraint(s)) =========
-- Requires: loyalty schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= loyalty --> revenue (1 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= property --> fnb (3 constraint(s)) =========
-- Requires: property schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= reservation --> channel (9 constraint(s)) =========
-- Requires: reservation schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= reservation --> event (2 constraint(s)) =========
-- Requires: reservation schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= reservation --> fnb (2 constraint(s)) =========
-- Requires: reservation schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= reservation --> guest (11 constraint(s)) =========
-- Requires: reservation schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_vip_designation_id` FOREIGN KEY (`vip_designation_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`vip_designation`(`vip_designation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`preference`(`preference_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= reservation --> housekeeping (2 constraint(s)) =========
-- Requires: reservation schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);

-- ========= reservation --> inventory (4 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= reservation --> loyalty (1 constraint(s)) =========
-- Requires: reservation schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= reservation --> property (10 constraint(s)) =========
-- Requires: reservation schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`facility`(`facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`special_request` ADD CONSTRAINT `fk_reservation_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= reservation --> revenue (3 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= revenue --> channel (8 constraint(s)) =========
-- Requires: revenue schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_channel_rate_plan_id` FOREIGN KEY (`channel_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`(`channel_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= revenue --> event (6 constraint(s)) =========
-- Requires: revenue schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= revenue --> fnb (11 constraint(s)) =========
-- Requires: revenue schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= revenue --> guest (1 constraint(s)) =========
-- Requires: revenue schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);

-- ========= revenue --> inventory (7 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= revenue --> loyalty (12 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_redemption_rule_id` FOREIGN KEY (`redemption_rule_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule`(`redemption_rule_id`);

-- ========= revenue --> property (28 constraint(s)) =========
-- Requires: revenue schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`budget` ADD CONSTRAINT `fk_revenue_budget_seasonal_calendar_id` FOREIGN KEY (`seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate` ADD CONSTRAINT `fk_revenue_negotiated_rate_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= revenue --> reservation (3 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

