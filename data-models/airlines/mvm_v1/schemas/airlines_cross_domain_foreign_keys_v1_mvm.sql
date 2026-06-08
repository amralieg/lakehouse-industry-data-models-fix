-- Cross-Domain Foreign Keys for Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:32
-- Total cross-domain FK constraints: 925
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: airport, ancillary, cargo, crew, finance, fleet, flight, inventory, loyalty, maintenance, passenger, reservation, revenue, route, safety

-- ========= airport --> ancillary (3 constraint(s)) =========
-- Requires: airport schema, ancillary schema
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_baggage_allowance_id` FOREIGN KEY (`baggage_allowance_id`) REFERENCES `airlines_ecm`.`ancillary`.`baggage_allowance`(`baggage_allowance_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_seat_assignment_id` FOREIGN KEY (`seat_assignment_id`) REFERENCES `airlines_ecm`.`ancillary`.`seat_assignment`(`seat_assignment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_baggage_allowance_id` FOREIGN KEY (`baggage_allowance_id`) REFERENCES `airlines_ecm`.`ancillary`.`baggage_allowance`(`baggage_allowance_id`);

-- ========= airport --> crew (1 constraint(s)) =========
-- Requires: airport schema, crew schema
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= airport --> finance (14 constraint(s)) =========
-- Requires: airport schema, finance schema
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ADD CONSTRAINT `fk_airport_terminal_facility_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ADD CONSTRAINT `fk_airport_terminal_facility_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gate` ADD CONSTRAINT `fk_airport_gate_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station` ADD CONSTRAINT `fk_airport_station_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= airport --> fleet (4 constraint(s)) =========
-- Requires: airport schema, fleet schema
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= airport --> flight (14 constraint(s)) =========
-- Requires: airport schema, flight schema
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_turnaround_outbound_flight_leg_id` FOREIGN KEY (`turnaround_outbound_flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ADD CONSTRAINT `fk_airport_slot_utilization_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_booking_segment_id` FOREIGN KEY (`booking_segment_id`) REFERENCES `airlines_ecm`.`flight`.`booking_segment`(`booking_segment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_booking_segment_id` FOREIGN KEY (`booking_segment_id`) REFERENCES `airlines_ecm`.`flight`.`booking_segment`(`booking_segment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ADD CONSTRAINT `fk_airport_baggage_scan_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= airport --> inventory (4 constraint(s)) =========
-- Requires: airport schema, inventory schema
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);

-- ========= airport --> loyalty (3 constraint(s)) =========
-- Requires: airport schema, loyalty schema
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);

-- ========= airport --> passenger (4 constraint(s)) =========
-- Requires: airport schema, passenger schema
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= airport --> reservation (8 constraint(s)) =========
-- Requires: airport schema, reservation schema
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ADD CONSTRAINT `fk_airport_baggage_scan_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= airport --> route (5 constraint(s)) =========
-- Requires: airport schema, route schema
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_slot_allocation_id` FOREIGN KEY (`slot_allocation_id`) REFERENCES `airlines_ecm`.`route`.`slot_allocation`(`slot_allocation_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ADD CONSTRAINT `fk_airport_slot_utilization_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ADD CONSTRAINT `fk_airport_slot_utilization_slot_allocation_id` FOREIGN KEY (`slot_allocation_id`) REFERENCES `airlines_ecm`.`route`.`slot_allocation`(`slot_allocation_id`);

-- ========= airport --> safety (4 constraint(s)) =========
-- Requires: airport schema, safety schema
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= ancillary --> airport (6 constraint(s)) =========
-- Requires: ancillary schema, airport schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_terminal_facility_id` FOREIGN KEY (`terminal_facility_id`) REFERENCES `airlines_ecm`.`airport`.`terminal_facility`(`terminal_facility_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);

-- ========= ancillary --> finance (17 constraint(s)) =========
-- Requires: ancillary schema, finance schema
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= ancillary --> fleet (5 constraint(s)) =========
-- Requires: ancillary schema, fleet schema
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);

-- ========= ancillary --> flight (6 constraint(s)) =========
-- Requires: ancillary schema, flight schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= ancillary --> inventory (12 constraint(s)) =========
-- Requires: ancillary schema, inventory schema
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ADD CONSTRAINT `fk_ancillary_baggage_allowance_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);

-- ========= ancillary --> loyalty (6 constraint(s)) =========
-- Requires: ancillary schema, loyalty schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ADD CONSTRAINT `fk_ancillary_baggage_allowance_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= ancillary --> maintenance (2 constraint(s)) =========
-- Requires: ancillary schema, maintenance schema
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_mel_deferral_id` FOREIGN KEY (`mel_deferral_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_deferral`(`mel_deferral_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);

-- ========= ancillary --> passenger (4 constraint(s)) =========
-- Requires: ancillary schema, passenger schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= ancillary --> reservation (17 constraint(s)) =========
-- Requires: ancillary schema, reservation schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= ancillary --> revenue (3 constraint(s)) =========
-- Requires: ancillary schema, revenue schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);

-- ========= ancillary --> route (12 constraint(s)) =========
-- Requires: ancillary schema, route schema
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ADD CONSTRAINT `fk_ancillary_baggage_allowance_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `airlines_ecm`.`route`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);

-- ========= cargo --> airport (23 constraint(s)) =========
-- Requires: cargo schema, airport schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ADD CONSTRAINT `fk_cargo_uld_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= cargo --> crew (2 constraint(s)) =========
-- Requires: cargo schema, crew schema
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `airlines_ecm`.`crew`.`qualification`(`qualification_id`);

-- ========= cargo --> finance (23 constraint(s)) =========
-- Requires: cargo schema, finance schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ADD CONSTRAINT `fk_cargo_uld_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ADD CONSTRAINT `fk_cargo_uld_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_tax_transaction_id` FOREIGN KEY (`tax_transaction_id`) REFERENCES `airlines_ecm`.`finance`.`tax_transaction`(`tax_transaction_id`);

-- ========= cargo --> fleet (6 constraint(s)) =========
-- Requires: cargo schema, fleet schema
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_aircraft_registration_id` FOREIGN KEY (`aircraft_registration_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_registration`(`aircraft_registration_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= cargo --> flight (9 constraint(s)) =========
-- Requires: cargo schema, flight schema
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= cargo --> inventory (3 constraint(s)) =========
-- Requires: cargo schema, inventory schema
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= cargo --> maintenance (1 constraint(s)) =========
-- Requires: cargo schema, maintenance schema
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= cargo --> revenue (2 constraint(s)) =========
-- Requires: cargo schema, revenue schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_account`(`corporate_account_id`);

-- ========= cargo --> route (15 constraint(s)) =========
-- Requires: cargo schema, route schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`booking` ADD CONSTRAINT `fk_cargo_booking_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);

-- ========= cargo --> safety (7 constraint(s)) =========
-- Requires: cargo schema, safety schema
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= crew --> airport (9 constraint(s)) =========
-- Requires: crew schema, airport schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`base` ADD CONSTRAINT `fk_crew_base_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= crew --> finance (13 constraint(s)) =========
-- Requires: crew schema, finance schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`base` ADD CONSTRAINT `fk_crew_base_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ADD CONSTRAINT `fk_crew_medical_certificate_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`crew`.`licence` ADD CONSTRAINT `fk_crew_licence_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= crew --> fleet (7 constraint(s)) =========
-- Requires: crew schema, fleet schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= crew --> flight (3 constraint(s)) =========
-- Requires: crew schema, flight schema
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= crew --> inventory (3 constraint(s)) =========
-- Requires: crew schema, inventory schema
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= crew --> loyalty (1 constraint(s)) =========
-- Requires: crew schema, loyalty schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= crew --> route (9 constraint(s)) =========
-- Requires: crew schema, route schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`crew`.`base` ADD CONSTRAINT `fk_crew_base_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_block_time_standard_id` FOREIGN KEY (`block_time_standard_id`) REFERENCES `airlines_ecm`.`route`.`block_time_standard`(`block_time_standard_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `airlines_ecm`.`route`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_seasonal_schedule_id` FOREIGN KEY (`seasonal_schedule_id`) REFERENCES `airlines_ecm`.`route`.`seasonal_schedule`(`seasonal_schedule_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= crew --> safety (8 constraint(s)) =========
-- Requires: crew schema, safety schema
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ADD CONSTRAINT `fk_crew_ftl_legality_check_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= finance --> airport (1 constraint(s)) =========
-- Requires: finance schema, airport schema
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);

-- ========= finance --> crew (1 constraint(s)) =========
-- Requires: finance schema, crew schema
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);

-- ========= finance --> fleet (2 constraint(s)) =========
-- Requires: finance schema, fleet schema
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_fleet_order_id` FOREIGN KEY (`fleet_order_id`) REFERENCES `airlines_ecm`.`fleet`.`fleet_order`(`fleet_order_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= finance --> flight (3 constraint(s)) =========
-- Requires: finance schema, flight schema
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_fuel_uplift_id` FOREIGN KEY (`fuel_uplift_id`) REFERENCES `airlines_ecm`.`flight`.`fuel_uplift`(`fuel_uplift_id`);
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ADD CONSTRAINT `fk_finance_interline_billing_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= finance --> passenger (1 constraint(s)) =========
-- Requires: finance schema, passenger schema
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= finance --> reservation (3 constraint(s)) =========
-- Requires: finance schema, reservation schema
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_booking_payment_id` FOREIGN KEY (`booking_payment_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_payment`(`booking_payment_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_refund_transaction_id` FOREIGN KEY (`refund_transaction_id`) REFERENCES `airlines_ecm`.`reservation`.`refund_transaction`(`refund_transaction_id`);

-- ========= finance --> route (1 constraint(s)) =========
-- Requires: finance schema, route schema
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ADD CONSTRAINT `fk_finance_interline_billing_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `airlines_ecm`.`route`.`interline_agreement`(`interline_agreement_id`);

-- ========= fleet --> airport (5 constraint(s)) =========
-- Requires: fleet schema, airport schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ADD CONSTRAINT `fk_fleet_aircraft_utilization_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= fleet --> finance (13 constraint(s)) =========
-- Requires: fleet schema, finance schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ADD CONSTRAINT `fk_fleet_aircraft_utilization_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ADD CONSTRAINT `fk_fleet_aircraft_registration_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`lessor` ADD CONSTRAINT `fk_fleet_lessor_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= fleet --> route (1 constraint(s)) =========
-- Requires: fleet schema, route schema
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= flight --> airport (9 constraint(s)) =========
-- Requires: flight schema, airport schema
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `airlines_ecm`.`airport`.`slot`(`slot_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ADD CONSTRAINT `fk_flight_irop_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ADD CONSTRAINT `fk_flight_weight_balance_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);

-- ========= flight --> ancillary (1 constraint(s)) =========
-- Requires: flight schema, ancillary schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_seat_assignment_id` FOREIGN KEY (`seat_assignment_id`) REFERENCES `airlines_ecm`.`ancillary`.`seat_assignment`(`seat_assignment_id`);

-- ========= flight --> cargo (1 constraint(s)) =========
-- Requires: flight schema, cargo schema
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ADD CONSTRAINT `fk_flight_weight_balance_load_plan_id` FOREIGN KEY (`load_plan_id`) REFERENCES `airlines_ecm`.`cargo`.`load_plan`(`load_plan_id`);

-- ========= flight --> crew (5 constraint(s)) =========
-- Requires: flight schema, crew schema
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_absence_id` FOREIGN KEY (`absence_id`) REFERENCES `airlines_ecm`.`crew`.`absence`(`absence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_absence_id` FOREIGN KEY (`absence_id`) REFERENCES `airlines_ecm`.`crew`.`absence`(`absence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`weight_balance` ADD CONSTRAINT `fk_flight_weight_balance_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= flight --> finance (9 constraint(s)) =========
-- Requires: flight schema, finance schema
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ADD CONSTRAINT `fk_flight_irop_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= flight --> fleet (9 constraint(s)) =========
-- Requires: flight schema, fleet schema
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_etops_authorization_id` FOREIGN KEY (`etops_authorization_id`) REFERENCES `airlines_ecm`.`fleet`.`etops_authorization`(`etops_authorization_id`);
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);

-- ========= flight --> inventory (2 constraint(s)) =========
-- Requires: flight schema, inventory schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_seat_availability_id` FOREIGN KEY (`seat_availability_id`) REFERENCES `airlines_ecm`.`inventory`.`seat_availability`(`seat_availability_id`);

-- ========= flight --> loyalty (1 constraint(s)) =========
-- Requires: flight schema, loyalty schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= flight --> maintenance (5 constraint(s)) =========
-- Requires: flight schema, maintenance schema
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_release_id` FOREIGN KEY (`release_id`) REFERENCES `airlines_ecm`.`maintenance`.`release`(`release_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ADD CONSTRAINT `fk_flight_irop_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= flight --> passenger (2 constraint(s)) =========
-- Requires: flight schema, passenger schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_minor_guardian_id` FOREIGN KEY (`minor_guardian_id`) REFERENCES `airlines_ecm`.`passenger`.`minor_guardian`(`minor_guardian_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= flight --> reservation (4 constraint(s)) =========
-- Requires: flight schema, reservation schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= flight --> revenue (3 constraint(s)) =========
-- Requires: flight schema, revenue schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_pricing_record_id` FOREIGN KEY (`pricing_record_id`) REFERENCES `airlines_ecm`.`revenue`.`pricing_record`(`pricing_record_id`);
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);

-- ========= flight --> route (10 constraint(s)) =========
-- Requires: flight schema, route schema
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `airlines_ecm`.`route`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_codeshare_agreement_id` FOREIGN KEY (`codeshare_agreement_id`) REFERENCES `airlines_ecm`.`route`.`codeshare_agreement`(`codeshare_agreement_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_block_time_standard_id` FOREIGN KEY (`block_time_standard_id`) REFERENCES `airlines_ecm`.`route`.`block_time_standard`(`block_time_standard_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ADD CONSTRAINT `fk_flight_irop_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= flight --> safety (6 constraint(s)) =========
-- Requires: flight schema, safety schema
ALTER TABLE `airlines_ecm`.`flight`.`plan` ADD CONSTRAINT `fk_flight_plan_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ADD CONSTRAINT `fk_flight_irop_event_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`flight`.`irop_event` ADD CONSTRAINT `fk_flight_irop_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= inventory --> airport (3 constraint(s)) =========
-- Requires: inventory schema, airport schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_terminal_facility_id` FOREIGN KEY (`terminal_facility_id`) REFERENCES `airlines_ecm`.`airport`.`terminal_facility`(`terminal_facility_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= inventory --> finance (8 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`cabin_class` ADD CONSTRAINT `fk_inventory_cabin_class_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`cabin_class` ADD CONSTRAINT `fk_inventory_cabin_class_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`fare_class_bucket` ADD CONSTRAINT `fk_inventory_fare_class_bucket_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);

-- ========= inventory --> fleet (6 constraint(s)) =========
-- Requires: inventory schema, fleet schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= inventory --> flight (4 constraint(s)) =========
-- Requires: inventory schema, flight schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`seat_availability` ADD CONSTRAINT `fk_inventory_seat_availability_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= inventory --> maintenance (1 constraint(s)) =========
-- Requires: inventory schema, maintenance schema
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_release_id` FOREIGN KEY (`release_id`) REFERENCES `airlines_ecm`.`maintenance`.`release`(`release_id`);

-- ========= inventory --> passenger (1 constraint(s)) =========
-- Requires: inventory schema, passenger schema
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= inventory --> reservation (3 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= inventory --> revenue (5 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `airlines_ecm`.`inventory`.`fare_class_bucket` ADD CONSTRAINT `fk_inventory_fare_class_bucket_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_yield_parameter_id` FOREIGN KEY (`yield_parameter_id`) REFERENCES `airlines_ecm`.`revenue`.`yield_parameter`(`yield_parameter_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);

-- ========= inventory --> route (20 constraint(s)) =========
-- Requires: inventory schema, route schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `airlines_ecm`.`route`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_seasonal_schedule_id` FOREIGN KEY (`seasonal_schedule_id`) REFERENCES `airlines_ecm`.`route`.`seasonal_schedule`(`seasonal_schedule_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`fare_class_bucket` ADD CONSTRAINT `fk_inventory_fare_class_bucket_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`fare_class_bucket` ADD CONSTRAINT `fk_inventory_fare_class_bucket_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_codeshare_agreement_id` FOREIGN KEY (`codeshare_agreement_id`) REFERENCES `airlines_ecm`.`route`.`codeshare_agreement`(`codeshare_agreement_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_partnership_id` FOREIGN KEY (`partnership_id`) REFERENCES `airlines_ecm`.`route`.`partnership`(`partnership_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_block_time_standard_id` FOREIGN KEY (`block_time_standard_id`) REFERENCES `airlines_ecm`.`route`.`block_time_standard`(`block_time_standard_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);

-- ========= loyalty --> airport (2 constraint(s)) =========
-- Requires: loyalty schema, airport schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= loyalty --> ancillary (4 constraint(s)) =========
-- Requires: loyalty schema, ancillary schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `airlines_ecm`.`ancillary`.`order_item`(`order_item_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_upgrade_offer_id` FOREIGN KEY (`upgrade_offer_id`) REFERENCES `airlines_ecm`.`ancillary`.`upgrade_offer`(`upgrade_offer_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_upgrade_transaction_id` FOREIGN KEY (`upgrade_transaction_id`) REFERENCES `airlines_ecm`.`ancillary`.`upgrade_transaction`(`upgrade_transaction_id`);

-- ========= loyalty --> finance (10 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ADD CONSTRAINT `fk_loyalty_ffp_member_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ADD CONSTRAINT `fk_loyalty_partner_program_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ADD CONSTRAINT `fk_loyalty_partner_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= loyalty --> fleet (3 constraint(s)) =========
-- Requires: loyalty schema, fleet schema
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);

-- ========= loyalty --> flight (7 constraint(s)) =========
-- Requires: loyalty schema, flight schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_booking_segment_id` FOREIGN KEY (`booking_segment_id`) REFERENCES `airlines_ecm`.`flight`.`booking_segment`(`booking_segment_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_booking_segment_id` FOREIGN KEY (`booking_segment_id`) REFERENCES `airlines_ecm`.`flight`.`booking_segment`(`booking_segment_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= loyalty --> inventory (10 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= loyalty --> reservation (3 constraint(s)) =========
-- Requires: loyalty schema, reservation schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= loyalty --> revenue (6 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);

-- ========= loyalty --> route (5 constraint(s)) =========
-- Requires: loyalty schema, route schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ADD CONSTRAINT `fk_loyalty_partner_program_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= maintenance --> airport (11 constraint(s)) =========
-- Requires: maintenance schema, airport schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= maintenance --> cargo (3 constraint(s)) =========
-- Requires: maintenance schema, cargo schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_uld_id` FOREIGN KEY (`uld_id`) REFERENCES `airlines_ecm`.`cargo`.`uld`(`uld_id`);

-- ========= maintenance --> crew (5 constraint(s)) =========
-- Requires: maintenance schema, crew schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= maintenance --> finance (16 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= maintenance --> fleet (15 constraint(s)) =========
-- Requires: maintenance schema, fleet schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_aircraft_lease_id` FOREIGN KEY (`aircraft_lease_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_lease`(`aircraft_lease_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ADD CONSTRAINT `fk_maintenance_mel_item_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= maintenance --> flight (5 constraint(s)) =========
-- Requires: maintenance schema, flight schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= maintenance --> route (3 constraint(s)) =========
-- Requires: maintenance schema, route schema
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= maintenance --> safety (25 constraint(s)) =========
-- Requires: maintenance schema, safety schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `airlines_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `airlines_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `airlines_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ADD CONSTRAINT `fk_maintenance_mel_item_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ADD CONSTRAINT `fk_maintenance_mel_item_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `airlines_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_report_id` FOREIGN KEY (`report_id`) REFERENCES `airlines_ecm`.`safety`.`report`(`report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);

-- ========= passenger --> airport (3 constraint(s)) =========
-- Requires: passenger schema, airport schema
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= passenger --> ancillary (3 constraint(s)) =========
-- Requires: passenger schema, ancillary schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_seat_product_id` FOREIGN KEY (`seat_product_id`) REFERENCES `airlines_ecm`.`ancillary`.`seat_product`(`seat_product_id`);

-- ========= passenger --> crew (3 constraint(s)) =========
-- Requires: passenger schema, crew schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`minor_guardian` ADD CONSTRAINT `fk_passenger_minor_guardian_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`minor_guardian` ADD CONSTRAINT `fk_passenger_minor_guardian_flight_leg_assignment_id` FOREIGN KEY (`flight_leg_assignment_id`) REFERENCES `airlines_ecm`.`crew`.`flight_leg_assignment`(`flight_leg_assignment_id`);

-- ========= passenger --> finance (2 constraint(s)) =========
-- Requires: passenger schema, finance schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`consent` ADD CONSTRAINT `fk_passenger_consent_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= passenger --> fleet (1 constraint(s)) =========
-- Requires: passenger schema, fleet schema
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= passenger --> flight (3 constraint(s)) =========
-- Requires: passenger schema, flight schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= passenger --> inventory (6 constraint(s)) =========
-- Requires: passenger schema, inventory schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`traveller_segment` ADD CONSTRAINT `fk_passenger_traveller_segment_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);

-- ========= passenger --> loyalty (7 constraint(s)) =========
-- Requires: passenger schema, loyalty schema
ALTER TABLE `airlines_ecm`.`passenger`.`profile` ADD CONSTRAINT `fk_passenger_profile_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_member_benefit_id` FOREIGN KEY (`member_benefit_id`) REFERENCES `airlines_ecm`.`loyalty`.`member_benefit`(`member_benefit_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`loyalty_linkage` ADD CONSTRAINT `fk_passenger_loyalty_linkage_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`loyalty_linkage` ADD CONSTRAINT `fk_passenger_loyalty_linkage_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`traveller_segment` ADD CONSTRAINT `fk_passenger_traveller_segment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`consent` ADD CONSTRAINT `fk_passenger_consent_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);

-- ========= passenger --> maintenance (2 constraint(s)) =========
-- Requires: passenger schema, maintenance schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);

-- ========= passenger --> reservation (5 constraint(s)) =========
-- Requires: passenger schema, reservation schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`minor_guardian` ADD CONSTRAINT `fk_passenger_minor_guardian_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_booking_passenger_id` FOREIGN KEY (`booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`booking_passenger`(`booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= passenger --> revenue (3 constraint(s)) =========
-- Requires: passenger schema, revenue schema
ALTER TABLE `airlines_ecm`.`passenger`.`minor_guardian` ADD CONSTRAINT `fk_passenger_minor_guardian_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);

-- ========= passenger --> route (6 constraint(s)) =========
-- Requires: passenger schema, route schema
ALTER TABLE `airlines_ecm`.`passenger`.`profile` ADD CONSTRAINT `fk_passenger_profile_city_pair_id` FOREIGN KEY (`city_pair_id`) REFERENCES `airlines_ecm`.`route`.`city_pair`(`city_pair_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`traveller_segment` ADD CONSTRAINT `fk_passenger_traveller_segment_city_pair_id` FOREIGN KEY (`city_pair_id`) REFERENCES `airlines_ecm`.`route`.`city_pair`(`city_pair_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);

-- ========= reservation --> airport (13 constraint(s)) =========
-- Requires: reservation schema, airport schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `airlines_ecm`.`airport`.`slot`(`slot_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `airlines_ecm`.`airport`.`gate`(`gate_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_baggage_item_id` FOREIGN KEY (`baggage_item_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_item`(`baggage_item_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_baggage_item_id` FOREIGN KEY (`baggage_item_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_item`(`baggage_item_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_baggage_irregularity_id` FOREIGN KEY (`baggage_irregularity_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_irregularity`(`baggage_irregularity_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= reservation --> ancillary (7 constraint(s)) =========
-- Requires: reservation schema, ancillary schema
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_seat_assignment_id` FOREIGN KEY (`seat_assignment_id`) REFERENCES `airlines_ecm`.`ancillary`.`seat_assignment`(`seat_assignment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_seat_assignment_id` FOREIGN KEY (`seat_assignment_id`) REFERENCES `airlines_ecm`.`ancillary`.`seat_assignment`(`seat_assignment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);

-- ========= reservation --> cargo (2 constraint(s)) =========
-- Requires: reservation schema, cargo schema
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `airlines_ecm`.`cargo`.`booking`(`booking_id`);

-- ========= reservation --> crew (2 constraint(s)) =========
-- Requires: reservation schema, crew schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_passenger` ADD CONSTRAINT `fk_reservation_booking_passenger_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= reservation --> finance (6 constraint(s)) =========
-- Requires: reservation schema, finance schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= reservation --> fleet (8 constraint(s)) =========
-- Requires: reservation schema, fleet schema
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_passenger` ADD CONSTRAINT `fk_reservation_booking_passenger_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);

-- ========= reservation --> flight (8 constraint(s)) =========
-- Requires: reservation schema, flight schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_cancellation_id` FOREIGN KEY (`cancellation_id`) REFERENCES `airlines_ecm`.`flight`.`cancellation`(`cancellation_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_cancellation_id` FOREIGN KEY (`cancellation_id`) REFERENCES `airlines_ecm`.`flight`.`cancellation`(`cancellation_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= reservation --> inventory (5 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `airlines_ecm`.`inventory`.`segment`(`segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);

-- ========= reservation --> loyalty (12 constraint(s)) =========
-- Requires: reservation schema, loyalty schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_award_inventory_id` FOREIGN KEY (`award_inventory_id`) REFERENCES `airlines_ecm`.`loyalty`.`award_inventory`(`award_inventory_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_passenger` ADD CONSTRAINT `fk_reservation_booking_passenger_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_passenger` ADD CONSTRAINT `fk_reservation_booking_passenger_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_upgrade_request_id` FOREIGN KEY (`upgrade_request_id`) REFERENCES `airlines_ecm`.`loyalty`.`upgrade_request`(`upgrade_request_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_mileage_accrual_id` FOREIGN KEY (`mileage_accrual_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_accrual`(`mileage_accrual_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);

-- ========= reservation --> passenger (9 constraint(s)) =========
-- Requires: reservation schema, passenger schema
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_passenger` ADD CONSTRAINT `fk_reservation_booking_passenger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_travel_identity_document_id` FOREIGN KEY (`travel_identity_document_id`) REFERENCES `airlines_ecm`.`passenger`.`travel_identity_document`(`travel_identity_document_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_travel_identity_document_id` FOREIGN KEY (`travel_identity_document_id`) REFERENCES `airlines_ecm`.`passenger`.`travel_identity_document`(`travel_identity_document_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= reservation --> revenue (23 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `airlines_ecm`.`revenue`.`refund`(`refund_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);

-- ========= reservation --> route (12 constraint(s)) =========
-- Requires: reservation schema, route schema
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_codeshare_agreement_id` FOREIGN KEY (`codeshare_agreement_id`) REFERENCES `airlines_ecm`.`route`.`codeshare_agreement`(`codeshare_agreement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `airlines_ecm`.`route`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= revenue --> airport (4 constraint(s)) =========
-- Requires: revenue schema, airport schema
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ADD CONSTRAINT `fk_revenue_tax_fee_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= revenue --> ancillary (8 constraint(s)) =========
-- Requires: revenue schema, ancillary schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ADD CONSTRAINT `fk_revenue_fare_class_baggage_allowance_id` FOREIGN KEY (`baggage_allowance_id`) REFERENCES `airlines_ecm`.`ancillary`.`baggage_allowance`(`baggage_allowance_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ADD CONSTRAINT `fk_revenue_fare_family_baggage_allowance_id` FOREIGN KEY (`baggage_allowance_id`) REFERENCES `airlines_ecm`.`ancillary`.`baggage_allowance`(`baggage_allowance_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `airlines_ecm`.`ancillary`.`order_item`(`order_item_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);

-- ========= revenue --> crew (2 constraint(s)) =========
-- Requires: revenue schema, crew schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= revenue --> finance (20 constraint(s)) =========
-- Requires: revenue schema, finance schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `airlines_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ADD CONSTRAINT `fk_revenue_corporate_account_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= revenue --> fleet (5 constraint(s)) =========
-- Requires: revenue schema, fleet schema
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ADD CONSTRAINT `fk_revenue_fare_family_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= revenue --> flight (3 constraint(s)) =========
-- Requires: revenue schema, flight schema
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_irop_event_id` FOREIGN KEY (`irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`irop_event`(`irop_event_id`);

-- ========= revenue --> inventory (13 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ADD CONSTRAINT `fk_revenue_fare_class_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ADD CONSTRAINT `fk_revenue_fare_family_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= revenue --> loyalty (3 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= revenue --> maintenance (5 constraint(s)) =========
-- Requires: revenue schema, maintenance schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_technical_log_id` FOREIGN KEY (`technical_log_id`) REFERENCES `airlines_ecm`.`maintenance`.`technical_log`(`technical_log_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_technical_log_id` FOREIGN KEY (`technical_log_id`) REFERENCES `airlines_ecm`.`maintenance`.`technical_log`(`technical_log_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= revenue --> passenger (6 constraint(s)) =========
-- Requires: revenue schema, passenger schema
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_travel_identity_document_id` FOREIGN KEY (`travel_identity_document_id`) REFERENCES `airlines_ecm`.`passenger`.`travel_identity_document`(`travel_identity_document_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= revenue --> reservation (9 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_fare_quote_id` FOREIGN KEY (`fare_quote_id`) REFERENCES `airlines_ecm`.`reservation`.`fare_quote`(`fare_quote_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= revenue --> route (18 constraint(s)) =========
-- Requires: revenue schema, route schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `airlines_ecm`.`route`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ADD CONSTRAINT `fk_revenue_fare_family_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);

-- ========= revenue --> safety (1 constraint(s)) =========
-- Requires: revenue schema, safety schema
ALTER TABLE `airlines_ecm`.`revenue`.`refund` ADD CONSTRAINT `fk_revenue_refund_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= route --> airport (7 constraint(s)) =========
-- Requires: route schema, airport schema
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ADD CONSTRAINT `fk_route_city_pair_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_terminal_facility_id` FOREIGN KEY (`terminal_facility_id`) REFERENCES `airlines_ecm`.`airport`.`terminal_facility`(`terminal_facility_id`);
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ADD CONSTRAINT `fk_route_slot_allocation_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= route --> finance (17 constraint(s)) =========
-- Requires: route schema, finance schema
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`schedule_season` ADD CONSTRAINT `fk_route_schedule_season_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`slot_allocation` ADD CONSTRAINT `fk_route_slot_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ADD CONSTRAINT `fk_route_interline_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`performance` ADD CONSTRAINT `fk_route_performance_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`route`.`performance` ADD CONSTRAINT `fk_route_performance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`performance` ADD CONSTRAINT `fk_route_performance_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`route`.`carrier` ADD CONSTRAINT `fk_route_carrier_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= route --> fleet (7 constraint(s)) =========
-- Requires: route schema, fleet schema
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);

-- ========= route --> safety (1 constraint(s)) =========
-- Requires: route schema, safety schema
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ADD CONSTRAINT `fk_route_interline_agreement_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= safety --> airport (4 constraint(s)) =========
-- Requires: safety schema, airport schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_ground_handler_id` FOREIGN KEY (`ground_handler_id`) REFERENCES `airlines_ecm`.`airport`.`ground_handler`(`ground_handler_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= safety --> ancillary (4 constraint(s)) =========
-- Requires: safety schema, ancillary schema
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);

-- ========= safety --> crew (3 constraint(s)) =========
-- Requires: safety schema, crew schema
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= safety --> finance (11 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= safety --> fleet (23 constraint(s)) =========
-- Requires: safety schema, fleet schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_etops_authorization_id` FOREIGN KEY (`etops_authorization_id`) REFERENCES `airlines_ecm`.`fleet`.`etops_authorization`(`etops_authorization_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_etops_authorization_id` FOREIGN KEY (`etops_authorization_id`) REFERENCES `airlines_ecm`.`fleet`.`etops_authorization`(`etops_authorization_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);

-- ========= safety --> inventory (3 constraint(s)) =========
-- Requires: safety schema, inventory schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= safety --> passenger (3 constraint(s)) =========
-- Requires: safety schema, passenger schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= safety --> route (14 constraint(s)) =========
-- Requires: safety schema, route schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_seasonal_schedule_id` FOREIGN KEY (`seasonal_schedule_id`) REFERENCES `airlines_ecm`.`route`.`seasonal_schedule`(`seasonal_schedule_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

