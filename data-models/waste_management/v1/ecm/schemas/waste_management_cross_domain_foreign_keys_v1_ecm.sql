-- Cross-Domain Foreign Keys for Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:59
-- Total cross-domain FK constraints: 1839
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, collection, compliance, contract, customer, energy, fleet, hazmat, landfill, maintenance, procurement, recycling, safety, service, sustainability, workforce

-- ========= asset --> collection (5 constraint(s)) =========
-- Requires: asset schema, collection schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_read_event` ADD CONSTRAINT `fk_asset_rfid_read_event_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_read_event` ADD CONSTRAINT `fk_asset_rfid_read_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= asset --> customer (8 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_read_event` ADD CONSTRAINT `fk_asset_rfid_read_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_read_event` ADD CONSTRAINT `fk_asset_rfid_read_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility_access_authorization` ADD CONSTRAINT `fk_asset_facility_access_authorization_account_customer_account_id` FOREIGN KEY (`account_customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility_access_authorization` ADD CONSTRAINT `fk_asset_facility_access_authorization_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= asset --> fleet (5 constraint(s)) =========
-- Requires: asset schema, fleet schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_read_event` ADD CONSTRAINT `fk_asset_rfid_read_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_read_event` ADD CONSTRAINT `fk_asset_rfid_read_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= asset --> hazmat (1 constraint(s)) =========
-- Requires: asset schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);

-- ========= asset --> maintenance (6 constraint(s)) =========
-- Requires: asset schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`condition_history` ADD CONSTRAINT `fk_asset_condition_history_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`budget_line_item` ADD CONSTRAINT `fk_asset_budget_line_item_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `waste_management_ecm`.`maintenance`.`budget`(`budget_id`);

-- ========= asset --> procurement (7 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ADD CONSTRAINT `fk_asset_lease_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ADD CONSTRAINT `fk_asset_capital_project_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ADD CONSTRAINT `fk_asset_container_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`budget_line_item` ADD CONSTRAINT `fk_asset_budget_line_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= asset --> safety (3 constraint(s)) =========
-- Requires: asset schema, safety schema
ALTER TABLE `waste_management_ecm`.`asset`.`facility_safety_program_implementation` ADD CONSTRAINT `fk_asset_facility_safety_program_implementation_program_safety_program_id` FOREIGN KEY (`program_safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility_safety_program_implementation` ADD CONSTRAINT `fk_asset_facility_safety_program_implementation_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`safety_compliance` ADD CONSTRAINT `fk_asset_safety_compliance_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);

-- ========= asset --> sustainability (1 constraint(s)) =========
-- Requires: asset schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);

-- ========= asset --> workforce (25 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ADD CONSTRAINT `fk_asset_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ADD CONSTRAINT `fk_asset_facility_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`depreciation_posting` ADD CONSTRAINT `fk_asset_depreciation_posting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_retirement_initiated_by_employee_id` FOREIGN KEY (`retirement_initiated_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_retirement_processed_by_employee_id` FOREIGN KEY (`retirement_processed_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_transfer_requested_by_employee_id` FOREIGN KEY (`transfer_requested_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ADD CONSTRAINT `fk_asset_rfid_tag_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ADD CONSTRAINT `fk_asset_rfid_tag_primary_rfid_installed_by_employee_id` FOREIGN KEY (`primary_rfid_installed_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ADD CONSTRAINT `fk_asset_lease_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ADD CONSTRAINT `fk_asset_capital_project_expenditure_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ADD CONSTRAINT `fk_asset_capital_project_expenditure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`condition_history` ADD CONSTRAINT `fk_asset_condition_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`utilization` ADD CONSTRAINT `fk_asset_utilization_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility_access_authorization` ADD CONSTRAINT `fk_asset_facility_access_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility_safety_program_implementation` ADD CONSTRAINT `fk_asset_facility_safety_program_implementation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`safety_compliance` ADD CONSTRAINT `fk_asset_safety_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`safety_compliance` ADD CONSTRAINT `fk_asset_safety_compliance_responsible_employee_id` FOREIGN KEY (`responsible_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`strategic_initiative` ADD CONSTRAINT `fk_asset_strategic_initiative_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`budget_line_item` ADD CONSTRAINT `fk_asset_budget_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`budget_line_item` ADD CONSTRAINT `fk_asset_budget_line_item_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= billing --> asset (12 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);

-- ========= billing --> collection (26 constraint(s)) =========
-- Requires: billing schema, collection schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_container_placement_id` FOREIGN KEY (`container_placement_id`) REFERENCES `waste_management_ecm`.`collection`.`container_placement`(`container_placement_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_haul_manifest_id` FOREIGN KEY (`haul_manifest_id`) REFERENCES `waste_management_ecm`.`collection`.`haul_manifest`(`haul_manifest_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_on_demand_request_id` FOREIGN KEY (`on_demand_request_id`) REFERENCES `waste_management_ecm`.`collection`.`on_demand_request`(`on_demand_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_outbound_haul_id` FOREIGN KEY (`outbound_haul_id`) REFERENCES `waste_management_ecm`.`collection`.`outbound_haul`(`outbound_haul_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_scale_transaction_id` FOREIGN KEY (`scale_transaction_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_transaction`(`scale_transaction_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tipping_fee_rate_id` FOREIGN KEY (`tipping_fee_rate_id`) REFERENCES `waste_management_ecm`.`collection`.`tipping_fee_rate`(`tipping_fee_rate_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_exception_id` FOREIGN KEY (`service_exception_id`) REFERENCES `waste_management_ecm`.`collection`.`service_exception`(`service_exception_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_container_rfid_scan_id` FOREIGN KEY (`container_rfid_scan_id`) REFERENCES `waste_management_ecm`.`collection`.`container_rfid_scan`(`container_rfid_scan_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_scale_transaction_id` FOREIGN KEY (`scale_transaction_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_transaction`(`scale_transaction_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= billing --> compliance (8 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= billing --> contract (14 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `waste_management_ecm`.`contract`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_contract_service_commitment_id` FOREIGN KEY (`contract_service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`contract_service_commitment`(`contract_service_commitment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_contract_service_commitment_id` FOREIGN KEY (`contract_service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`contract_service_commitment`(`contract_service_commitment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`prepayment` ADD CONSTRAINT `fk_billing_prepayment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= billing --> customer (19 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ADD CONSTRAINT `fk_billing_ar_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `waste_management_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `waste_management_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`prepayment` ADD CONSTRAINT `fk_billing_prepayment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= billing --> fleet (4 constraint(s)) =========
-- Requires: billing schema, fleet schema
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= billing --> procurement (1 constraint(s)) =========
-- Requires: billing schema, procurement schema
ALTER TABLE `waste_management_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= billing --> recycling (7 constraint(s)) =========
-- Requires: billing schema, recycling schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_commodity_sale_id` FOREIGN KEY (`commodity_sale_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity_sale`(`commodity_sale_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bale_id` FOREIGN KEY (`bale_id`) REFERENCES `waste_management_ecm`.`recycling`.`bale`(`bale_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_residue_disposal_id` FOREIGN KEY (`residue_disposal_id`) REFERENCES `waste_management_ecm`.`recycling`.`residue_disposal`(`residue_disposal_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_contamination_event_id` FOREIGN KEY (`contamination_event_id`) REFERENCES `waste_management_ecm`.`recycling`.`contamination_event`(`contamination_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_commodity_sale_id` FOREIGN KEY (`commodity_sale_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity_sale`(`commodity_sale_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);

-- ========= billing --> safety (1 constraint(s)) =========
-- Requires: billing schema, safety schema
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);

-- ========= billing --> service (8 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);

-- ========= billing --> sustainability (10 constraint(s)) =========
-- Requires: billing schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`usage_event` ADD CONSTRAINT `fk_billing_usage_event_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_program_enrollment` ADD CONSTRAINT `fk_billing_billing_program_enrollment_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_program_enrollment` ADD CONSTRAINT `fk_billing_billing_program_enrollment_sustainability_program_enrollment_id` FOREIGN KEY (`sustainability_program_enrollment_id`) REFERENCES `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment`(`sustainability_program_enrollment_id`);

-- ========= billing --> workforce (30 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_tertiary_payment_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_payment_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_cycle_last_modified_by_user_employee_id` FOREIGN KEY (`cycle_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_run_employee_id` FOREIGN KEY (`run_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_employee_id` FOREIGN KEY (`adjustment_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_dispute_employee_id` FOREIGN KEY (`dispute_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_dispute_escalated_to_manager_employee_id` FOREIGN KEY (`dispute_escalated_to_manager_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_quaternary_payment_modified_by_user_employee_id` FOREIGN KEY (`quaternary_payment_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_tertiary_payment_created_by_user_employee_id` FOREIGN KEY (`tertiary_payment_created_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_surcharge_employee_id` FOREIGN KEY (`surcharge_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_surcharge_last_modified_by_user_employee_id` FOREIGN KEY (`surcharge_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ADD CONSTRAINT `fk_billing_tax_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_tertiary_write_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_write_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`prepayment` ADD CONSTRAINT `fk_billing_prepayment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`prepayment` ADD CONSTRAINT `fk_billing_prepayment_prepayment_employee_id` FOREIGN KEY (`prepayment_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`prepayment` ADD CONSTRAINT `fk_billing_prepayment_prepayment_last_modified_by_user_employee_id` FOREIGN KEY (`prepayment_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_voided_by_user_employee_id` FOREIGN KEY (`voided_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= collection --> asset (23 constraint(s)) =========
-- Requires: collection schema, asset schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_transfer_outbound_disposal_facility_id` FOREIGN KEY (`transfer_outbound_disposal_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ADD CONSTRAINT `fk_collection_environmental_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= collection --> compliance (21 constraint(s)) =========
-- Requires: collection schema, compliance schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_air_emission_event_id` FOREIGN KEY (`air_emission_event_id`) REFERENCES `waste_management_ecm`.`compliance`.`air_emission_event`(`air_emission_event_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_spill_release_id` FOREIGN KEY (`spill_release_id`) REFERENCES `waste_management_ecm`.`compliance`.`spill_release`(`spill_release_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ADD CONSTRAINT `fk_collection_scale_equipment_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ADD CONSTRAINT `fk_collection_hauler_account_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ADD CONSTRAINT `fk_collection_operating_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ADD CONSTRAINT `fk_collection_collection_environmental_monitoring_compliance_environmental_monitoring_id` FOREIGN KEY (`compliance_environmental_monitoring_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring`(`compliance_environmental_monitoring_id`);

-- ========= collection --> contract (14 constraint(s)) =========
-- Requires: collection schema, contract schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ADD CONSTRAINT `fk_collection_operating_permit_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);

-- ========= collection --> customer (20 constraint(s)) =========
-- Requires: collection schema, customer schema
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `waste_management_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= collection --> energy (6 constraint(s)) =========
-- Requires: collection schema, energy schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= collection --> fleet (34 constraint(s)) =========
-- Requires: collection schema, fleet schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_primary_container_removal_driver_id` FOREIGN KEY (`primary_container_removal_driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_primary_container_removal_vehicle_id` FOREIGN KEY (`primary_container_removal_vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ADD CONSTRAINT `fk_collection_compaction_measurement_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ADD CONSTRAINT `fk_collection_compaction_measurement_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= collection --> hazmat (15 constraint(s)) =========
-- Requires: collection schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_emergency_response_incident_id` FOREIGN KEY (`emergency_response_incident_id`) REFERENCES `waste_management_ecm`.`hazmat`.`emergency_response_incident`(`emergency_response_incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_hazwoper_training_id` FOREIGN KEY (`hazwoper_training_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazwoper_training`(`hazwoper_training_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ADD CONSTRAINT `fk_collection_hauler_account_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ADD CONSTRAINT `fk_collection_hazmat_service_schedule_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ADD CONSTRAINT `fk_collection_station_waste_code_permit_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);

-- ========= collection --> landfill (8 constraint(s)) =========
-- Requires: collection schema, landfill schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ADD CONSTRAINT `fk_collection_hauler_site_authorization_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ADD CONSTRAINT `fk_collection_disposal_routing_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ADD CONSTRAINT `fk_collection_environmental_sample_monitoring_point_id` FOREIGN KEY (`monitoring_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`monitoring_point`(`monitoring_point_id`);

-- ========= collection --> maintenance (7 constraint(s)) =========
-- Requires: collection schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_primary_container_removal_work_order_id` FOREIGN KEY (`primary_container_removal_work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ADD CONSTRAINT `fk_collection_scale_equipment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ADD CONSTRAINT `fk_collection_scale_equipment_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);

-- ========= collection --> procurement (12 constraint(s)) =========
-- Requires: collection schema, procurement schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_fuel_purchase_id` FOREIGN KEY (`fuel_purchase_id`) REFERENCES `waste_management_ecm`.`procurement`.`fuel_purchase`(`fuel_purchase_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_fuel_purchase_id` FOREIGN KEY (`fuel_purchase_id`) REFERENCES `waste_management_ecm`.`procurement`.`fuel_purchase`(`fuel_purchase_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_fuel_purchase_id` FOREIGN KEY (`fuel_purchase_id`) REFERENCES `waste_management_ecm`.`procurement`.`fuel_purchase`(`fuel_purchase_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ADD CONSTRAINT `fk_collection_hauler_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= collection --> recycling (3 constraint(s)) =========
-- Requires: collection schema, recycling schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);

-- ========= collection --> safety (11 constraint(s)) =========
-- Requires: collection schema, safety schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `waste_management_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `waste_management_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ADD CONSTRAINT `fk_collection_scale_equipment_lockout_tagout_procedure_id` FOREIGN KEY (`lockout_tagout_procedure_id`) REFERENCES `waste_management_ecm`.`safety`.`lockout_tagout_procedure`(`lockout_tagout_procedure_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ADD CONSTRAINT `fk_collection_scale_equipment_loto_execution_id` FOREIGN KEY (`loto_execution_id`) REFERENCES `waste_management_ecm`.`safety`.`loto_execution`(`loto_execution_id`);

-- ========= collection --> service (13 constraint(s)) =========
-- Requires: collection schema, service schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ADD CONSTRAINT `fk_collection_route_optimization_run_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ADD CONSTRAINT `fk_collection_compaction_measurement_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= collection --> sustainability (10 constraint(s)) =========
-- Requires: collection schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ADD CONSTRAINT `fk_collection_route_optimization_run_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ADD CONSTRAINT `fk_collection_compaction_measurement_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ADD CONSTRAINT `fk_collection_district_program_participation_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);

-- ========= collection --> workforce (33 constraint(s)) =========
-- Requires: collection schema, workforce schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ADD CONSTRAINT `fk_collection_route_optimization_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_district_operations_manager_employee_id` FOREIGN KEY (`district_operations_manager_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_tertiary_tipping_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_tipping_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ADD CONSTRAINT `fk_collection_hauler_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ADD CONSTRAINT `fk_collection_shift_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ADD CONSTRAINT `fk_collection_haul_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ADD CONSTRAINT `fk_collection_haul_rate_tertiary_haul_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_haul_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ADD CONSTRAINT `fk_collection_collection_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ADD CONSTRAINT `fk_collection_route_driver_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ADD CONSTRAINT `fk_collection_route_driver_qualification_qualification_verified_by_employee_id` FOREIGN KEY (`qualification_verified_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ADD CONSTRAINT `fk_collection_district_program_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ADD CONSTRAINT `fk_collection_facility_staffing_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ADD CONSTRAINT `fk_collection_environmental_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> asset (20 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ADD CONSTRAINT `fk_compliance_monitoring_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ADD CONSTRAINT `fk_compliance_monitoring_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ADD CONSTRAINT `fk_compliance_scheduled_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ADD CONSTRAINT `fk_compliance_chemical_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ADD CONSTRAINT `fk_compliance_ghg_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ADD CONSTRAINT `fk_compliance_regulated_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ADD CONSTRAINT `fk_compliance_monitoring_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ADD CONSTRAINT `fk_compliance_environmental_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= compliance --> fleet (1 constraint(s)) =========
-- Requires: compliance schema, fleet schema
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= compliance --> hazmat (1 constraint(s)) =========
-- Requires: compliance schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ADD CONSTRAINT `fk_compliance_chemical_inventory_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);

-- ========= compliance --> procurement (14 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ADD CONSTRAINT `fk_compliance_monitoring_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ADD CONSTRAINT `fk_compliance_training_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ADD CONSTRAINT `fk_compliance_chemical_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);

-- ========= compliance --> safety (14 constraint(s)) =========
-- Requires: compliance schema, safety schema
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_emergency_action_plan_id` FOREIGN KEY (`emergency_action_plan_id`) REFERENCES `waste_management_ecm`.`safety`.`emergency_action_plan`(`emergency_action_plan_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_emergency_action_plan_id` FOREIGN KEY (`emergency_action_plan_id`) REFERENCES `waste_management_ecm`.`safety`.`emergency_action_plan`(`emergency_action_plan_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ADD CONSTRAINT `fk_compliance_chemical_inventory_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);

-- ========= compliance --> sustainability (8 constraint(s)) =========
-- Requires: compliance schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ADD CONSTRAINT `fk_compliance_scheduled_obligation_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ADD CONSTRAINT `fk_compliance_chemical_inventory_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ADD CONSTRAINT `fk_compliance_ghg_regulatory_submission_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);

-- ========= compliance --> workforce (16 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_tertiary_regulatory_submitted_by_employee_id` FOREIGN KEY (`tertiary_regulatory_submitted_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ADD CONSTRAINT `fk_compliance_training_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ADD CONSTRAINT `fk_compliance_scheduled_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ADD CONSTRAINT `fk_compliance_audit_program_primary_lead_auditor_employee_id` FOREIGN KEY (`primary_lead_auditor_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ADD CONSTRAINT `fk_compliance_ghg_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ADD CONSTRAINT `fk_compliance_environmental_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= contract --> asset (11 constraint(s)) =========
-- Requires: contract schema, asset schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_origin_facility_id` FOREIGN KEY (`origin_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= contract --> billing (2 constraint(s)) =========
-- Requires: contract schema, billing schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ADD CONSTRAINT `fk_contract_rate_line_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= contract --> collection (2 constraint(s)) =========
-- Requires: contract schema, collection schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);

-- ========= contract --> compliance (11 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_scheduled_obligation_id` FOREIGN KEY (`scheduled_obligation_id`) REFERENCES `waste_management_ecm`.`compliance`.`scheduled_obligation`(`scheduled_obligation_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_scheduled_obligation_id` FOREIGN KEY (`scheduled_obligation_id`) REFERENCES `waste_management_ecm`.`compliance`.`scheduled_obligation`(`scheduled_obligation_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ADD CONSTRAINT `fk_contract_franchise_requirement_compliance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= contract --> customer (9 constraint(s)) =========
-- Requires: contract schema, customer schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);

-- ========= contract --> landfill (2 constraint(s)) =========
-- Requires: contract schema, landfill schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);

-- ========= contract --> procurement (1 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= contract --> safety (6 constraint(s)) =========
-- Requires: contract schema, safety schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);

-- ========= contract --> service (13 constraint(s)) =========
-- Requires: contract schema, service schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ADD CONSTRAINT `fk_contract_service_area_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);

-- ========= contract --> sustainability (7 constraint(s)) =========
-- Requires: contract schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `waste_management_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);

-- ========= contract --> workforce (8 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_renewal_approved_by_employee_id` FOREIGN KEY (`renewal_approved_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ADD CONSTRAINT `fk_contract_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ADD CONSTRAINT `fk_contract_lifecycle_event_primary_lifecycle_employee_id` FOREIGN KEY (`primary_lifecycle_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> asset (9 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= customer --> billing (3 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> collection (18 constraint(s)) =========
-- Requires: customer schema, collection schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_suspension` ADD CONSTRAINT `fk_customer_service_suspension_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_event` ADD CONSTRAINT `fk_customer_service_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_stop` ADD CONSTRAINT `fk_customer_customer_stop_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_stop` ADD CONSTRAINT `fk_customer_customer_stop_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);

-- ========= customer --> compliance (7 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);

-- ========= customer --> contract (15 constraint(s)) =========
-- Requires: customer schema, contract schema
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_suspension` ADD CONSTRAINT `fk_customer_service_suspension_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`sla_assignment` ADD CONSTRAINT `fk_customer_sla_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_buyer_contract` ADD CONSTRAINT `fk_customer_customer_buyer_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_service_commitment` ADD CONSTRAINT `fk_customer_customer_service_commitment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_service_commitment` ADD CONSTRAINT `fk_customer_customer_service_commitment_contract_service_commitment_id` FOREIGN KEY (`contract_service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`contract_service_commitment`(`contract_service_commitment_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`contact_contract_role` ADD CONSTRAINT `fk_customer_contact_contract_role_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= customer --> energy (6 constraint(s)) =========
-- Requires: customer schema, energy schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`facility_allocation_agreement` ADD CONSTRAINT `fk_customer_facility_allocation_agreement_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= customer --> fleet (7 constraint(s)) =========
-- Requires: customer schema, fleet schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_event` ADD CONSTRAINT `fk_customer_service_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_event` ADD CONSTRAINT `fk_customer_service_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= customer --> hazmat (13 constraint(s)) =========
-- Requires: customer schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_emergency_response_incident_id` FOREIGN KEY (`emergency_response_incident_id`) REFERENCES `waste_management_ecm`.`hazmat`.`emergency_response_incident`(`emergency_response_incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_emergency_response_incident_id` FOREIGN KEY (`emergency_response_incident_id`) REFERENCES `waste_management_ecm`.`hazmat`.`emergency_response_incident`(`emergency_response_incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`transporter_authorization` ADD CONSTRAINT `fk_customer_transporter_authorization_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);

-- ========= customer --> landfill (3 constraint(s)) =========
-- Requires: customer schema, landfill schema
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= customer --> maintenance (7 constraint(s)) =========
-- Requires: customer schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_type_id` FOREIGN KEY (`type_id`) REFERENCES `waste_management_ecm`.`maintenance`.`type`(`type_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= customer --> recycling (9 constraint(s)) =========
-- Requires: customer schema, recycling schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_recycling_program_id` FOREIGN KEY (`recycling_program_id`) REFERENCES `waste_management_ecm`.`recycling`.`recycling_program`(`recycling_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_recycling_program_id` FOREIGN KEY (`recycling_program_id`) REFERENCES `waste_management_ecm`.`recycling`.`recycling_program`(`recycling_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_contamination_event_id` FOREIGN KEY (`contamination_event_id`) REFERENCES `waste_management_ecm`.`recycling`.`contamination_event`(`contamination_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_recycling_program_id` FOREIGN KEY (`recycling_program_id`) REFERENCES `waste_management_ecm`.`recycling`.`recycling_program`(`recycling_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_suspension` ADD CONSTRAINT `fk_customer_service_suspension_contamination_event_id` FOREIGN KEY (`contamination_event_id`) REFERENCES `waste_management_ecm`.`recycling`.`contamination_event`(`contamination_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_contamination_event_id` FOREIGN KEY (`contamination_event_id`) REFERENCES `waste_management_ecm`.`recycling`.`contamination_event`(`contamination_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_buyer_contract` ADD CONSTRAINT `fk_customer_customer_buyer_contract_commodity_buyer_id` FOREIGN KEY (`commodity_buyer_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity_buyer`(`commodity_buyer_id`);

-- ========= customer --> safety (12 constraint(s)) =========
-- Requires: customer schema, safety schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `waste_management_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);

-- ========= customer --> service (7 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= customer --> sustainability (2 constraint(s)) =========
-- Requires: customer schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_sustainability_program_enrollment_id` FOREIGN KEY (`sustainability_program_enrollment_id`) REFERENCES `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment`(`sustainability_program_enrollment_id`);

-- ========= customer --> workforce (19 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`nps_response` ADD CONSTRAINT `fk_customer_nps_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_lead_employee_id` FOREIGN KEY (`lead_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_tertiary_account_acknowledged_by_employee_id` FOREIGN KEY (`tertiary_account_acknowledged_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_suspension` ADD CONSTRAINT `fk_customer_service_suspension_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`referral` ADD CONSTRAINT `fk_customer_referral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`contact_contract_role` ADD CONSTRAINT `fk_customer_contact_contract_role_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= energy --> asset (31 constraint(s)) =========
-- Requires: energy schema, asset schema
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ADD CONSTRAINT `fk_energy_boiler_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ADD CONSTRAINT `fk_energy_boiler_unit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ADD CONSTRAINT `fk_energy_turbine_generator_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ADD CONSTRAINT `fk_energy_turbine_generator_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ADD CONSTRAINT `fk_energy_lfg_collection_system_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `waste_management_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ADD CONSTRAINT `fk_energy_lfg_collection_system_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ADD CONSTRAINT `fk_energy_rng_processing_unit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ADD CONSTRAINT `fk_energy_rng_processing_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ADD CONSTRAINT `fk_energy_srf_production_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ADD CONSTRAINT `fk_energy_srf_production_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_receiving_facility_id` FOREIGN KEY (`receiving_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ADD CONSTRAINT `fk_energy_rec_issuance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ADD CONSTRAINT `fk_energy_offtake_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ADD CONSTRAINT `fk_energy_delivery_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ADD CONSTRAINT `fk_energy_cems_instrument_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ADD CONSTRAINT `fk_energy_cems_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ADD CONSTRAINT `fk_energy_energy_rate_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ADD CONSTRAINT `fk_energy_rec_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ADD CONSTRAINT `fk_energy_lcfs_credit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` ADD CONSTRAINT `fk_energy_ash_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= energy --> billing (4 constraint(s)) =========
-- Requires: energy schema, billing schema
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ADD CONSTRAINT `fk_energy_offtake_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ADD CONSTRAINT `fk_energy_delivery_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ADD CONSTRAINT `fk_energy_rec_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= energy --> collection (1 constraint(s)) =========
-- Requires: energy schema, collection schema
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_scale_equipment_id` FOREIGN KEY (`scale_equipment_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_equipment`(`scale_equipment_id`);

-- ========= energy --> compliance (22 constraint(s)) =========
-- Requires: energy schema, compliance schema
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ADD CONSTRAINT `fk_energy_wte_facility_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ADD CONSTRAINT `fk_energy_turbine_generator_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ADD CONSTRAINT `fk_energy_lfg_collection_system_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ADD CONSTRAINT `fk_energy_srf_production_line_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_compliance_environmental_monitoring_id` FOREIGN KEY (`compliance_environmental_monitoring_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring`(`compliance_environmental_monitoring_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_ghg_regulatory_submission_id` FOREIGN KEY (`ghg_regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`ghg_regulatory_submission`(`ghg_regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_air_emission_event_id` FOREIGN KEY (`air_emission_event_id`) REFERENCES `waste_management_ecm`.`compliance`.`air_emission_event`(`air_emission_event_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_spill_release_id` FOREIGN KEY (`spill_release_id`) REFERENCES `waste_management_ecm`.`compliance`.`spill_release`(`spill_release_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ADD CONSTRAINT `fk_energy_rec_issuance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_ghg_regulatory_submission_id` FOREIGN KEY (`ghg_regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`ghg_regulatory_submission`(`ghg_regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ADD CONSTRAINT `fk_energy_cems_instrument_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ADD CONSTRAINT `fk_energy_ghg_emission_factor_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` ADD CONSTRAINT `fk_energy_ash_sample_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= energy --> contract (11 constraint(s)) =========
-- Requires: energy schema, contract schema
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ADD CONSTRAINT `fk_energy_lfg_collection_system_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ADD CONSTRAINT `fk_energy_rng_processing_unit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ADD CONSTRAINT `fk_energy_srf_production_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ADD CONSTRAINT `fk_energy_rec_issuance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ADD CONSTRAINT `fk_energy_offtake_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ADD CONSTRAINT `fk_energy_delivery_party_id` FOREIGN KEY (`party_id`) REFERENCES `waste_management_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ADD CONSTRAINT `fk_energy_rec_transaction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ADD CONSTRAINT `fk_energy_lcfs_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= energy --> customer (3 constraint(s)) =========
-- Requires: energy schema, customer schema
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);

-- ========= energy --> fleet (1 constraint(s)) =========
-- Requires: energy schema, fleet schema
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= energy --> hazmat (5 constraint(s)) =========
-- Requires: energy schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ADD CONSTRAINT `fk_energy_wte_facility_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_tclp_test_id` FOREIGN KEY (`tclp_test_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tclp_test`(`tclp_test_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);

-- ========= energy --> landfill (4 constraint(s)) =========
-- Requires: energy schema, landfill schema
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ADD CONSTRAINT `fk_energy_lfg_collection_system_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_lfg_extraction_well_id` FOREIGN KEY (`lfg_extraction_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`lfg_extraction_well`(`lfg_extraction_well_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= energy --> maintenance (1 constraint(s)) =========
-- Requires: energy schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= energy --> procurement (7 constraint(s)) =========
-- Requires: energy schema, procurement schema
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ADD CONSTRAINT `fk_energy_offtake_agreement_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= energy --> sustainability (12 constraint(s)) =========
-- Requires: energy schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ADD CONSTRAINT `fk_energy_boiler_unit_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ADD CONSTRAINT `fk_energy_lfg_collection_system_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ADD CONSTRAINT `fk_energy_rng_processing_unit_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_lfg_capture_id` FOREIGN KEY (`lfg_capture_id`) REFERENCES `waste_management_ecm`.`sustainability`.`lfg_capture`(`lfg_capture_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ADD CONSTRAINT `fk_energy_rec_issuance_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ADD CONSTRAINT `fk_energy_rec_issuance_renewable_energy_credit_id` FOREIGN KEY (`renewable_energy_credit_id`) REFERENCES `waste_management_ecm`.`sustainability`.`renewable_energy_credit`(`renewable_energy_credit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ADD CONSTRAINT `fk_energy_ghg_emission_factor_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ADD CONSTRAINT `fk_energy_rec_transaction_renewable_energy_credit_id` FOREIGN KEY (`renewable_energy_credit_id`) REFERENCES `waste_management_ecm`.`sustainability`.`renewable_energy_credit`(`renewable_energy_credit_id`);

-- ========= energy --> workforce (9 constraint(s)) =========
-- Requires: energy schema, workforce schema
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ADD CONSTRAINT `fk_energy_tipping_fee_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);

-- ========= fleet --> asset (10 constraint(s)) =========
-- Requires: fleet schema, asset schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ADD CONSTRAINT `fk_fleet_vehicle_lifecycle_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `waste_management_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ADD CONSTRAINT `fk_fleet_fleet_insurance_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ADD CONSTRAINT `fk_fleet_fueling_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ADD CONSTRAINT `fk_fleet_geofence_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= fleet --> collection (13 constraint(s)) =========
-- Requires: fleet schema, collection schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_transfer_trailer_id` FOREIGN KEY (`transfer_trailer_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_trailer`(`transfer_trailer_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ADD CONSTRAINT `fk_fleet_driver_behavior_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ADD CONSTRAINT `fk_fleet_vehicle_lifecycle_event_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ADD CONSTRAINT `fk_fleet_vehicle_lifecycle_event_tertiary_vehicle_transfer_to_district_id` FOREIGN KEY (`tertiary_vehicle_transfer_to_district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);

-- ========= fleet --> compliance (9 constraint(s)) =========
-- Requires: fleet schema, compliance schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ADD CONSTRAINT `fk_fleet_vehicle_registration_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_training_certification_id` FOREIGN KEY (`training_certification_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_certification`(`training_certification_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_air_emission_event_id` FOREIGN KEY (`air_emission_event_id`) REFERENCES `waste_management_ecm`.`compliance`.`air_emission_event`(`air_emission_event_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ADD CONSTRAINT `fk_fleet_drug_alcohol_test_training_certification_id` FOREIGN KEY (`training_certification_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_certification`(`training_certification_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ADD CONSTRAINT `fk_fleet_fleet_insurance_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= fleet --> contract (6 constraint(s)) =========
-- Requires: fleet schema, contract schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ADD CONSTRAINT `fk_fleet_geofence_zone_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `waste_management_ecm`.`contract`.`service_area`(`service_area_id`);

-- ========= fleet --> energy (6 constraint(s)) =========
-- Requires: fleet schema, energy schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= fleet --> hazmat (2 constraint(s)) =========
-- Requires: fleet schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);

-- ========= fleet --> maintenance (4 constraint(s)) =========
-- Requires: fleet schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_service_checklist_template_id` FOREIGN KEY (`service_checklist_template_id`) REFERENCES `waste_management_ecm`.`maintenance`.`service_checklist_template`(`service_checklist_template_id`);

-- ========= fleet --> procurement (6 constraint(s)) =========
-- Requires: fleet schema, procurement schema
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_fuel_purchase_id` FOREIGN KEY (`fuel_purchase_id`) REFERENCES `waste_management_ecm`.`procurement`.`fuel_purchase`(`fuel_purchase_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ADD CONSTRAINT `fk_fleet_drug_alcohol_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ADD CONSTRAINT `fk_fleet_fleet_insurance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= fleet --> safety (3 constraint(s)) =========
-- Requires: fleet schema, safety schema
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `waste_management_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);

-- ========= fleet --> service (3 constraint(s)) =========
-- Requires: fleet schema, service schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= fleet --> sustainability (4 constraint(s)) =========
-- Requires: fleet schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ADD CONSTRAINT `fk_fleet_vehicle_lifecycle_event_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ADD CONSTRAINT `fk_fleet_driver_initiative_participation_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);

-- ========= fleet --> workforce (16 constraint(s)) =========
-- Requires: fleet schema, workforce schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ADD CONSTRAINT `fk_fleet_driver_behavior_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ADD CONSTRAINT `fk_fleet_driver_behavior_event_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ADD CONSTRAINT `fk_fleet_drug_alcohol_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ADD CONSTRAINT `fk_fleet_vehicle_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= hazmat --> asset (9 constraint(s)) =========
-- Requires: hazmat schema, asset schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ADD CONSTRAINT `fk_hazmat_contingency_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= hazmat --> billing (5 constraint(s)) =========
-- Requires: hazmat schema, billing schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= hazmat --> compliance (21 constraint(s)) =========
-- Requires: hazmat schema, compliance schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tclp_test` ADD CONSTRAINT `fk_hazmat_tclp_test_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_training_certification_id` FOREIGN KEY (`training_certification_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_certification`(`training_certification_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`land_disposal_restriction` ADD CONSTRAINT `fk_hazmat_land_disposal_restriction_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ADD CONSTRAINT `fk_hazmat_storage_unit_inspection_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ADD CONSTRAINT `fk_hazmat_contingency_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ADD CONSTRAINT `fk_hazmat_waste_minimization_activity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ADD CONSTRAINT `fk_hazmat_exception_report_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= hazmat --> contract (5 constraint(s)) =========
-- Requires: hazmat schema, contract schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ADD CONSTRAINT `fk_hazmat_transporter_registration_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);

-- ========= hazmat --> customer (3 constraint(s)) =========
-- Requires: hazmat schema, customer schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= hazmat --> fleet (8 constraint(s)) =========
-- Requires: hazmat schema, fleet schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= hazmat --> landfill (1 constraint(s)) =========
-- Requires: hazmat schema, landfill schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);

-- ========= hazmat --> procurement (8 constraint(s)) =========
-- Requires: hazmat schema, procurement schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ADD CONSTRAINT `fk_hazmat_transporter_registration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= hazmat --> safety (17 constraint(s)) =========
-- Requires: hazmat schema, safety schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_ppe_issuance_id` FOREIGN KEY (`ppe_issuance_id`) REFERENCES `waste_management_ecm`.`safety`.`ppe_issuance`(`ppe_issuance_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `waste_management_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_emergency_action_plan_id` FOREIGN KEY (`emergency_action_plan_id`) REFERENCES `waste_management_ecm`.`safety`.`emergency_action_plan`(`emergency_action_plan_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `waste_management_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `waste_management_ecm`.`safety`.`meeting`(`meeting_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_safety_training_record_id` FOREIGN KEY (`safety_training_record_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_training_record`(`safety_training_record_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_emergency_action_plan_id` FOREIGN KEY (`emergency_action_plan_id`) REFERENCES `waste_management_ecm`.`safety`.`emergency_action_plan`(`emergency_action_plan_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_lockout_tagout_procedure_id` FOREIGN KEY (`lockout_tagout_procedure_id`) REFERENCES `waste_management_ecm`.`safety`.`lockout_tagout_procedure`(`lockout_tagout_procedure_id`);

-- ========= hazmat --> service (8 constraint(s)) =========
-- Requires: hazmat schema, service schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_service_authorization` ADD CONSTRAINT `fk_hazmat_transporter_service_authorization_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);

-- ========= hazmat --> sustainability (12 constraint(s)) =========
-- Requires: hazmat schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_tracked_site_id` FOREIGN KEY (`tracked_site_id`) REFERENCES `waste_management_ecm`.`sustainability`.`tracked_site`(`tracked_site_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_tracked_site_id` FOREIGN KEY (`tracked_site_id`) REFERENCES `waste_management_ecm`.`sustainability`.`tracked_site`(`tracked_site_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_fleet_fuel_consumption_id` FOREIGN KEY (`fleet_fuel_consumption_id`) REFERENCES `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption`(`fleet_fuel_consumption_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_fleet_fuel_consumption_id` FOREIGN KEY (`fleet_fuel_consumption_id`) REFERENCES `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption`(`fleet_fuel_consumption_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `waste_management_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `waste_management_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_minimization_activity` ADD CONSTRAINT `fk_hazmat_waste_minimization_activity_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);

-- ========= hazmat --> workforce (16 constraint(s)) =========
-- Requires: hazmat schema, workforce schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazwoper_training` ADD CONSTRAINT `fk_hazmat_hazwoper_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`emergency_response_incident` ADD CONSTRAINT `fk_hazmat_emergency_response_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit_inspection` ADD CONSTRAINT `fk_hazmat_storage_unit_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`contingency_plan` ADD CONSTRAINT `fk_hazmat_contingency_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`exception_report` ADD CONSTRAINT `fk_hazmat_exception_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= landfill --> asset (5 constraint(s)) =========
-- Requires: landfill schema, asset schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_site_epa_facility_id` FOREIGN KEY (`site_epa_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ADD CONSTRAINT `fk_landfill_cell_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`cell_equipment_assignment` ADD CONSTRAINT `fk_landfill_cell_equipment_assignment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);

-- ========= landfill --> billing (2 constraint(s)) =========
-- Requires: landfill schema, billing schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice_line`(`invoice_line_id`);

-- ========= landfill --> collection (4 constraint(s)) =========
-- Requires: landfill schema, collection schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);

-- ========= landfill --> compliance (17 constraint(s)) =========
-- Requires: landfill schema, compliance schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_monitoring_station_id` FOREIGN KEY (`monitoring_station_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_station`(`monitoring_station_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ADD CONSTRAINT `fk_landfill_groundwater_sample_compliance_environmental_monitoring_id` FOREIGN KEY (`compliance_environmental_monitoring_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring`(`compliance_environmental_monitoring_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`liner_integrity_event` ADD CONSTRAINT `fk_landfill_liner_integrity_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ADD CONSTRAINT `fk_landfill_disposal_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_compliance_environmental_monitoring_id` FOREIGN KEY (`compliance_environmental_monitoring_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring`(`compliance_environmental_monitoring_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`post_closure_monitoring` ADD CONSTRAINT `fk_landfill_post_closure_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`cell_permit_authorization` ADD CONSTRAINT `fk_landfill_cell_permit_authorization_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ADD CONSTRAINT `fk_landfill_collection_point_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= landfill --> contract (2 constraint(s)) =========
-- Requires: landfill schema, contract schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);

-- ========= landfill --> customer (5 constraint(s)) =========
-- Requires: landfill schema, customer schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);

-- ========= landfill --> energy (1 constraint(s)) =========
-- Requires: landfill schema, energy schema
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);

-- ========= landfill --> fleet (4 constraint(s)) =========
-- Requires: landfill schema, fleet schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`compaction_record` ADD CONSTRAINT `fk_landfill_compaction_record_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= landfill --> hazmat (2 constraint(s)) =========
-- Requires: landfill schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);

-- ========= landfill --> maintenance (4 constraint(s)) =========
-- Requires: landfill schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`compaction_record` ADD CONSTRAINT `fk_landfill_compaction_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= landfill --> procurement (2 constraint(s)) =========
-- Requires: landfill schema, procurement schema
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= landfill --> safety (13 constraint(s)) =========
-- Requires: landfill schema, safety schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ADD CONSTRAINT `fk_landfill_groundwater_sample_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`liner_integrity_event` ADD CONSTRAINT `fk_landfill_liner_integrity_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `waste_management_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`compaction_record` ADD CONSTRAINT `fk_landfill_compaction_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`compaction_record` ADD CONSTRAINT `fk_landfill_compaction_record_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`post_closure_monitoring` ADD CONSTRAINT `fk_landfill_post_closure_monitoring_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);

-- ========= landfill --> service (3 constraint(s)) =========
-- Requires: landfill schema, service schema
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`site_authorization` ADD CONSTRAINT `fk_landfill_site_authorization_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= landfill --> sustainability (7 constraint(s)) =========
-- Requires: landfill schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_tracked_site_id` FOREIGN KEY (`tracked_site_id`) REFERENCES `waste_management_ecm`.`sustainability`.`tracked_site`(`tracked_site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ADD CONSTRAINT `fk_landfill_cell_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ADD CONSTRAINT `fk_landfill_airspace_consumption_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_lfg_capture_id` FOREIGN KEY (`lfg_capture_id`) REFERENCES `waste_management_ecm`.`sustainability`.`lfg_capture`(`lfg_capture_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);

-- ========= landfill --> workforce (16 constraint(s)) =========
-- Requires: landfill schema, workforce schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_primary_daily_employee_id` FOREIGN KEY (`primary_daily_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ADD CONSTRAINT `fk_landfill_groundwater_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`liner_integrity_event` ADD CONSTRAINT `fk_landfill_liner_integrity_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`compaction_record` ADD CONSTRAINT `fk_landfill_compaction_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`post_closure_monitoring` ADD CONSTRAINT `fk_landfill_post_closure_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= maintenance --> asset (33 constraint(s)) =========
-- Requires: maintenance schema, asset schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`storeroom` ADD CONSTRAINT `fk_maintenance_storeroom_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`type` ADD CONSTRAINT `fk_maintenance_type_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`bulletin_compliance` ADD CONSTRAINT `fk_maintenance_bulletin_compliance_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`service_checklist_template` ADD CONSTRAINT `fk_maintenance_service_checklist_template_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_center` ADD CONSTRAINT `fk_maintenance_work_center_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_plan` ADD CONSTRAINT `fk_maintenance_maintenance_plan_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_plan` ADD CONSTRAINT `fk_maintenance_maintenance_plan_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_plan` ADD CONSTRAINT `fk_maintenance_maintenance_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= maintenance --> billing (5 constraint(s)) =========
-- Requires: maintenance schema, billing schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `waste_management_ecm`.`billing`.`adjustment`(`adjustment_id`);

-- ========= maintenance --> collection (2 constraint(s)) =========
-- Requires: maintenance schema, collection schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);

-- ========= maintenance --> compliance (14 constraint(s)) =========
-- Requires: maintenance schema, compliance schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`service_bulletin` ADD CONSTRAINT `fk_maintenance_service_bulletin_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`bulletin_compliance` ADD CONSTRAINT `fk_maintenance_bulletin_compliance_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= maintenance --> contract (5 constraint(s)) =========
-- Requires: maintenance schema, contract schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= maintenance --> energy (30 constraint(s)) =========
-- Requires: maintenance schema, energy schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= maintenance --> fleet (13 constraint(s)) =========
-- Requires: maintenance schema, fleet schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`bulletin_compliance` ADD CONSTRAINT `fk_maintenance_bulletin_compliance_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= maintenance --> hazmat (10 constraint(s)) =========
-- Requires: maintenance schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_hazwoper_training_id` FOREIGN KEY (`hazwoper_training_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazwoper_training`(`hazwoper_training_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_tclp_test_id` FOREIGN KEY (`tclp_test_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tclp_test`(`tclp_test_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_emergency_response_incident_id` FOREIGN KEY (`emergency_response_incident_id`) REFERENCES `waste_management_ecm`.`hazmat`.`emergency_response_incident`(`emergency_response_incident_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`incident_response_assignment` ADD CONSTRAINT `fk_maintenance_incident_response_assignment_emergency_response_incident_id` FOREIGN KEY (`emergency_response_incident_id`) REFERENCES `waste_management_ecm`.`hazmat`.`emergency_response_incident`(`emergency_response_incident_id`);

-- ========= maintenance --> landfill (10 constraint(s)) =========
-- Requires: maintenance schema, landfill schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`fluid_sample` ADD CONSTRAINT `fk_maintenance_fluid_sample_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= maintenance --> procurement (9 constraint(s)) =========
-- Requires: maintenance schema, procurement schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_inventory` ADD CONSTRAINT `fk_maintenance_parts_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`supply_agreement` ADD CONSTRAINT `fk_maintenance_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= maintenance --> safety (13 constraint(s)) =========
-- Requires: maintenance schema, safety schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_lockout_tagout_procedure_id` FOREIGN KEY (`lockout_tagout_procedure_id`) REFERENCES `waste_management_ecm`.`safety`.`lockout_tagout_procedure`(`lockout_tagout_procedure_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_near_miss_id` FOREIGN KEY (`near_miss_id`) REFERENCES `waste_management_ecm`.`safety`.`near_miss`(`near_miss_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_safety_training_record_id` FOREIGN KEY (`safety_training_record_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_training_record`(`safety_training_record_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_ppe_issuance_id` FOREIGN KEY (`ppe_issuance_id`) REFERENCES `waste_management_ecm`.`safety`.`ppe_issuance`(`ppe_issuance_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);

-- ========= maintenance --> service (6 constraint(s)) =========
-- Requires: maintenance schema, service schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= maintenance --> sustainability (8 constraint(s)) =========
-- Requires: maintenance schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_fleet_fuel_consumption_id` FOREIGN KEY (`fleet_fuel_consumption_id`) REFERENCES `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption`(`fleet_fuel_consumption_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);

-- ========= maintenance --> workforce (28 constraint(s)) =========
-- Requires: maintenance schema, workforce schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_tertiary_technician_confirmed_by_employee_id` FOREIGN KEY (`tertiary_technician_confirmed_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_dot_inspection` ADD CONSTRAINT `fk_maintenance_maintenance_dot_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`inspection_defect` ADD CONSTRAINT `fk_maintenance_inspection_defect_primary_inspection_employee_id` FOREIGN KEY (`primary_inspection_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`storeroom` ADD CONSTRAINT `fk_maintenance_storeroom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`cost` ADD CONSTRAINT `fk_maintenance_cost_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`bulletin_compliance` ADD CONSTRAINT `fk_maintenance_bulletin_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`subcontract_work` ADD CONSTRAINT `fk_maintenance_subcontract_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`warranty_claim` ADD CONSTRAINT `fk_maintenance_warranty_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`facility_maintenance_request` ADD CONSTRAINT `fk_maintenance_facility_maintenance_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`meter_reading` ADD CONSTRAINT `fk_maintenance_meter_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`budget` ADD CONSTRAINT `fk_maintenance_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`service_checklist_template` ADD CONSTRAINT `fk_maintenance_service_checklist_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_center` ADD CONSTRAINT `fk_maintenance_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_plan` ADD CONSTRAINT `fk_maintenance_maintenance_plan_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_plan` ADD CONSTRAINT `fk_maintenance_maintenance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`maintenance_plan` ADD CONSTRAINT `fk_maintenance_maintenance_plan_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> asset (6 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ADD CONSTRAINT `fk_procurement_material_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= procurement --> billing (3 constraint(s)) =========
-- Requires: procurement schema, billing schema
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_run_id` FOREIGN KEY (`run_id`) REFERENCES `waste_management_ecm`.`billing`.`run`(`run_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ADD CONSTRAINT `fk_procurement_ap_payment_run_id` FOREIGN KEY (`run_id`) REFERENCES `waste_management_ecm`.`billing`.`run`(`run_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= procurement --> contract (1 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_document_id` FOREIGN KEY (`document_id`) REFERENCES `waste_management_ecm`.`contract`.`document`(`document_id`);

-- ========= procurement --> hazmat (2 constraint(s)) =========
-- Requires: procurement schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);

-- ========= procurement --> landfill (2 constraint(s)) =========
-- Requires: procurement schema, landfill schema
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= procurement --> maintenance (3 constraint(s)) =========
-- Requires: procurement schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_storeroom_id` FOREIGN KEY (`storeroom_id`) REFERENCES `waste_management_ecm`.`maintenance`.`storeroom`(`storeroom_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_parts_catalog_id` FOREIGN KEY (`parts_catalog_id`) REFERENCES `waste_management_ecm`.`maintenance`.`parts_catalog`(`parts_catalog_id`);

-- ========= procurement --> safety (2 constraint(s)) =========
-- Requires: procurement schema, safety schema
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ADD CONSTRAINT `fk_procurement_material_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ADD CONSTRAINT `fk_procurement_sourcing_contract_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);

-- ========= procurement --> service (9 constraint(s)) =========
-- Requires: procurement schema, service schema
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ADD CONSTRAINT `fk_procurement_material_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ADD CONSTRAINT `fk_procurement_sourcing_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ADD CONSTRAINT `fk_procurement_sourcing_contract_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ADD CONSTRAINT `fk_procurement_vendor_waste_stream_approval_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= procurement --> workforce (31 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_tertiary_vendor_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_vendor_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_tertiary_service_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_service_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ADD CONSTRAINT `fk_procurement_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ADD CONSTRAINT `fk_procurement_sourcing_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ADD CONSTRAINT `fk_procurement_sourcing_contract_primary_sourcing_approved_by_employee_id` FOREIGN KEY (`primary_sourcing_approved_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_source_employee_id` FOREIGN KEY (`source_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_source_last_modified_by_user_employee_id` FOREIGN KEY (`source_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_primary_spend_employee_id` FOREIGN KEY (`primary_spend_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_tertiary_invoice_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_invoice_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_receiving_employee_id` FOREIGN KEY (`receiving_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ADD CONSTRAINT `fk_procurement_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= recycling --> asset (18 constraint(s)) =========
-- Requires: recycling schema, asset schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `waste_management_ecm`.`asset`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `waste_management_ecm`.`asset`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_location_id` FOREIGN KEY (`location_id`) REFERENCES `waste_management_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_inventory` ADD CONSTRAINT `fk_recycling_commodity_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_lifecycle_stage_id` FOREIGN KEY (`lifecycle_stage_id`) REFERENCES `waste_management_ecm`.`asset`.`lifecycle_stage`(`lifecycle_stage_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`material_composition` ADD CONSTRAINT `fk_recycling_material_composition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_buyer_contract` ADD CONSTRAINT `fk_recycling_recycling_buyer_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_program` ADD CONSTRAINT `fk_recycling_recycling_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`epa_recycling_report` ADD CONSTRAINT `fk_recycling_epa_recycling_report_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`epa_recycling_report` ADD CONSTRAINT `fk_recycling_epa_recycling_report_primary_epa_facility_id` FOREIGN KEY (`primary_epa_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= recycling --> collection (4 constraint(s)) =========
-- Requires: recycling schema, collection schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`material_composition` ADD CONSTRAINT `fk_recycling_material_composition_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= recycling --> compliance (13 constraint(s)) =========
-- Requires: recycling schema, compliance schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_sale` ADD CONSTRAINT `fk_recycling_commodity_sale_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_buyer_contract` ADD CONSTRAINT `fk_recycling_recycling_buyer_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`epa_recycling_report` ADD CONSTRAINT `fk_recycling_epa_recycling_report_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_regulatory_applicability` ADD CONSTRAINT `fk_recycling_commodity_regulatory_applicability_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`facility_permit` ADD CONSTRAINT `fk_recycling_facility_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= recycling --> contract (3 constraint(s)) =========
-- Requires: recycling schema, contract schema
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_buyer_contract` ADD CONSTRAINT `fk_recycling_recycling_buyer_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_buyer_contract` ADD CONSTRAINT `fk_recycling_recycling_buyer_contract_salesforce_contract_id` FOREIGN KEY (`salesforce_contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_program` ADD CONSTRAINT `fk_recycling_recycling_program_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= recycling --> customer (3 constraint(s)) =========
-- Requires: recycling schema, customer schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_program` ADD CONSTRAINT `fk_recycling_recycling_program_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= recycling --> energy (2 constraint(s)) =========
-- Requires: recycling schema, energy schema
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= recycling --> fleet (5 constraint(s)) =========
-- Requires: recycling schema, fleet schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= recycling --> hazmat (7 constraint(s)) =========
-- Requires: recycling schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`material_composition` ADD CONSTRAINT `fk_recycling_material_composition_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_tsdf_disposal_agreement` ADD CONSTRAINT `fk_recycling_mrf_tsdf_disposal_agreement_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`buyer_tsdf_return_agreement` ADD CONSTRAINT `fk_recycling_buyer_tsdf_return_agreement_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);

-- ========= recycling --> landfill (2 constraint(s)) =========
-- Requires: recycling schema, landfill schema
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= recycling --> maintenance (4 constraint(s)) =========
-- Requires: recycling schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);

-- ========= recycling --> procurement (12 constraint(s)) =========
-- Requires: recycling schema, procurement schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity` ADD CONSTRAINT `fk_recycling_commodity_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_sale` ADD CONSTRAINT `fk_recycling_commodity_sale_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_buyer_contract` ADD CONSTRAINT `fk_recycling_recycling_buyer_contract_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_supply_agreement` ADD CONSTRAINT `fk_recycling_commodity_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= recycling --> safety (14 constraint(s)) =========
-- Requires: recycling schema, safety schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_emergency_action_plan_id` FOREIGN KEY (`emergency_action_plan_id`) REFERENCES `waste_management_ecm`.`safety`.`emergency_action_plan`(`emergency_action_plan_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `waste_management_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_lockout_tagout_procedure_id` FOREIGN KEY (`lockout_tagout_procedure_id`) REFERENCES `waste_management_ecm`.`safety`.`lockout_tagout_procedure`(`lockout_tagout_procedure_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_loto_execution_id` FOREIGN KEY (`loto_execution_id`) REFERENCES `waste_management_ecm`.`safety`.`loto_execution`(`loto_execution_id`);

-- ========= recycling --> service (2 constraint(s)) =========
-- Requires: recycling schema, service schema
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_program` ADD CONSTRAINT `fk_recycling_recycling_program_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_acceptance` ADD CONSTRAINT `fk_recycling_commodity_acceptance_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= recycling --> sustainability (12 constraint(s)) =========
-- Requires: recycling schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_tracked_site_id` FOREIGN KEY (`tracked_site_id`) REFERENCES `waste_management_ecm`.`sustainability`.`tracked_site`(`tracked_site_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_fleet_fuel_consumption_id` FOREIGN KEY (`fleet_fuel_consumption_id`) REFERENCES `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption`(`fleet_fuel_consumption_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`material_composition` ADD CONSTRAINT `fk_recycling_material_composition_diversion_record_id` FOREIGN KEY (`diversion_record_id`) REFERENCES `waste_management_ecm`.`sustainability`.`diversion_record`(`diversion_record_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_program` ADD CONSTRAINT `fk_recycling_recycling_program_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`epa_recycling_report` ADD CONSTRAINT `fk_recycling_epa_recycling_report_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `waste_management_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`facility_initiative_participation` ADD CONSTRAINT `fk_recycling_facility_initiative_participation_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program_target_contribution` ADD CONSTRAINT `fk_recycling_program_target_contribution_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);

-- ========= recycling --> workforce (19 constraint(s)) =========
-- Requires: recycling schema, workforce schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale_inspection` ADD CONSTRAINT `fk_recycling_bale_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_sale` ADD CONSTRAINT `fk_recycling_commodity_sale_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_sale` ADD CONSTRAINT `fk_recycling_commodity_sale_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_sale` ADD CONSTRAINT `fk_recycling_commodity_sale_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`material_composition` ADD CONSTRAINT `fk_recycling_material_composition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_buyer_contract` ADD CONSTRAINT `fk_recycling_recycling_buyer_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`recycling_program` ADD CONSTRAINT `fk_recycling_recycling_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`equipment_certification` ADD CONSTRAINT `fk_recycling_equipment_certification_certifying_instructor_employee_id` FOREIGN KEY (`certifying_instructor_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`equipment_certification` ADD CONSTRAINT `fk_recycling_equipment_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= safety --> asset (22 constraint(s)) =========
-- Requires: safety schema, asset schema
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ADD CONSTRAINT `fk_safety_alert_acknowledgment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ADD CONSTRAINT `fk_safety_incentive_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= safety --> collection (7 constraint(s)) =========
-- Requires: safety schema, collection schema
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ADD CONSTRAINT `fk_safety_alert_acknowledgment_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ADD CONSTRAINT `fk_safety_incentive_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);

-- ========= safety --> compliance (15 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= safety --> contract (1 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_document_id` FOREIGN KEY (`document_id`) REFERENCES `waste_management_ecm`.`contract`.`document`(`document_id`);

-- ========= safety --> energy (33 constraint(s)) =========
-- Requires: safety schema, energy schema
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_combustion_operating_log_id` FOREIGN KEY (`combustion_operating_log_id`) REFERENCES `waste_management_ecm`.`energy`.`combustion_operating_log`(`combustion_operating_log_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= safety --> fleet (16 constraint(s)) =========
-- Requires: safety schema, fleet schema
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ADD CONSTRAINT `fk_safety_safety_training_record_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ADD CONSTRAINT `fk_safety_medical_case_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);

-- ========= safety --> hazmat (1 constraint(s)) =========
-- Requires: safety schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);

-- ========= safety --> maintenance (1 constraint(s)) =========
-- Requires: safety schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= safety --> procurement (7 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_disposal_purchase_order_id` FOREIGN KEY (`disposal_purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`disposal_purchase_order`(`disposal_purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ADD CONSTRAINT `fk_safety_safety_training_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ADD CONSTRAINT `fk_safety_medical_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> service (15 constraint(s)) =========
-- Requires: safety schema, service schema
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ADD CONSTRAINT `fk_safety_safety_training_record_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= safety --> workforce (52 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_primary_safety_coordinator_employee_id` FOREIGN KEY (`primary_safety_coordinator_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha` ADD CONSTRAINT `fk_safety_jha_jha_created_by_employee_id` FOREIGN KEY (`jha_created_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`jha_step` ADD CONSTRAINT `fk_safety_jha_step_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `waste_management_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_observation_observed_employee_id` FOREIGN KEY (`observation_observed_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_observation_observer_employee_id` FOREIGN KEY (`observation_observer_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_incident_investigator_employee_id` FOREIGN KEY (`incident_investigator_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_quaternary_corrective_last_modified_by_employee_id` FOREIGN KEY (`quaternary_corrective_last_modified_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_quinary_corrective_responsible_party_employee_id` FOREIGN KEY (`quinary_corrective_responsible_party_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_tertiary_corrective_created_by_employee_id` FOREIGN KEY (`tertiary_corrective_created_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting` ADD CONSTRAINT `fk_safety_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`meeting_attendance` ADD CONSTRAINT `fk_safety_meeting_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_audit_employee_id` FOREIGN KEY (`audit_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`safety_training_record` ADD CONSTRAINT `fk_safety_safety_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`near_miss` ADD CONSTRAINT `fk_safety_near_miss_tertiary_near_corrective_action_owner_employee_id` FOREIGN KEY (`tertiary_near_corrective_action_owner_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`lockout_tagout_procedure` ADD CONSTRAINT `fk_safety_lockout_tagout_procedure_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `waste_management_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_quaternary_loto_deviation_approved_by_employee_id` FOREIGN KEY (`quaternary_loto_deviation_approved_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_quinary_loto_supervisor_employee_id` FOREIGN KEY (`quinary_loto_supervisor_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`loto_execution` ADD CONSTRAINT `fk_safety_loto_execution_tertiary_loto_employee_id` FOREIGN KEY (`tertiary_loto_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_alert_issuing_employee_id` FOREIGN KEY (`alert_issuing_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`alert_acknowledgment` ADD CONSTRAINT `fk_safety_alert_acknowledgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ADD CONSTRAINT `fk_safety_medical_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`medical_case` ADD CONSTRAINT `fk_safety_medical_case_primary_medical_employee_id` FOREIGN KEY (`primary_medical_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`industrial_hygiene_sample` ADD CONSTRAINT `fk_safety_industrial_hygiene_sample_tertiary_industrial_reviewed_by_employee_id` FOREIGN KEY (`tertiary_industrial_reviewed_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ADD CONSTRAINT `fk_safety_incentive_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ADD CONSTRAINT `fk_safety_incentive_incentive_program_coordinator_employee_id` FOREIGN KEY (`incentive_program_coordinator_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`incentive` ADD CONSTRAINT `fk_safety_incentive_incentive_program_owner_employee_id` FOREIGN KEY (`incentive_program_owner_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_primary_emergency_coordinator_employee_id` FOREIGN KEY (`primary_emergency_coordinator_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_quaternary_emergency_approved_by_employee_id` FOREIGN KEY (`quaternary_emergency_approved_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`safety`.`emergency_action_plan` ADD CONSTRAINT `fk_safety_emergency_action_plan_tertiary_emergency_alternate_coordinator_employee_id` FOREIGN KEY (`tertiary_emergency_alternate_coordinator_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= service --> asset (11 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ADD CONSTRAINT `fk_service_container_type_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ADD CONSTRAINT `fk_service_srf_product_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_primary_mrf_facility_id` FOREIGN KEY (`primary_mrf_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= service --> collection (2 constraint(s)) =========
-- Requires: service schema, collection schema
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);

-- ========= service --> compliance (9 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`line` ADD CONSTRAINT `fk_service_line_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ADD CONSTRAINT `fk_service_waste_stream_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ADD CONSTRAINT `fk_service_srf_product_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ADD CONSTRAINT `fk_service_srf_product_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ADD CONSTRAINT `fk_service_offering_compliance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ADD CONSTRAINT `fk_service_area_regulatory_compliance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= service --> contract (1 constraint(s)) =========
-- Requires: service schema, contract schema
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= service --> energy (5 constraint(s)) =========
-- Requires: service schema, energy schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ADD CONSTRAINT `fk_service_waste_stream_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ADD CONSTRAINT `fk_service_srf_product_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);

-- ========= service --> landfill (2 constraint(s)) =========
-- Requires: service schema, landfill schema
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ADD CONSTRAINT `fk_service_disposal_network_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= service --> procurement (6 constraint(s)) =========
-- Requires: service schema, procurement schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`service`.`line` ADD CONSTRAINT `fk_service_line_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `waste_management_ecm`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ADD CONSTRAINT `fk_service_container_type_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ADD CONSTRAINT `fk_service_srf_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= service --> recycling (1 constraint(s)) =========
-- Requires: service schema, recycling schema
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity`(`commodity_id`);

-- ========= service --> safety (6 constraint(s)) =========
-- Requires: service schema, safety schema
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ADD CONSTRAINT `fk_service_offering_safety_compliance_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);

-- ========= service --> sustainability (6 constraint(s)) =========
-- Requires: service schema, sustainability schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ADD CONSTRAINT `fk_service_waste_stream_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);

-- ========= service --> workforce (10 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `waste_management_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `waste_management_ecm`.`service`.`line` ADD CONSTRAINT `fk_service_line_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ADD CONSTRAINT `fk_service_assignment_assigned_by_employee_id` FOREIGN KEY (`assigned_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ADD CONSTRAINT `fk_service_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ADD CONSTRAINT `fk_service_offering_safety_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ADD CONSTRAINT `fk_service_disposal_network_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ADD CONSTRAINT `fk_service_area_regulatory_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> asset (15 constraint(s)) =========
-- Requires: sustainability schema, asset schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ADD CONSTRAINT `fk_sustainability_renewable_energy_credit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ADD CONSTRAINT `fk_sustainability_circular_economy_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ADD CONSTRAINT `fk_sustainability_tracked_site_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ADD CONSTRAINT `fk_sustainability_ghg_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ADD CONSTRAINT `fk_sustainability_carbon_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= sustainability --> collection (1 constraint(s)) =========
-- Requires: sustainability schema, collection schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= sustainability --> compliance (4 constraint(s)) =========
-- Requires: sustainability schema, compliance schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= sustainability --> contract (3 constraint(s)) =========
-- Requires: sustainability schema, contract schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);

-- ========= sustainability --> customer (10 constraint(s)) =========
-- Requires: sustainability schema, customer schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ADD CONSTRAINT `fk_sustainability_reduction_target_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= sustainability --> energy (7 constraint(s)) =========
-- Requires: sustainability schema, energy schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ADD CONSTRAINT `fk_sustainability_initiative_milestone_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ADD CONSTRAINT `fk_sustainability_circular_economy_program_srf_production_line_id` FOREIGN KEY (`srf_production_line_id`) REFERENCES `waste_management_ecm`.`energy`.`srf_production_line`(`srf_production_line_id`);

-- ========= sustainability --> fleet (2 constraint(s)) =========
-- Requires: sustainability schema, fleet schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= sustainability --> procurement (18 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ADD CONSTRAINT `fk_sustainability_offset_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ADD CONSTRAINT `fk_sustainability_offset_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ADD CONSTRAINT `fk_sustainability_renewable_energy_credit_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ADD CONSTRAINT `fk_sustainability_renewable_energy_credit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ADD CONSTRAINT `fk_sustainability_circular_economy_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_fuel_purchase_id` FOREIGN KEY (`fuel_purchase_id`) REFERENCES `waste_management_ecm`.`procurement`.`fuel_purchase`(`fuel_purchase_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= sustainability --> safety (15 constraint(s)) =========
-- Requires: sustainability schema, safety schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `waste_management_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ADD CONSTRAINT `fk_sustainability_circular_economy_program_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ADD CONSTRAINT `fk_sustainability_tracked_site_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ADD CONSTRAINT `fk_sustainability_initiative_safety_analysis_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ADD CONSTRAINT `fk_sustainability_program_task_safety_requirement_jha_id` FOREIGN KEY (`jha_id`) REFERENCES `waste_management_ecm`.`safety`.`jha`(`jha_id`);

-- ========= sustainability --> workforce (25 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ADD CONSTRAINT `fk_sustainability_emission_source_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ADD CONSTRAINT `fk_sustainability_initiative_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ADD CONSTRAINT `fk_sustainability_initiative_milestone_quaternary_initiative_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_initiative_last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ADD CONSTRAINT `fk_sustainability_initiative_milestone_tertiary_initiative_employee_id` FOREIGN KEY (`tertiary_initiative_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ADD CONSTRAINT `fk_sustainability_renewable_energy_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ADD CONSTRAINT `fk_sustainability_reduction_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ADD CONSTRAINT `fk_sustainability_circular_economy_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_primary_sustainability_employee_id` FOREIGN KEY (`primary_sustainability_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ADD CONSTRAINT `fk_sustainability_tracked_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ADD CONSTRAINT `fk_sustainability_report_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ADD CONSTRAINT `fk_sustainability_carbon_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ADD CONSTRAINT `fk_sustainability_initiative_safety_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ADD CONSTRAINT `fk_sustainability_program_task_safety_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ADD CONSTRAINT `fk_sustainability_program_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> asset (13 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ADD CONSTRAINT `fk_workforce_job_position_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ADD CONSTRAINT `fk_workforce_dot_drug_test_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ADD CONSTRAINT `fk_workforce_workers_comp_claim_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ADD CONSTRAINT `fk_workforce_cost_center_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= workforce --> billing (1 constraint(s)) =========
-- Requires: workforce schema, billing schema
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_run_id` FOREIGN KEY (`run_id`) REFERENCES `waste_management_ecm`.`billing`.`run`(`run_id`);

-- ========= workforce --> collection (5 constraint(s)) =========
-- Requires: workforce schema, collection schema
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ADD CONSTRAINT `fk_workforce_workers_comp_claim_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= workforce --> compliance (4 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ADD CONSTRAINT `fk_workforce_workforce_training_record_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ADD CONSTRAINT `fk_workforce_workers_comp_claim_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);

-- ========= workforce --> landfill (4 constraint(s)) =========
-- Requires: workforce schema, landfill schema
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);

-- ========= workforce --> maintenance (1 constraint(s)) =========
-- Requires: workforce schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= workforce --> safety (4 constraint(s)) =========
-- Requires: workforce schema, safety schema
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `waste_management_ecm`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ADD CONSTRAINT `fk_workforce_dot_drug_test_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `waste_management_ecm`.`safety`.`incident`(`incident_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ADD CONSTRAINT `fk_workforce_workers_comp_claim_medical_case_id` FOREIGN KEY (`medical_case_id`) REFERENCES `waste_management_ecm`.`safety`.`medical_case`(`medical_case_id`);

-- ========= workforce --> service (6 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

