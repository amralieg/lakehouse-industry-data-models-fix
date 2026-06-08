-- Cross-Domain Foreign Keys for Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:09
-- Total cross-domain FK constraints: 1284
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: airport, ancillary, cargo, compliance, crew, finance, fleet, flight, inventory, loyalty, maintenance, marketing, passenger, procurement, reservation, revenue, route, safety, workforce

-- ========= airport --> compliance (1 constraint(s)) =========
-- Requires: airport schema, compliance schema
ALTER TABLE `airlines_ecm`.`airport`.`station` ADD CONSTRAINT `fk_airport_station_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);

-- ========= airport --> crew (1 constraint(s)) =========
-- Requires: airport schema, crew schema
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= airport --> finance (14 constraint(s)) =========
-- Requires: airport schema, finance schema
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ADD CONSTRAINT `fk_airport_terminal_facility_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gate` ADD CONSTRAINT `fk_airport_gate_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ADD CONSTRAINT `fk_airport_gse_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ADD CONSTRAINT `fk_airport_gse_asset_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ADD CONSTRAINT `fk_airport_pfc_record_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station` ADD CONSTRAINT `fk_airport_station_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_counter` ADD CONSTRAINT `fk_airport_checkin_counter_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= airport --> fleet (6 constraint(s)) =========
-- Requires: airport schema, fleet schema
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ADD CONSTRAINT `fk_airport_cdm_message_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= airport --> flight (16 constraint(s)) =========
-- Requires: airport schema, flight schema
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround` ADD CONSTRAINT `fk_airport_turnaround_turnaround_outbound_flight_leg_id` FOREIGN KEY (`turnaround_outbound_flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot_utilization` ADD CONSTRAINT `fk_airport_slot_utilization_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`cdm_message` ADD CONSTRAINT `fk_airport_cdm_message_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ADD CONSTRAINT `fk_airport_baggage_scan_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ADD CONSTRAINT `fk_airport_pfc_record_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`airport`.`airport_slot_allocation` ADD CONSTRAINT `fk_airport_airport_slot_allocation_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= airport --> loyalty (2 constraint(s)) =========
-- Requires: airport schema, loyalty schema
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= airport --> maintenance (2 constraint(s)) =========
-- Requires: airport schema, maintenance schema
ALTER TABLE `airlines_ecm`.`airport`.`station_mro_contract` ADD CONSTRAINT `fk_airport_station_mro_contract_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station_authorization` ADD CONSTRAINT `fk_airport_station_authorization_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);

-- ========= airport --> passenger (5 constraint(s)) =========
-- Requires: airport schema, passenger schema
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_item` ADD CONSTRAINT `fk_airport_baggage_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`airport`.`pfc_record` ADD CONSTRAINT `fk_airport_pfc_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= airport --> procurement (2 constraint(s)) =========
-- Requires: airport schema, procurement schema
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ADD CONSTRAINT `fk_airport_gse_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ground_handler` ADD CONSTRAINT `fk_airport_ground_handler_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= airport --> safety (10 constraint(s)) =========
-- Requires: airport schema, safety schema
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_asset` ADD CONSTRAINT `fk_airport_gse_asset_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ADD CONSTRAINT `fk_airport_gse_deployment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`handling_performance` ADD CONSTRAINT `fk_airport_handling_performance_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ADD CONSTRAINT `fk_airport_airport_irop_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= airport --> workforce (13 constraint(s)) =========
-- Requires: airport schema, workforce schema
ALTER TABLE `airlines_ecm`.`airport`.`terminal_facility` ADD CONSTRAINT `fk_airport_terminal_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gate_assignment` ADD CONSTRAINT `fk_airport_gate_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`turnaround_task` ADD CONSTRAINT `fk_airport_turnaround_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`slot` ADD CONSTRAINT `fk_airport_slot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`gse_deployment` ADD CONSTRAINT `fk_airport_gse_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`checkin_session` ADD CONSTRAINT `fk_airport_checkin_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`boarding_event` ADD CONSTRAINT `fk_airport_boarding_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_scan` ADD CONSTRAINT `fk_airport_baggage_scan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`baggage_irregularity` ADD CONSTRAINT `fk_airport_baggage_irregularity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`ramp_service_order` ADD CONSTRAINT `fk_airport_ramp_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`deicing_event` ADD CONSTRAINT `fk_airport_deicing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`airport_irop_event` ADD CONSTRAINT `fk_airport_airport_irop_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`airport`.`station` ADD CONSTRAINT `fk_airport_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= ancillary --> airport (4 constraint(s)) =========
-- Requires: ancillary schema, airport schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_checkin_counter_id` FOREIGN KEY (`checkin_counter_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_counter`(`checkin_counter_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_terminal_facility_id` FOREIGN KEY (`terminal_facility_id`) REFERENCES `airlines_ecm`.`airport`.`terminal_facility`(`terminal_facility_id`);

-- ========= ancillary --> compliance (1 constraint(s)) =========
-- Requires: ancillary schema, compliance schema
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ADD CONSTRAINT `fk_ancillary_product_catalog_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `airlines_ecm`.`compliance`.`carbon_offset`(`carbon_offset_id`);

-- ========= ancillary --> crew (1 constraint(s)) =========
-- Requires: ancillary schema, crew schema
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= ancillary --> finance (11 constraint(s)) =========
-- Requires: ancillary schema, finance schema
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ADD CONSTRAINT `fk_ancillary_product_catalog_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= ancillary --> fleet (2 constraint(s)) =========
-- Requires: ancillary schema, fleet schema
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_seat_map_id` FOREIGN KEY (`seat_map_id`) REFERENCES `airlines_ecm`.`fleet`.`seat_map`(`seat_map_id`);

-- ========= ancillary --> flight (10 constraint(s)) =========
-- Requires: ancillary schema, flight schema
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_flight_irop_event_id` FOREIGN KEY (`flight_irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`flight_irop_event`(`flight_irop_event_id`);

-- ========= ancillary --> inventory (11 constraint(s)) =========
-- Requires: ancillary schema, inventory schema
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ADD CONSTRAINT `fk_ancillary_baggage_allowance_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_upgrade_inventory_id` FOREIGN KEY (`upgrade_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`upgrade_inventory`(`upgrade_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= ancillary --> loyalty (5 constraint(s)) =========
-- Requires: ancillary schema, loyalty schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= ancillary --> marketing (7 constraint(s)) =========
-- Requires: ancillary schema, marketing schema
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ADD CONSTRAINT `fk_ancillary_product_catalog_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`sales_channel` ADD CONSTRAINT `fk_ancillary_sales_channel_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `airlines_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= ancillary --> passenger (9 constraint(s)) =========
-- Requires: ancillary schema, passenger schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`emd_coupon` ADD CONSTRAINT `fk_ancillary_emd_coupon_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= ancillary --> procurement (8 constraint(s)) =========
-- Requires: ancillary schema, procurement schema
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ADD CONSTRAINT `fk_ancillary_product_catalog_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`channel_vendor_agreement` ADD CONSTRAINT `fk_ancillary_channel_vendor_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= ancillary --> reservation (30 constraint(s)) =========
-- Requires: ancillary schema, reservation schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`emd_coupon` ADD CONSTRAINT `fk_ancillary_emd_coupon_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`emd_coupon` ADD CONSTRAINT `fk_ancillary_emd_coupon_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_booking_pnr_id` FOREIGN KEY (`booking_pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`inflight_retail_order` ADD CONSTRAINT `fk_ancillary_inflight_retail_order_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`meal_preorder` ADD CONSTRAINT `fk_ancillary_meal_preorder_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`lounge_access` ADD CONSTRAINT `fk_ancillary_lounge_access_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_booking_pnr_id` FOREIGN KEY (`booking_pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);

-- ========= ancillary --> revenue (1 constraint(s)) =========
-- Requires: ancillary schema, revenue schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);

-- ========= ancillary --> route (5 constraint(s)) =========
-- Requires: ancillary schema, route schema
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= ancillary --> workforce (7 constraint(s)) =========
-- Requires: ancillary schema, workforce schema
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`excess_baggage_charge` ADD CONSTRAINT `fk_ancillary_excess_baggage_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_refund` ADD CONSTRAINT `fk_ancillary_ancillary_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= cargo --> airport (18 constraint(s)) =========
-- Requires: cargo schema, airport schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ADD CONSTRAINT `fk_cargo_uld_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ADD CONSTRAINT `fk_cargo_cargo_allotment_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ADD CONSTRAINT `fk_cargo_cargo_revenue_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ADD CONSTRAINT `fk_cargo_interline_cargo_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= cargo --> compliance (14 constraint(s)) =========
-- Requires: cargo schema, compliance schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ADD CONSTRAINT `fk_cargo_cargo_allotment_operating_certificate_id` FOREIGN KEY (`operating_certificate_id`) REFERENCES `airlines_ecm`.`compliance`.`operating_certificate`(`operating_certificate_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ADD CONSTRAINT `fk_cargo_interline_cargo_operating_certificate_id` FOREIGN KEY (`operating_certificate_id`) REFERENCES `airlines_ecm`.`compliance`.`operating_certificate`(`operating_certificate_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= cargo --> finance (14 constraint(s)) =========
-- Requires: cargo schema, finance schema
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ADD CONSTRAINT `fk_cargo_uld_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ADD CONSTRAINT `fk_cargo_cargo_allotment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ADD CONSTRAINT `fk_cargo_cargo_revenue_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ADD CONSTRAINT `fk_cargo_interline_cargo_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ADD CONSTRAINT `fk_cargo_interline_cargo_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_surcharge` ADD CONSTRAINT `fk_cargo_cargo_surcharge_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= cargo --> fleet (5 constraint(s)) =========
-- Requires: cargo schema, fleet schema
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_aircraft_registration_id` FOREIGN KEY (`aircraft_registration_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_registration`(`aircraft_registration_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= cargo --> flight (3 constraint(s)) =========
-- Requires: cargo schema, flight schema
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= cargo --> inventory (2 constraint(s)) =========
-- Requires: cargo schema, inventory schema
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= cargo --> marketing (7 constraint(s)) =========
-- Requires: cargo schema, marketing schema
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `airlines_ecm`.`marketing`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_email_send_id` FOREIGN KEY (`email_send_id`) REFERENCES `airlines_ecm`.`marketing`.`email_send`(`email_send_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_market_research_study_id` FOREIGN KEY (`market_research_study_id`) REFERENCES `airlines_ecm`.`marketing`.`market_research_study`(`market_research_study_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `airlines_ecm`.`marketing`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`service_product` ADD CONSTRAINT `fk_cargo_service_product_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= cargo --> procurement (9 constraint(s)) =========
-- Requires: cargo schema, procurement schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld` ADD CONSTRAINT `fk_cargo_uld_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_fuel_uplift_order_id` FOREIGN KEY (`fuel_uplift_order_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_uplift_order`(`fuel_uplift_order_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_fuel_uplift_order_id` FOREIGN KEY (`fuel_uplift_order_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_uplift_order`(`fuel_uplift_order_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= cargo --> route (13 constraint(s)) =========
-- Requires: cargo schema, route schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_rate` ADD CONSTRAINT `fk_cargo_freight_rate_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`capacity` ADD CONSTRAINT `fk_cargo_capacity_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ADD CONSTRAINT `fk_cargo_cargo_allotment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_revenue` ADD CONSTRAINT `fk_cargo_cargo_revenue_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`interline_cargo` ADD CONSTRAINT `fk_cargo_interline_cargo_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`forwarder_route_agreement` ADD CONSTRAINT `fk_cargo_forwarder_route_agreement_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`product_route_availability` ADD CONSTRAINT `fk_cargo_product_route_availability_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= cargo --> safety (6 constraint(s)) =========
-- Requires: cargo schema, safety schema
ALTER TABLE `airlines_ecm`.`cargo`.`shipment` ADD CONSTRAINT `fk_cargo_shipment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_dangerous_goods_incident_id` FOREIGN KEY (`dangerous_goods_incident_id`) REFERENCES `airlines_ecm`.`safety`.`dangerous_goods_incident`(`dangerous_goods_incident_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= cargo --> workforce (14 constraint(s)) =========
-- Requires: cargo schema, workforce schema
ALTER TABLE `airlines_ecm`.`cargo`.`awb` ADD CONSTRAINT `fk_cargo_awb_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_booking` ADD CONSTRAINT `fk_cargo_cargo_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`uld_movement` ADD CONSTRAINT `fk_cargo_uld_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`manifest` ADD CONSTRAINT `fk_cargo_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`dangerous_goods` ADD CONSTRAINT `fk_cargo_dangerous_goods_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`cargo_allotment` ADD CONSTRAINT `fk_cargo_cargo_allotment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`freight_forwarder` ADD CONSTRAINT `fk_cargo_freight_forwarder_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`shipper` ADD CONSTRAINT `fk_cargo_shipper_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`invoice` ADD CONSTRAINT `fk_cargo_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`claim` ADD CONSTRAINT `fk_cargo_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`load_plan` ADD CONSTRAINT `fk_cargo_load_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`embargo` ADD CONSTRAINT `fk_cargo_embargo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`customs_entry` ADD CONSTRAINT `fk_cargo_customs_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`cargo`.`security_screening` ADD CONSTRAINT `fk_cargo_security_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> airport (5 constraint(s)) =========
-- Requires: compliance schema, airport schema
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ADD CONSTRAINT `fk_compliance_operating_certificate_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ADD CONSTRAINT `fk_compliance_operational_approval_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= compliance --> ancillary (3 constraint(s)) =========
-- Requires: compliance schema, ancillary schema
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_ancillary_refund_id` FOREIGN KEY (`ancillary_refund_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_refund`(`ancillary_refund_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ADD CONSTRAINT `fk_compliance_channel_audit_assessment_sales_channel_id` FOREIGN KEY (`sales_channel_id`) REFERENCES `airlines_ecm`.`ancillary`.`sales_channel`(`sales_channel_id`);

-- ========= compliance --> cargo (5 constraint(s)) =========
-- Requires: compliance schema, cargo schema
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_dangerous_goods_id` FOREIGN KEY (`dangerous_goods_id`) REFERENCES `airlines_ecm`.`cargo`.`dangerous_goods`(`dangerous_goods_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_security_screening_id` FOREIGN KEY (`security_screening_id`) REFERENCES `airlines_ecm`.`cargo`.`security_screening`(`security_screening_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `airlines_ecm`.`cargo`.`manifest`(`manifest_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_embargo_id` FOREIGN KEY (`embargo_id`) REFERENCES `airlines_ecm`.`cargo`.`embargo`(`embargo_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_dangerous_goods_id` FOREIGN KEY (`dangerous_goods_id`) REFERENCES `airlines_ecm`.`cargo`.`dangerous_goods`(`dangerous_goods_id`);

-- ========= compliance --> finance (15 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ADD CONSTRAINT `fk_compliance_operating_certificate_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ADD CONSTRAINT `fk_compliance_operational_approval_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ADD CONSTRAINT `fk_compliance_ad_compliance_record_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ADD CONSTRAINT `fk_compliance_carbon_offset_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ADD CONSTRAINT `fk_compliance_foreign_carrier_permit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ADD CONSTRAINT `fk_compliance_self_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ADD CONSTRAINT `fk_compliance_audit_cost_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ADD CONSTRAINT `fk_compliance_cost_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= compliance --> fleet (1 constraint(s)) =========
-- Requires: compliance schema, fleet schema
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ADD CONSTRAINT `fk_compliance_ad_compliance_record_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= compliance --> inventory (3 constraint(s)) =========
-- Requires: compliance schema, inventory schema
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= compliance --> procurement (10 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ADD CONSTRAINT `fk_compliance_operational_approval_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ADD CONSTRAINT `fk_compliance_ad_compliance_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);

-- ========= compliance --> route (4 constraint(s)) =========
-- Requires: compliance schema, route schema
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ADD CONSTRAINT `fk_compliance_operational_approval_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_ask_plan_id` FOREIGN KEY (`ask_plan_id`) REFERENCES `airlines_ecm`.`route`.`ask_plan`(`ask_plan_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ADD CONSTRAINT `fk_compliance_foreign_carrier_permit_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= compliance --> safety (3 constraint(s)) =========
-- Requires: compliance schema, safety schema
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= compliance --> workforce (20 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ADD CONSTRAINT `fk_compliance_operating_certificate_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ADD CONSTRAINT `fk_compliance_operational_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `airlines_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_finding_identified_by_auditor_employee_id` FOREIGN KEY (`finding_identified_by_auditor_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_finding_verified_by_auditor_employee_id` FOREIGN KEY (`finding_verified_by_auditor_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_capa_closure_approved_by_employee_id` FOREIGN KEY (`capa_closure_approved_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_capa_verified_by_employee_id` FOREIGN KEY (`capa_verified_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ADD CONSTRAINT `fk_compliance_foreign_carrier_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ADD CONSTRAINT `fk_compliance_self_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ADD CONSTRAINT `fk_compliance_audit_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= crew --> airport (6 constraint(s)) =========
-- Requires: crew schema, airport schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`crew`.`bid` ADD CONSTRAINT `fk_crew_bid_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= crew --> compliance (16 constraint(s)) =========
-- Requires: crew schema, compliance schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ADD CONSTRAINT `fk_crew_recency_record_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`crew`.`base` ADD CONSTRAINT `fk_crew_base_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ADD CONSTRAINT `fk_crew_ftl_legality_check_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`crew`.`ftl_legality_check` ADD CONSTRAINT `fk_crew_ftl_legality_check_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `airlines_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ADD CONSTRAINT `fk_crew_medical_certificate_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `airlines_ecm`.`compliance`.`finding`(`finding_id`);
ALTER TABLE `airlines_ecm`.`crew`.`medical_certificate` ADD CONSTRAINT `fk_crew_medical_certificate_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`crew`.`licence` ADD CONSTRAINT `fk_crew_licence_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `airlines_ecm`.`compliance`.`finding`(`finding_id`);
ALTER TABLE `airlines_ecm`.`crew`.`licence` ADD CONSTRAINT `fk_crew_licence_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ADD CONSTRAINT `fk_crew_operational_qualification_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);

-- ========= crew --> finance (8 constraint(s)) =========
-- Requires: crew schema, finance schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`base` ADD CONSTRAINT `fk_crew_base_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= crew --> fleet (6 constraint(s)) =========
-- Requires: crew schema, fleet schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ADD CONSTRAINT `fk_crew_recency_record_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`crew`.`bid` ADD CONSTRAINT `fk_crew_bid_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= crew --> flight (3 constraint(s)) =========
-- Requires: crew schema, flight schema
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= crew --> loyalty (1 constraint(s)) =========
-- Requires: crew schema, loyalty schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= crew --> maintenance (3 constraint(s)) =========
-- Requires: crew schema, maintenance schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`crew`.`maintenance_authorization` ADD CONSTRAINT `fk_crew_maintenance_authorization_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);

-- ========= crew --> procurement (3 constraint(s)) =========
-- Requires: crew schema, procurement schema
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= crew --> safety (6 constraint(s)) =========
-- Requires: crew schema, safety schema
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`crew`.`pairing` ADD CONSTRAINT `fk_crew_pairing_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`duty_period` ADD CONSTRAINT `fk_crew_duty_period_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`flight_leg_assignment` ADD CONSTRAINT `fk_crew_flight_leg_assignment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`crew`.`training_event` ADD CONSTRAINT `fk_crew_training_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= crew --> workforce (12 constraint(s)) =========
-- Requires: crew schema, workforce schema
ALTER TABLE `airlines_ecm`.`crew`.`member` ADD CONSTRAINT `fk_crew_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`qualification` ADD CONSTRAINT `fk_crew_qualification_type_rating_id` FOREIGN KEY (`type_rating_id`) REFERENCES `airlines_ecm`.`workforce`.`type_rating`(`type_rating_id`);
ALTER TABLE `airlines_ecm`.`crew`.`recency_record` ADD CONSTRAINT `fk_crew_recency_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`base` ADD CONSTRAINT `fk_crew_base_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster` ADD CONSTRAINT `fk_crew_roster_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`roster_activity` ADD CONSTRAINT `fk_crew_roster_activity_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `airlines_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `airlines_ecm`.`crew`.`licence` ADD CONSTRAINT `fk_crew_licence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`absence` ADD CONSTRAINT `fk_crew_absence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`bid` ADD CONSTRAINT `fk_crew_bid_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`operational_qualification` ADD CONSTRAINT `fk_crew_operational_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`crew`.`swap_request` ADD CONSTRAINT `fk_crew_swap_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> crew (2 constraint(s)) =========
-- Requires: finance schema, crew schema
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_flight_leg_assignment_id` FOREIGN KEY (`flight_leg_assignment_id`) REFERENCES `airlines_ecm`.`crew`.`flight_leg_assignment`(`flight_leg_assignment_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_base_id` FOREIGN KEY (`base_id`) REFERENCES `airlines_ecm`.`crew`.`base`(`base_id`);

-- ========= finance --> fleet (1 constraint(s)) =========
-- Requires: finance schema, fleet schema
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= finance --> flight (2 constraint(s)) =========
-- Requires: finance schema, flight schema
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_fuel_uplift_id` FOREIGN KEY (`fuel_uplift_id`) REFERENCES `airlines_ecm`.`flight`.`fuel_uplift`(`fuel_uplift_id`);

-- ========= finance --> passenger (1 constraint(s)) =========
-- Requires: finance schema, passenger schema
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= finance --> procurement (11 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `airlines_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_repair_order_id` FOREIGN KEY (`repair_order_id`) REFERENCES `airlines_ecm`.`procurement`.`repair_order`(`repair_order_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_fuel_uplift_order_id` FOREIGN KEY (`fuel_uplift_order_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_uplift_order`(`fuel_uplift_order_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`finance`.`hedge_contract` ADD CONSTRAINT `fk_finance_hedge_contract_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> revenue (1 constraint(s)) =========
-- Requires: finance schema, revenue schema
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);

-- ========= finance --> workforce (11 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_primary_budget_employee_id` FOREIGN KEY (`primary_budget_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`treasury_position` ADD CONSTRAINT `fk_finance_treasury_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`finance`.`cash_pool` ADD CONSTRAINT `fk_finance_cash_pool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= fleet --> airport (7 constraint(s)) =========
-- Requires: fleet schema, airport schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`apu_record` ADD CONSTRAINT `fk_fleet_apu_record_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ADD CONSTRAINT `fk_fleet_aircraft_utilization_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_redelivery` ADD CONSTRAINT `fk_fleet_aircraft_redelivery_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= fleet --> compliance (6 constraint(s)) =========
-- Requires: fleet schema, compliance schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_operating_certificate_id` FOREIGN KEY (`operating_certificate_id`) REFERENCES `airlines_ecm`.`compliance`.`operating_certificate`(`operating_certificate_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_plan` ADD CONSTRAINT `fk_fleet_fleet_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_document` ADD CONSTRAINT `fk_fleet_aircraft_document_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_approval` ADD CONSTRAINT `fk_fleet_aircraft_approval_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);

-- ========= fleet --> finance (7 constraint(s)) =========
-- Requires: fleet schema, finance schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_utilization` ADD CONSTRAINT `fk_fleet_aircraft_utilization_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_plan` ADD CONSTRAINT `fk_fleet_fleet_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);

-- ========= fleet --> maintenance (2 constraint(s)) =========
-- Requires: fleet schema, maintenance schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_redelivery` ADD CONSTRAINT `fk_fleet_aircraft_redelivery_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`maintenance_service_agreement` ADD CONSTRAINT `fk_fleet_maintenance_service_agreement_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);

-- ========= fleet --> marketing (2 constraint(s)) =========
-- Requires: fleet schema, marketing schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_sponsorship_activation` ADD CONSTRAINT `fk_fleet_aircraft_sponsorship_activation_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `airlines_ecm`.`marketing`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_sponsorship_activation` ADD CONSTRAINT `fk_fleet_aircraft_sponsorship_activation_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `airlines_ecm`.`marketing`.`sponsorship`(`sponsorship_id`);

-- ========= fleet --> procurement (8 constraint(s)) =========
-- Requires: fleet schema, procurement schema
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`apu_record` ADD CONSTRAINT `fk_fleet_apu_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type_vendor_approval` ADD CONSTRAINT `fk_fleet_aircraft_type_vendor_approval_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= fleet --> route (1 constraint(s)) =========
-- Requires: fleet schema, route schema
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_plan` ADD CONSTRAINT `fk_fleet_fleet_plan_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= fleet --> safety (1 constraint(s)) =========
-- Requires: fleet schema, safety schema
ALTER TABLE `airlines_ecm`.`fleet`.`type_recommendation_applicability` ADD CONSTRAINT `fk_fleet_type_recommendation_applicability_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);

-- ========= fleet --> workforce (12 constraint(s)) =========
-- Requires: fleet schema, workforce schema
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft` ADD CONSTRAINT `fk_fleet_aircraft_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_order` ADD CONSTRAINT `fk_fleet_fleet_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_delivery` ADD CONSTRAINT `fk_fleet_aircraft_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_lease` ADD CONSTRAINT `fk_fleet_aircraft_lease_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`engine` ADD CONSTRAINT `fk_fleet_engine_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`etops_authorization` ADD CONSTRAINT `fk_fleet_etops_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`fleet_plan` ADD CONSTRAINT `fk_fleet_fleet_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_registration` ADD CONSTRAINT `fk_fleet_aircraft_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_redelivery` ADD CONSTRAINT `fk_fleet_aircraft_redelivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_document` ADD CONSTRAINT `fk_fleet_aircraft_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`type_qualification` ADD CONSTRAINT `fk_fleet_type_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`fleet`.`aircraft_type_vendor_approval` ADD CONSTRAINT `fk_fleet_aircraft_type_vendor_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= flight --> airport (4 constraint(s)) =========
-- Requires: flight schema, airport schema
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_irop_event` ADD CONSTRAINT `fk_flight_flight_irop_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= flight --> cargo (4 constraint(s)) =========
-- Requires: flight schema, cargo schema
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_dangerous_goods_id` FOREIGN KEY (`dangerous_goods_id`) REFERENCES `airlines_ecm`.`cargo`.`dangerous_goods`(`dangerous_goods_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_allotment` ADD CONSTRAINT `fk_flight_flight_allotment_cargo_allotment_id` FOREIGN KEY (`cargo_allotment_id`) REFERENCES `airlines_ecm`.`cargo`.`cargo_allotment`(`cargo_allotment_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_allotment` ADD CONSTRAINT `fk_flight_flight_allotment_freight_forwarder_id` FOREIGN KEY (`freight_forwarder_id`) REFERENCES `airlines_ecm`.`cargo`.`freight_forwarder`(`freight_forwarder_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cargo_segment` ADD CONSTRAINT `fk_flight_cargo_segment_awb_id` FOREIGN KEY (`awb_id`) REFERENCES `airlines_ecm`.`cargo`.`awb`(`awb_id`);

-- ========= flight --> compliance (9 constraint(s)) =========
-- Requires: flight schema, compliance schema
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_foreign_carrier_permit_id` FOREIGN KEY (`foreign_carrier_permit_id`) REFERENCES `airlines_ecm`.`compliance`.`foreign_carrier_permit`(`foreign_carrier_permit_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_irop_event` ADD CONSTRAINT `fk_flight_flight_irop_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`flight`.`operational_flight_plan` ADD CONSTRAINT `fk_flight_operational_flight_plan_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_performance` ADD CONSTRAINT `fk_flight_flight_performance_emissions_report_id` FOREIGN KEY (`emissions_report_id`) REFERENCES `airlines_ecm`.`compliance`.`emissions_report`(`emissions_report_id`);
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_exemption_invocation` ADD CONSTRAINT `fk_flight_dispatch_exemption_invocation_exemption_waiver_id` FOREIGN KEY (`exemption_waiver_id`) REFERENCES `airlines_ecm`.`compliance`.`exemption_waiver`(`exemption_waiver_id`);

-- ========= flight --> crew (2 constraint(s)) =========
-- Requires: flight schema, crew schema
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_plan` ADD CONSTRAINT `fk_flight_flight_plan_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= flight --> finance (6 constraint(s)) =========
-- Requires: flight schema, finance schema
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_irop_event` ADD CONSTRAINT `fk_flight_flight_irop_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= flight --> fleet (4 constraint(s)) =========
-- Requires: flight schema, fleet schema
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_plan` ADD CONSTRAINT `fk_flight_flight_plan_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_performance` ADD CONSTRAINT `fk_flight_flight_performance_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= flight --> passenger (1 constraint(s)) =========
-- Requires: flight schema, passenger schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= flight --> procurement (1 constraint(s)) =========
-- Requires: flight schema, procurement schema
ALTER TABLE `airlines_ecm`.`flight`.`fuel_uplift` ADD CONSTRAINT `fk_flight_fuel_uplift_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= flight --> reservation (1 constraint(s)) =========
-- Requires: flight schema, reservation schema
ALTER TABLE `airlines_ecm`.`flight`.`booking_segment` ADD CONSTRAINT `fk_flight_booking_segment_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= flight --> route (4 constraint(s)) =========
-- Requires: flight schema, route schema
ALTER TABLE `airlines_ecm`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`flight`.`operational_flight_plan` ADD CONSTRAINT `fk_flight_operational_flight_plan_operational_standard_id` FOREIGN KEY (`operational_standard_id`) REFERENCES `airlines_ecm`.`route`.`operational_standard`(`operational_standard_id`);
ALTER TABLE `airlines_ecm`.`flight`.`codeshare_flight_execution` ADD CONSTRAINT `fk_flight_codeshare_flight_execution_partnership_id` FOREIGN KEY (`partnership_id`) REFERENCES `airlines_ecm`.`route`.`partnership`(`partnership_id`);

-- ========= flight --> safety (4 constraint(s)) =========
-- Requires: flight schema, safety schema
ALTER TABLE `airlines_ecm`.`flight`.`flight_leg` ADD CONSTRAINT `fk_flight_flight_leg_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= flight --> workforce (7 constraint(s)) =========
-- Requires: flight schema, workforce schema
ALTER TABLE `airlines_ecm`.`flight`.`dispatch_release` ADD CONSTRAINT `fk_flight_dispatch_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_plan` ADD CONSTRAINT `fk_flight_flight_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`flight`.`delay_record` ADD CONSTRAINT `fk_flight_delay_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`flight`.`diversion` ADD CONSTRAINT `fk_flight_diversion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`flight`.`flight_irop_event` ADD CONSTRAINT `fk_flight_flight_irop_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`flight`.`cancellation` ADD CONSTRAINT `fk_flight_cancellation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`flight`.`operational_flight_plan` ADD CONSTRAINT `fk_flight_operational_flight_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> compliance (4 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_operating_certificate_id` FOREIGN KEY (`operating_certificate_id`) REFERENCES `airlines_ecm`.`compliance`.`operating_certificate`(`operating_certificate_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_operational_approval_id` FOREIGN KEY (`operational_approval_id`) REFERENCES `airlines_ecm`.`compliance`.`operational_approval`(`operational_approval_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`irop_reprotection` ADD CONSTRAINT `fk_inventory_irop_reprotection_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);

-- ========= inventory --> finance (7 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`cabin_class` ADD CONSTRAINT `fk_inventory_cabin_class_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`irop_reprotection` ADD CONSTRAINT `fk_inventory_irop_reprotection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`lease_cost_allocation` ADD CONSTRAINT `fk_inventory_lease_cost_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `airlines_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`lease_cost_allocation` ADD CONSTRAINT `fk_inventory_lease_cost_allocation_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);

-- ========= inventory --> fleet (5 constraint(s)) =========
-- Requires: inventory schema, fleet schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`inventory_leg` ADD CONSTRAINT `fk_inventory_inventory_leg_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`upgrade_inventory` ADD CONSTRAINT `fk_inventory_upgrade_inventory_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= inventory --> flight (9 constraint(s)) =========
-- Requires: inventory schema, flight schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`seat_availability` ADD CONSTRAINT `fk_inventory_seat_availability_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`segment` ADD CONSTRAINT `fk_inventory_segment_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`bucket_adjustment` ADD CONSTRAINT `fk_inventory_bucket_adjustment_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`upgrade_inventory` ADD CONSTRAINT `fk_inventory_upgrade_inventory_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`irop_reprotection` ADD CONSTRAINT `fk_inventory_irop_reprotection_flight_irop_event_id` FOREIGN KEY (`flight_irop_event_id`) REFERENCES `airlines_ecm`.`flight`.`flight_irop_event`(`flight_irop_event_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`irop_reprotection` ADD CONSTRAINT `fk_inventory_irop_reprotection_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= inventory --> maintenance (1 constraint(s)) =========
-- Requires: inventory schema, maintenance schema
ALTER TABLE `airlines_ecm`.`inventory`.`bucket_adjustment` ADD CONSTRAINT `fk_inventory_bucket_adjustment_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `airlines_ecm`.`maintenance`.`forecast`(`forecast_id`);

-- ========= inventory --> marketing (6 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_promotional_fare_id` FOREIGN KEY (`promotional_fare_id`) REFERENCES `airlines_ecm`.`marketing`.`promotional_fare`(`promotional_fare_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`fare_class_bucket` ADD CONSTRAINT `fk_inventory_fare_class_bucket_promotional_fare_id` FOREIGN KEY (`promotional_fare_id`) REFERENCES `airlines_ecm`.`marketing`.`promotional_fare`(`promotional_fare_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_campaign_response_id` FOREIGN KEY (`campaign_response_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign_response`(`campaign_response_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= inventory --> passenger (1 constraint(s)) =========
-- Requires: inventory schema, passenger schema
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= inventory --> procurement (10 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `airlines_ecm`.`inventory`.`cabin_class` ADD CONSTRAINT `fk_inventory_cabin_class_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`fare_class_bucket` ADD CONSTRAINT `fk_inventory_fare_class_bucket_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`seat_availability` ADD CONSTRAINT `fk_inventory_seat_availability_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`upgrade_inventory` ADD CONSTRAINT `fk_inventory_upgrade_inventory_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`irop_reprotection` ADD CONSTRAINT `fk_inventory_irop_reprotection_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);

-- ========= inventory --> reservation (2 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= inventory --> revenue (2 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`waitlist_entry` ADD CONSTRAINT `fk_inventory_waitlist_entry_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);

-- ========= inventory --> route (8 constraint(s)) =========
-- Requires: inventory schema, route schema
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `airlines_ecm`.`route`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`flight_inventory` ADD CONSTRAINT `fk_inventory_flight_inventory_seasonal_schedule_id` FOREIGN KEY (`seasonal_schedule_id`) REFERENCES `airlines_ecm`.`route`.`seasonal_schedule`(`seasonal_schedule_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_bilateral_asa_id` FOREIGN KEY (`bilateral_asa_id`) REFERENCES `airlines_ecm`.`route`.`bilateral_asa`(`bilateral_asa_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `airlines_ecm`.`route`.`carrier`(`carrier_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`season_inventory_plan` ADD CONSTRAINT `fk_inventory_season_inventory_plan_schedule_season_id` FOREIGN KEY (`schedule_season_id`) REFERENCES `airlines_ecm`.`route`.`schedule_season`(`schedule_season_id`);

-- ========= inventory --> workforce (5 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `airlines_ecm`.`inventory`.`overbooking_control` ADD CONSTRAINT `fk_inventory_overbooking_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`codeshare_allocation` ADD CONSTRAINT `fk_inventory_codeshare_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`bucket_adjustment` ADD CONSTRAINT `fk_inventory_bucket_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`group_block` ADD CONSTRAINT `fk_inventory_group_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`inventory`.`irop_reprotection` ADD CONSTRAINT `fk_inventory_irop_reprotection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= loyalty --> airport (2 constraint(s)) =========
-- Requires: loyalty schema, airport schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= loyalty --> compliance (10 constraint(s)) =========
-- Requires: loyalty schema, compliance schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ADD CONSTRAINT `fk_loyalty_partner_program_foreign_carrier_permit_id` FOREIGN KEY (`foreign_carrier_permit_id`) REFERENCES `airlines_ecm`.`compliance`.`foreign_carrier_permit`(`foreign_carrier_permit_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ADD CONSTRAINT `fk_loyalty_partner_program_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`loyalty_promotion` ADD CONSTRAINT `fk_loyalty_loyalty_promotion_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`coalition_program` ADD CONSTRAINT `fk_loyalty_coalition_program_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_purchase` ADD CONSTRAINT `fk_loyalty_miles_purchase_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_adjustment` ADD CONSTRAINT `fk_loyalty_miles_adjustment_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `airlines_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_audit_sample` ADD CONSTRAINT `fk_loyalty_member_audit_sample_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);

-- ========= loyalty --> finance (6 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`loyalty_promotion` ADD CONSTRAINT `fk_loyalty_loyalty_promotion_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_settlement` ADD CONSTRAINT `fk_loyalty_partner_settlement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_settlement` ADD CONSTRAINT `fk_loyalty_partner_settlement_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_purchase` ADD CONSTRAINT `fk_loyalty_miles_purchase_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);

-- ========= loyalty --> flight (3 constraint(s)) =========
-- Requires: loyalty schema, flight schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= loyalty --> inventory (5 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);

-- ========= loyalty --> maintenance (1 constraint(s)) =========
-- Requires: loyalty schema, maintenance schema
ALTER TABLE `airlines_ecm`.`loyalty`.`qualification_cycle` ADD CONSTRAINT `fk_loyalty_qualification_cycle_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);

-- ========= loyalty --> marketing (11 constraint(s)) =========
-- Requires: loyalty schema, marketing schema
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ADD CONSTRAINT `fk_loyalty_ffp_member_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `airlines_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ADD CONSTRAINT `fk_loyalty_partner_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`loyalty_promotion` ADD CONSTRAINT `fk_loyalty_loyalty_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`loyalty_promotion_enrollment` ADD CONSTRAINT `fk_loyalty_loyalty_promotion_enrollment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`status_match` ADD CONSTRAINT `fk_loyalty_status_match_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_purchase` ADD CONSTRAINT `fk_loyalty_miles_purchase_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_adjustment` ADD CONSTRAINT `fk_loyalty_miles_adjustment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= loyalty --> reservation (1 constraint(s)) =========
-- Requires: loyalty schema, reservation schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_e_ticket_id` FOREIGN KEY (`e_ticket_id`) REFERENCES `airlines_ecm`.`reservation`.`e_ticket`(`e_ticket_id`);

-- ========= loyalty --> revenue (6 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_flight_revenue_performance_id` FOREIGN KEY (`flight_revenue_performance_id`) REFERENCES `airlines_ecm`.`revenue`.`flight_revenue_performance`(`flight_revenue_performance_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);

-- ========= loyalty --> route (2 constraint(s)) =========
-- Requires: loyalty schema, route schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= loyalty --> safety (3 constraint(s)) =========
-- Requires: loyalty schema, safety schema
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= loyalty --> workforce (12 constraint(s)) =========
-- Requires: loyalty schema, workforce schema
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ADD CONSTRAINT `fk_loyalty_tier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ADD CONSTRAINT `fk_loyalty_miles_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`coalition_program` ADD CONSTRAINT `fk_loyalty_coalition_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`status_match` ADD CONSTRAINT `fk_loyalty_status_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_settlement` ADD CONSTRAINT `fk_loyalty_partner_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`lifetime_status` ADD CONSTRAINT `fk_loyalty_lifetime_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_purchase` ADD CONSTRAINT `fk_loyalty_miles_purchase_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_adjustment` ADD CONSTRAINT `fk_loyalty_miles_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= maintenance --> airport (10 constraint(s)) =========
-- Requires: maintenance schema, airport schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ADD CONSTRAINT `fk_maintenance_visit_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= maintenance --> compliance (16 constraint(s)) =========
-- Requires: maintenance schema, compliance schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ADD CONSTRAINT `fk_maintenance_airworthiness_directive_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ADD CONSTRAINT `fk_maintenance_service_bulletin_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ADD CONSTRAINT `fk_maintenance_mel_item_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_ad_compliance_record_id` FOREIGN KEY (`ad_compliance_record_id`) REFERENCES `airlines_ecm`.`compliance`.`ad_compliance_record`(`ad_compliance_record_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ADD CONSTRAINT `fk_maintenance_certifying_staff_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);

-- ========= maintenance --> crew (5 constraint(s)) =========
-- Requires: maintenance schema, crew schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= maintenance --> finance (13 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ADD CONSTRAINT `fk_maintenance_forecast_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ADD CONSTRAINT `fk_maintenance_visit_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ADD CONSTRAINT `fk_maintenance_apu_status_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);

-- ========= maintenance --> fleet (6 constraint(s)) =========
-- Requires: maintenance schema, fleet schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ADD CONSTRAINT `fk_maintenance_mel_item_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ADD CONSTRAINT `fk_maintenance_llp_status_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ADD CONSTRAINT `fk_maintenance_apu_status_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= maintenance --> flight (1 constraint(s)) =========
-- Requires: maintenance schema, flight schema
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ADD CONSTRAINT `fk_maintenance_llp_status_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= maintenance --> procurement (11 constraint(s)) =========
-- Requires: maintenance schema, procurement schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ADD CONSTRAINT `fk_maintenance_forecast_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ADD CONSTRAINT `fk_maintenance_material_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ADD CONSTRAINT `fk_maintenance_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= maintenance --> revenue (1 constraint(s)) =========
-- Requires: maintenance schema, revenue schema
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_flight_revenue_performance_id` FOREIGN KEY (`flight_revenue_performance_id`) REFERENCES `airlines_ecm`.`revenue`.`flight_revenue_performance`(`flight_revenue_performance_id`);

-- ========= maintenance --> safety (35 constraint(s)) =========
-- Requires: maintenance schema, safety schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `airlines_ecm`.`safety`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_wildlife_strike_id` FOREIGN KEY (`wildlife_strike_id`) REFERENCES `airlines_ecm`.`safety`.`wildlife_strike`(`wildlife_strike_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `airlines_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_airspace_deviation_id` FOREIGN KEY (`airspace_deviation_id`) REFERENCES `airlines_ecm`.`safety`.`airspace_deviation`(`airspace_deviation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_fdr_event_id` FOREIGN KEY (`fdr_event_id`) REFERENCES `airlines_ecm`.`safety`.`fdr_event`(`fdr_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_runway_incursion_id` FOREIGN KEY (`runway_incursion_id`) REFERENCES `airlines_ecm`.`safety`.`runway_incursion`(`runway_incursion_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_wildlife_strike_id` FOREIGN KEY (`wildlife_strike_id`) REFERENCES `airlines_ecm`.`safety`.`wildlife_strike`(`wildlife_strike_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_fdr_event_id` FOREIGN KEY (`fdr_event_id`) REFERENCES `airlines_ecm`.`safety`.`fdr_event`(`fdr_event_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_emergency_drill_id` FOREIGN KEY (`emergency_drill_id`) REFERENCES `airlines_ecm`.`safety`.`emergency_drill`(`emergency_drill_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_case_id` FOREIGN KEY (`case_id`) REFERENCES `airlines_ecm`.`safety`.`case`(`case_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ADD CONSTRAINT `fk_maintenance_certifying_staff_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `airlines_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `airlines_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_recommendation_id` FOREIGN KEY (`recommendation_id`) REFERENCES `airlines_ecm`.`safety`.`recommendation`(`recommendation_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_case_id` FOREIGN KEY (`case_id`) REFERENCES `airlines_ecm`.`safety`.`case`(`case_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `airlines_ecm`.`safety`.`hazard`(`hazard_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `airlines_ecm`.`safety`.`investigation`(`investigation_id`);

-- ========= maintenance --> workforce (15 constraint(s)) =========
-- Requires: maintenance schema, workforce schema
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_primary_work_technician_employee_id` FOREIGN KEY (`primary_work_technician_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ADD CONSTRAINT `fk_maintenance_approved_maintenance_org_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ADD CONSTRAINT `fk_maintenance_certifying_staff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ADD CONSTRAINT `fk_maintenance_material_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ADD CONSTRAINT `fk_maintenance_material_request_primary_material_requestor_employee_id` FOREIGN KEY (`primary_material_requestor_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ADD CONSTRAINT `fk_maintenance_material_request_tertiary_material_employee_id` FOREIGN KEY (`tertiary_material_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> airport (7 constraint(s)) =========
-- Requires: marketing schema, airport schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ADD CONSTRAINT `fk_marketing_promotional_fare_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ADD CONSTRAINT `fk_marketing_destination_content_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= marketing --> ancillary (4 constraint(s)) =========
-- Requires: marketing schema, ancillary schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ADD CONSTRAINT `fk_marketing_email_send_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);

-- ========= marketing --> finance (7 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ADD CONSTRAINT `fk_marketing_promotional_fare_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ADD CONSTRAINT `fk_marketing_co_marketing_agreement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= marketing --> fleet (5 constraint(s)) =========
-- Requires: marketing schema, fleet schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ADD CONSTRAINT `fk_marketing_social_media_post_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= marketing --> flight (1 constraint(s)) =========
-- Requires: marketing schema, flight schema
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= marketing --> loyalty (1 constraint(s)) =========
-- Requires: marketing schema, loyalty schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= marketing --> passenger (6 constraint(s)) =========
-- Requires: marketing schema, passenger schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ADD CONSTRAINT `fk_marketing_segment_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ADD CONSTRAINT `fk_marketing_communication_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ADD CONSTRAINT `fk_marketing_email_send_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= marketing --> procurement (7 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ADD CONSTRAINT `fk_marketing_digital_campaign_creative_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` ADD CONSTRAINT `fk_marketing_contract_deliverable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= marketing --> reservation (1 constraint(s)) =========
-- Requires: marketing schema, reservation schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= marketing --> revenue (5 constraint(s)) =========
-- Requires: marketing schema, revenue schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_pricing_record_id` FOREIGN KEY (`pricing_record_id`) REFERENCES `airlines_ecm`.`revenue`.`pricing_record`(`pricing_record_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_pricing_record_id` FOREIGN KEY (`pricing_record_id`) REFERENCES `airlines_ecm`.`revenue`.`pricing_record`(`pricing_record_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ADD CONSTRAINT `fk_marketing_promotional_fare_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);

-- ========= marketing --> workforce (17 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ADD CONSTRAINT `fk_marketing_segment_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ADD CONSTRAINT `fk_marketing_nps_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ADD CONSTRAINT `fk_marketing_digital_campaign_creative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ADD CONSTRAINT `fk_marketing_ab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ADD CONSTRAINT `fk_marketing_promotional_fare_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ADD CONSTRAINT `fk_marketing_co_marketing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ADD CONSTRAINT `fk_marketing_social_media_post_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ADD CONSTRAINT `fk_marketing_destination_content_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` ADD CONSTRAINT `fk_marketing_contract_deliverable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= passenger --> airport (1 constraint(s)) =========
-- Requires: passenger schema, airport schema
ALTER TABLE `airlines_ecm`.`passenger`.`travel_preference` ADD CONSTRAINT `fk_passenger_travel_preference_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= passenger --> compliance (8 constraint(s)) =========
-- Requires: passenger schema, compliance schema
ALTER TABLE `airlines_ecm`.`passenger`.`travel_identity_document` ADD CONSTRAINT `fk_passenger_travel_identity_document_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`consent` ADD CONSTRAINT `fk_passenger_consent_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);

-- ========= passenger --> crew (2 constraint(s)) =========
-- Requires: passenger schema, crew schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`minor_guardian` ADD CONSTRAINT `fk_passenger_minor_guardian_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= passenger --> finance (2 constraint(s)) =========
-- Requires: passenger schema, finance schema
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= passenger --> flight (2 constraint(s)) =========
-- Requires: passenger schema, flight schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= passenger --> inventory (6 constraint(s)) =========
-- Requires: passenger schema, inventory schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`apis_submission` ADD CONSTRAINT `fk_passenger_apis_submission_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`pnr_link` ADD CONSTRAINT `fk_passenger_pnr_link_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_booking` ADD CONSTRAINT `fk_passenger_passenger_booking_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= passenger --> loyalty (9 constraint(s)) =========
-- Requires: passenger schema, loyalty schema
ALTER TABLE `airlines_ecm`.`passenger`.`profile` ADD CONSTRAINT `fk_passenger_profile_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`loyalty_linkage` ADD CONSTRAINT `fk_passenger_loyalty_linkage_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`traveller_segment` ADD CONSTRAINT `fk_passenger_traveller_segment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`pnr_link` ADD CONSTRAINT `fk_passenger_pnr_link_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_promotion_enrollment` ADD CONSTRAINT `fk_passenger_passenger_promotion_enrollment_loyalty_promotion_id` FOREIGN KEY (`loyalty_promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`loyalty_promotion`(`loyalty_promotion_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_promotion_enrollment` ADD CONSTRAINT `fk_passenger_passenger_promotion_enrollment_loyalty_promotion_enrollment_id` FOREIGN KEY (`loyalty_promotion_enrollment_id`) REFERENCES `airlines_ecm`.`loyalty`.`loyalty_promotion_enrollment`(`loyalty_promotion_enrollment_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_promotion_enrollment` ADD CONSTRAINT `fk_passenger_passenger_promotion_enrollment_promotion_loyalty_promotion_id` FOREIGN KEY (`promotion_loyalty_promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`loyalty_promotion`(`loyalty_promotion_id`);

-- ========= passenger --> procurement (2 constraint(s)) =========
-- Requires: passenger schema, procurement schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= passenger --> reservation (6 constraint(s)) =========
-- Requires: passenger schema, reservation schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`pnr_link` ADD CONSTRAINT `fk_passenger_pnr_link_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_booking_passenger` ADD CONSTRAINT `fk_passenger_passenger_booking_passenger_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_booking_passenger` ADD CONSTRAINT `fk_passenger_passenger_booking_passenger_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_booking` ADD CONSTRAINT `fk_passenger_passenger_booking_booking_pnr_id` FOREIGN KEY (`booking_pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`passenger_booking` ADD CONSTRAINT `fk_passenger_passenger_booking_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= passenger --> revenue (3 constraint(s)) =========
-- Requires: passenger schema, revenue schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_revenue_emd_id` FOREIGN KEY (`revenue_emd_id`) REFERENCES `airlines_ecm`.`revenue`.`revenue_emd`(`revenue_emd_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`accessibility_profile` ADD CONSTRAINT `fk_passenger_accessibility_profile_revenue_emd_id` FOREIGN KEY (`revenue_emd_id`) REFERENCES `airlines_ecm`.`revenue`.`revenue_emd`(`revenue_emd_id`);

-- ========= passenger --> route (7 constraint(s)) =========
-- Requires: passenger schema, route schema
ALTER TABLE `airlines_ecm`.`passenger`.`profile` ADD CONSTRAINT `fk_passenger_profile_city_pair_id` FOREIGN KEY (`city_pair_id`) REFERENCES `airlines_ecm`.`route`.`city_pair`(`city_pair_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`travel_preference` ADD CONSTRAINT `fk_passenger_travel_preference_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`traveller_segment` ADD CONSTRAINT `fk_passenger_traveller_segment_city_pair_id` FOREIGN KEY (`city_pair_id`) REFERENCES `airlines_ecm`.`route`.`city_pair`(`city_pair_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`pnr_link` ADD CONSTRAINT `fk_passenger_pnr_link_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`travel_history` ADD CONSTRAINT `fk_passenger_travel_history_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= passenger --> workforce (7 constraint(s)) =========
-- Requires: passenger schema, workforce schema
ALTER TABLE `airlines_ecm`.`passenger`.`ssr_record` ADD CONSTRAINT `fk_passenger_ssr_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`profile_history` ADD CONSTRAINT `fk_passenger_profile_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`minor_guardian` ADD CONSTRAINT `fk_passenger_minor_guardian_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`watchlist_check` ADD CONSTRAINT `fk_passenger_watchlist_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`corporate_traveller` ADD CONSTRAINT `fk_passenger_corporate_traveller_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`pnr_link` ADD CONSTRAINT `fk_passenger_pnr_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`passenger`.`data_subject_request` ADD CONSTRAINT `fk_passenger_data_subject_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> compliance (1 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ADD CONSTRAINT `fk_procurement_vendor_audit_schedule_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_program`(`audit_program_id`);

-- ========= procurement --> flight (3 constraint(s)) =========
-- Requires: procurement schema, flight schema
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ADD CONSTRAINT `fk_procurement_fuel_uplift_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ADD CONSTRAINT `fk_procurement_catering_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= procurement --> workforce (30 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ADD CONSTRAINT `fk_procurement_part_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ADD CONSTRAINT `fk_procurement_parts_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_primary_sourcing_employee_id` FOREIGN KEY (`primary_sourcing_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ADD CONSTRAINT `fk_procurement_fuel_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ADD CONSTRAINT `fk_procurement_fuel_contract_primary_fuel_approved_by_employee_id` FOREIGN KEY (`primary_fuel_approved_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ADD CONSTRAINT `fk_procurement_fuel_uplift_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ADD CONSTRAINT `fk_procurement_catering_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_primary_spend_requisitioner_employee_id` FOREIGN KEY (`primary_spend_requisitioner_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ADD CONSTRAINT `fk_procurement_ground_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ADD CONSTRAINT `fk_procurement_vendor_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ADD CONSTRAINT `fk_procurement_mro_exchange_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_primary_repair_requestor_employee_id` FOREIGN KEY (`primary_repair_requestor_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_tertiary_savings_finance_validator_employee_id` FOREIGN KEY (`tertiary_savings_finance_validator_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ADD CONSTRAINT `fk_procurement_vendor_audit_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ADD CONSTRAINT `fk_procurement_vendor_authorization_authorized_by_employee_id` FOREIGN KEY (`authorized_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ADD CONSTRAINT `fk_procurement_vendor_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reservation --> airport (16 constraint(s)) =========
-- Requires: reservation schema, airport schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_cdm_message_id` FOREIGN KEY (`cdm_message_id`) REFERENCES `airlines_ecm`.`airport`.`cdm_message`(`cdm_message_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_cdm_message_id` FOREIGN KEY (`cdm_message_id`) REFERENCES `airlines_ecm`.`airport`.`cdm_message`(`cdm_message_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `airlines_ecm`.`airport`.`slot`(`slot_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `airlines_ecm`.`airport`.`turnaround`(`turnaround_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_ramp_service_order_id` FOREIGN KEY (`ramp_service_order_id`) REFERENCES `airlines_ecm`.`airport`.`ramp_service_order`(`ramp_service_order_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `airlines_ecm`.`airport`.`gate`(`gate_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_pfc_record_id` FOREIGN KEY (`pfc_record_id`) REFERENCES `airlines_ecm`.`airport`.`pfc_record`(`pfc_record_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_baggage_item_id` FOREIGN KEY (`baggage_item_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_item`(`baggage_item_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_checkin_session_id` FOREIGN KEY (`checkin_session_id`) REFERENCES `airlines_ecm`.`airport`.`checkin_session`(`checkin_session_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_gate_assignment_id` FOREIGN KEY (`gate_assignment_id`) REFERENCES `airlines_ecm`.`airport`.`gate_assignment`(`gate_assignment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_pfc_record_id` FOREIGN KEY (`pfc_record_id`) REFERENCES `airlines_ecm`.`airport`.`pfc_record`(`pfc_record_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_baggage_item_id` FOREIGN KEY (`baggage_item_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_item`(`baggage_item_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_baggage_irregularity_id` FOREIGN KEY (`baggage_irregularity_id`) REFERENCES `airlines_ecm`.`airport`.`baggage_irregularity`(`baggage_irregularity_id`);

-- ========= reservation --> ancillary (1 constraint(s)) =========
-- Requires: reservation schema, ancillary schema
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ADD CONSTRAINT `fk_reservation_segment_ancillary_purchase_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);

-- ========= reservation --> compliance (7 constraint(s)) =========
-- Requires: reservation schema, compliance schema
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ADD CONSTRAINT `fk_reservation_schedule_change_notification_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= reservation --> crew (1 constraint(s)) =========
-- Requires: reservation schema, crew schema
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= reservation --> finance (3 constraint(s)) =========
-- Requires: reservation schema, finance schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);

-- ========= reservation --> fleet (5 constraint(s)) =========
-- Requires: reservation schema, fleet schema
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_cabin_configuration_id` FOREIGN KEY (`cabin_configuration_id`) REFERENCES `airlines_ecm`.`fleet`.`cabin_configuration`(`cabin_configuration_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ADD CONSTRAINT `fk_reservation_schedule_change_notification_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= reservation --> flight (2 constraint(s)) =========
-- Requires: reservation schema, flight schema
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= reservation --> inventory (3 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_fare_class_bucket_id` FOREIGN KEY (`fare_class_bucket_id`) REFERENCES `airlines_ecm`.`inventory`.`fare_class_bucket`(`fare_class_bucket_id`);

-- ========= reservation --> loyalty (9 constraint(s)) =========
-- Requires: reservation schema, loyalty schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_award_inventory_id` FOREIGN KEY (`award_inventory_id`) REFERENCES `airlines_ecm`.`loyalty`.`award_inventory`(`award_inventory_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_upgrade_request_id` FOREIGN KEY (`upgrade_request_id`) REFERENCES `airlines_ecm`.`loyalty`.`upgrade_request`(`upgrade_request_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ADD CONSTRAINT `fk_reservation_segment_mileage_accrual_mileage_accrual_id` FOREIGN KEY (`mileage_accrual_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_accrual`(`mileage_accrual_id`);

-- ========= reservation --> marketing (5 constraint(s)) =========
-- Requires: reservation schema, marketing schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= reservation --> passenger (9 constraint(s)) =========
-- Requires: reservation schema, passenger schema
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ADD CONSTRAINT `fk_reservation_reservation_booking_passenger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ADD CONSTRAINT `fk_reservation_segment_ancillary_purchase_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= reservation --> procurement (1 constraint(s)) =========
-- Requires: reservation schema, procurement schema
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= reservation --> revenue (8 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_arc_settlement_id` FOREIGN KEY (`arc_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`arc_settlement`(`arc_settlement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_revenue_emd_id` FOREIGN KEY (`revenue_emd_id`) REFERENCES `airlines_ecm`.`revenue`.`revenue_emd`(`revenue_emd_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);

-- ========= reservation --> route (9 constraint(s)) =========
-- Requires: reservation schema, route schema
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ADD CONSTRAINT `fk_reservation_schedule_change_notification_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ADD CONSTRAINT `fk_reservation_schedule_change_notification_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= reservation --> safety (5 constraint(s)) =========
-- Requires: reservation schema, safety schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= reservation --> workforce (15 constraint(s)) =========
-- Requires: reservation schema, workforce schema
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ADD CONSTRAINT `fk_reservation_group_booking_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= revenue --> airport (5 constraint(s)) =========
-- Requires: revenue schema, airport schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ADD CONSTRAINT `fk_revenue_arc_settlement_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= revenue --> ancillary (5 constraint(s)) =========
-- Requires: revenue schema, ancillary schema
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ADD CONSTRAINT `fk_revenue_corporate_ancillary_entitlement_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ADD CONSTRAINT `fk_revenue_revenue_bundle_component_ancillary_bundle_component_id` FOREIGN KEY (`ancillary_bundle_component_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_bundle_component`(`ancillary_bundle_component_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ADD CONSTRAINT `fk_revenue_revenue_bundle_component_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);

-- ========= revenue --> compliance (7 constraint(s)) =========
-- Requires: revenue schema, compliance schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ADD CONSTRAINT `fk_revenue_fare_rule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_consumer_protection_case_id` FOREIGN KEY (`consumer_protection_case_id`) REFERENCES `airlines_ecm`.`compliance`.`consumer_protection_case`(`consumer_protection_case_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ADD CONSTRAINT `fk_revenue_arc_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= revenue --> crew (2 constraint(s)) =========
-- Requires: revenue schema, crew schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= revenue --> finance (20 constraint(s)) =========
-- Requires: revenue schema, finance schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ADD CONSTRAINT `fk_revenue_tax_fee_tax_transaction_id` FOREIGN KEY (`tax_transaction_id`) REFERENCES `airlines_ecm`.`finance`.`tax_transaction`(`tax_transaction_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ADD CONSTRAINT `fk_revenue_bsp_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ADD CONSTRAINT `fk_revenue_arc_settlement_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ADD CONSTRAINT `fk_revenue_arc_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ADD CONSTRAINT `fk_revenue_adm_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ADD CONSTRAINT `fk_revenue_adm_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ADD CONSTRAINT `fk_revenue_revenue_surcharge_tax_transaction_id` FOREIGN KEY (`tax_transaction_id`) REFERENCES `airlines_ecm`.`finance`.`tax_transaction`(`tax_transaction_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= revenue --> fleet (3 constraint(s)) =========
-- Requires: revenue schema, fleet schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);

-- ========= revenue --> flight (3 constraint(s)) =========
-- Requires: revenue schema, flight schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` ADD CONSTRAINT `fk_revenue_bid_price_curve_scheduled_flight_id` FOREIGN KEY (`scheduled_flight_id`) REFERENCES `airlines_ecm`.`flight`.`scheduled_flight`(`scheduled_flight_id`);

-- ========= revenue --> inventory (9 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ADD CONSTRAINT `fk_revenue_fare_class_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_cabin_class_id` FOREIGN KEY (`cabin_class_id`) REFERENCES `airlines_ecm`.`inventory`.`cabin_class`(`cabin_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_inventory_leg_id` FOREIGN KEY (`inventory_leg_id`) REFERENCES `airlines_ecm`.`inventory`.`inventory_leg`(`inventory_leg_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ADD CONSTRAINT `fk_revenue_contract_inventory_allocation_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ADD CONSTRAINT `fk_revenue_fare_applicability_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= revenue --> loyalty (3 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);

-- ========= revenue --> maintenance (3 constraint(s)) =========
-- Requires: revenue schema, maintenance schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= revenue --> marketing (3 constraint(s)) =========
-- Requires: revenue schema, marketing schema
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= revenue --> passenger (6 constraint(s)) =========
-- Requires: revenue schema, passenger schema
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= revenue --> procurement (4 constraint(s)) =========
-- Requires: revenue schema, procurement schema
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_fuel_uplift_order_id` FOREIGN KEY (`fuel_uplift_order_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_uplift_order`(`fuel_uplift_order_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_fuel_uplift_order_id` FOREIGN KEY (`fuel_uplift_order_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_uplift_order`(`fuel_uplift_order_id`);

-- ========= revenue --> reservation (3 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_fare_quote_id` FOREIGN KEY (`fare_quote_id`) REFERENCES `airlines_ecm`.`reservation`.`fare_quote`(`fare_quote_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);

-- ========= revenue --> route (7 constraint(s)) =========
-- Requires: revenue schema, route schema
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ADD CONSTRAINT `fk_revenue_flight_revenue_performance_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= revenue --> safety (2 constraint(s)) =========
-- Requires: revenue schema, safety schema
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= revenue --> workforce (6 constraint(s)) =========
-- Requires: revenue schema, workforce schema
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ADD CONSTRAINT `fk_revenue_corporate_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` ADD CONSTRAINT `fk_revenue_bid_price_curve_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= route --> airport (8 constraint(s)) =========
-- Requires: route schema, airport schema
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ADD CONSTRAINT `fk_route_city_pair_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_slot_allocation` ADD CONSTRAINT `fk_route_route_slot_allocation_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`hub_spoke_topology` ADD CONSTRAINT `fk_route_hub_spoke_topology_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`operational_standard` ADD CONSTRAINT `fk_route_operational_standard_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`route`.`operational_standard` ADD CONSTRAINT `fk_route_operational_standard_origin_station_id` FOREIGN KEY (`origin_station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= route --> compliance (6 constraint(s)) =========
-- Requires: route schema, compliance schema
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_slot_allocation` ADD CONSTRAINT `fk_route_route_slot_allocation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`route`.`bilateral_asa` ADD CONSTRAINT `fk_route_bilateral_asa_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`route`.`authority` ADD CONSTRAINT `fk_route_authority_operating_certificate_id` FOREIGN KEY (`operating_certificate_id`) REFERENCES `airlines_ecm`.`compliance`.`operating_certificate`(`operating_certificate_id`);
ALTER TABLE `airlines_ecm`.`route`.`operational_standard` ADD CONSTRAINT `fk_route_operational_standard_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= route --> finance (15 constraint(s)) =========
-- Requires: route schema, finance schema
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_slot_allocation` ADD CONSTRAINT `fk_route_route_slot_allocation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`partnership` ADD CONSTRAINT `fk_route_partnership_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ADD CONSTRAINT `fk_route_interline_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`ask_plan` ADD CONSTRAINT `fk_route_ask_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`route`.`ask_plan` ADD CONSTRAINT `fk_route_ask_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_performance` ADD CONSTRAINT `fk_route_route_performance_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_performance` ADD CONSTRAINT `fk_route_route_performance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`market_assessment` ADD CONSTRAINT `fk_route_market_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`operational_standard` ADD CONSTRAINT `fk_route_operational_standard_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);

-- ========= route --> fleet (6 constraint(s)) =========
-- Requires: route schema, fleet schema
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`ask_plan` ADD CONSTRAINT `fk_route_ask_plan_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`operational_standard` ADD CONSTRAINT `fk_route_operational_standard_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= route --> loyalty (1 constraint(s)) =========
-- Requires: route schema, loyalty schema
ALTER TABLE `airlines_ecm`.`route`.`route_promotion` ADD CONSTRAINT `fk_route_route_promotion_loyalty_promotion_id` FOREIGN KEY (`loyalty_promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`loyalty_promotion`(`loyalty_promotion_id`);

-- ========= route --> marketing (4 constraint(s)) =========
-- Requires: route schema, marketing schema
ALTER TABLE `airlines_ecm`.`route`.`city_pair` ADD CONSTRAINT `fk_route_city_pair_destination_content_id` FOREIGN KEY (`destination_content_id`) REFERENCES `airlines_ecm`.`marketing`.`destination_content`(`destination_content_id`);
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_destination_content_id` FOREIGN KEY (`destination_content_id`) REFERENCES `airlines_ecm`.`marketing`.`destination_content`(`destination_content_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_performance` ADD CONSTRAINT `fk_route_route_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`route`.`market_assessment` ADD CONSTRAINT `fk_route_market_assessment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= route --> safety (3 constraint(s)) =========
-- Requires: route schema, safety schema
ALTER TABLE `airlines_ecm`.`route`.`hub_spoke_topology` ADD CONSTRAINT `fk_route_hub_spoke_topology_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`route`.`interline_agreement` ADD CONSTRAINT `fk_route_interline_agreement_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);
ALTER TABLE `airlines_ecm`.`route`.`authority` ADD CONSTRAINT `fk_route_authority_occurrence_id` FOREIGN KEY (`occurrence_id`) REFERENCES `airlines_ecm`.`safety`.`occurrence`(`occurrence_id`);

-- ========= route --> workforce (10 constraint(s)) =========
-- Requires: route schema, workforce schema
ALTER TABLE `airlines_ecm`.`route`.`route` ADD CONSTRAINT `fk_route_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`flight_number` ADD CONSTRAINT `fk_route_flight_number_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`seasonal_schedule` ADD CONSTRAINT `fk_route_seasonal_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_slot_allocation` ADD CONSTRAINT `fk_route_route_slot_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`ask_plan` ADD CONSTRAINT `fk_route_ask_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`route_performance` ADD CONSTRAINT `fk_route_route_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`market_assessment` ADD CONSTRAINT `fk_route_market_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`operational_standard` ADD CONSTRAINT `fk_route_operational_standard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`block_time_standard` ADD CONSTRAINT `fk_route_block_time_standard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`route`.`fleet_assignment` ADD CONSTRAINT `fk_route_fleet_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= safety --> compliance (10 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ADD CONSTRAINT `fk_safety_fdr_event_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ADD CONSTRAINT `fk_safety_runway_incursion_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ADD CONSTRAINT `fk_safety_airspace_deviation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`safety`.`case` ADD CONSTRAINT `fk_safety_case_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= safety --> crew (1 constraint(s)) =========
-- Requires: safety schema, crew schema
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ADD CONSTRAINT `fk_safety_fatigue_report_member_id` FOREIGN KEY (`member_id`) REFERENCES `airlines_ecm`.`crew`.`member`(`member_id`);

-- ========= safety --> finance (10 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= safety --> fleet (15 constraint(s)) =========
-- Requires: safety schema, fleet schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ADD CONSTRAINT `fk_safety_fdr_event_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_engine_id` FOREIGN KEY (`engine_id`) REFERENCES `airlines_ecm`.`fleet`.`engine`(`engine_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ADD CONSTRAINT `fk_safety_fatigue_report_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ADD CONSTRAINT `fk_safety_runway_incursion_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ADD CONSTRAINT `fk_safety_airspace_deviation_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft`(`aircraft_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= safety --> flight (5 constraint(s)) =========
-- Requires: safety schema, flight schema
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ADD CONSTRAINT `fk_safety_fdr_event_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`safety`.`runway_incursion` ADD CONSTRAINT `fk_safety_runway_incursion_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`safety`.`airspace_deviation` ADD CONSTRAINT `fk_safety_airspace_deviation_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_flight_leg_id` FOREIGN KEY (`flight_leg_id`) REFERENCES `airlines_ecm`.`flight`.`flight_leg`(`flight_leg_id`);

-- ========= safety --> inventory (2 constraint(s)) =========
-- Requires: safety schema, inventory schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_flight_inventory_id` FOREIGN KEY (`flight_inventory_id`) REFERENCES `airlines_ecm`.`inventory`.`flight_inventory`(`flight_inventory_id`);

-- ========= safety --> marketing (10 constraint(s)) =========
-- Requires: safety schema, marketing schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ADD CONSTRAINT `fk_safety_fatigue_report_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `airlines_ecm`.`marketing`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_destination_content_id` FOREIGN KEY (`destination_content_id`) REFERENCES `airlines_ecm`.`marketing`.`destination_content`(`destination_content_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert_distribution` ADD CONSTRAINT `fk_safety_alert_distribution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `airlines_ecm`.`marketing`.`channel`(`channel_id`);

-- ========= safety --> passenger (1 constraint(s)) =========
-- Requires: safety schema, passenger schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `airlines_ecm`.`passenger`.`profile`(`profile_id`);

-- ========= safety --> procurement (19 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fdr_event` ADD CONSTRAINT `fk_safety_fdr_event_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_repair_order_id` FOREIGN KEY (`repair_order_id`) REFERENCES `airlines_ecm`.`procurement`.`repair_order`(`repair_order_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`safety`.`wildlife_strike` ADD CONSTRAINT `fk_safety_wildlife_strike_repair_order_id` FOREIGN KEY (`repair_order_id`) REFERENCES `airlines_ecm`.`procurement`.`repair_order`(`repair_order_id`);
ALTER TABLE `airlines_ecm`.`safety`.`dangerous_goods_incident` ADD CONSTRAINT `fk_safety_dangerous_goods_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> route (11 constraint(s)) =========
-- Requires: safety schema, route schema
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`occurrence` ADD CONSTRAINT `fk_safety_occurrence_seasonal_schedule_id` FOREIGN KEY (`seasonal_schedule_id`) REFERENCES `airlines_ecm`.`route`.`seasonal_schedule`(`seasonal_schedule_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`recommendation` ADD CONSTRAINT `fk_safety_recommendation_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ADD CONSTRAINT `fk_safety_fatigue_report_flight_number_id` FOREIGN KEY (`flight_number_id`) REFERENCES `airlines_ecm`.`route`.`flight_number`(`flight_number_id`);
ALTER TABLE `airlines_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);
ALTER TABLE `airlines_ecm`.`safety`.`case` ADD CONSTRAINT `fk_safety_case_route_id` FOREIGN KEY (`route_id`) REFERENCES `airlines_ecm`.`route`.`route`(`route_id`);

-- ========= safety --> workforce (16 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_hazard_employee_id` FOREIGN KEY (`hazard_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`hazard` ADD CONSTRAINT `fk_safety_hazard_hazard_reported_by_employee_id` FOREIGN KEY (`hazard_reported_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`report` ADD CONSTRAINT `fk_safety_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`investigation` ADD CONSTRAINT `fk_safety_investigation_investigation_modified_by_user_employee_id` FOREIGN KEY (`investigation_modified_by_user_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`fatigue_report` ADD CONSTRAINT `fk_safety_fatigue_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`spi_measurement` ADD CONSTRAINT `fk_safety_spi_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`case` ADD CONSTRAINT `fk_safety_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`case` ADD CONSTRAINT `fk_safety_case_case_prepared_by_employee_id` FOREIGN KEY (`case_prepared_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`committee` ADD CONSTRAINT `fk_safety_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`safety`.`committee` ADD CONSTRAINT `fk_safety_committee_committee_employee_id` FOREIGN KEY (`committee_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> airport (3 constraint(s)) =========
-- Requires: workforce schema, airport schema
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_station_id` FOREIGN KEY (`station_id`) REFERENCES `airlines_ecm`.`airport`.`station`(`station_id`);

-- ========= workforce --> crew (2 constraint(s)) =========
-- Requires: workforce schema, crew schema
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ADD CONSTRAINT `fk_workforce_medical_compliance_medical_certificate_id` FOREIGN KEY (`medical_certificate_id`) REFERENCES `airlines_ecm`.`crew`.`medical_certificate`(`medical_certificate_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ADD CONSTRAINT `fk_workforce_licence_compliance_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `airlines_ecm`.`crew`.`licence`(`licence_id`);

-- ========= workforce --> finance (4 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ADD CONSTRAINT `fk_workforce_position_budget_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `airlines_ecm`.`finance`.`budget_plan`(`budget_plan_id`);

-- ========= workforce --> fleet (1 constraint(s)) =========
-- Requires: workforce schema, fleet schema
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ADD CONSTRAINT `fk_workforce_type_rating_aircraft_type_id` FOREIGN KEY (`aircraft_type_id`) REFERENCES `airlines_ecm`.`fleet`.`aircraft_type`(`aircraft_type_id`);

-- ========= workforce --> procurement (2 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ADD CONSTRAINT `fk_workforce_category_responsibility_category_procurement_category_id` FOREIGN KEY (`category_procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ADD CONSTRAINT `fk_workforce_category_responsibility_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);

